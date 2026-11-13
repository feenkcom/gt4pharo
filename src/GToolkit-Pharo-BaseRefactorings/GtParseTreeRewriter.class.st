"
A non-destructive subclass of OCParseTreeRewriter. executeTree: makes one working copy of the input; inherited visitors update that copy without copying visited nodes again. Uses inherited rule registration and execution. performSearches:on: validates the root syntactic category of returned replacements and wraps errors from matching or replacement in GtParseTreeRewriteError, retaining the original exception. Existing rewrite errors propagate without being wrapped again. Replacement children are the creator's responsibility. The only custom node visitor handles cascades and requires structurally equal receivers, with a fast path when no cascade messages match directly. Mostly immutable comment nodes may be shared. Replacement comments follow the standard rules; cascade assembly preserves comments when receivers are unified or replacement cascades are flattened. Original nodes are located on demand by equality and start/stop positions for diagnostics. Retrieve the result using tree.
"
Class {
	#name : #GtParseTreeRewriter,
	#superclass : #OCParseTreeRewriter,
	#instVars : [
		'originalTree'
	],
	#category : #'GToolkit-Pharo-BaseRefactorings-Rewriting'
}

{ #category : #rewriting }
GtParseTreeRewriter >> commentKey: aComment [
	^ {aComment start.
		aComment stop.
		aComment contents}
]

{ #category : #rewriting }
GtParseTreeRewriter >> commentsIn: aNode [
	| comments keys |
	comments := OrderedCollection new.
	keys := Set new.
	aNode
		nodesDo: [ :each | 
			each isCommentNode
				ifTrue: [ | key |
					key := self commentKey: each.
					(keys includes: key)
						ifFalse: [ keys add: key.
							comments add: each ] ] ].
	^ comments
]

{ #category : #rewriting }
GtParseTreeRewriter >> executeTree: aParseTree [
	| oldContext workingTree result |
	oldContext := context.
	context := SmallDictionary new.
	originalTree := aParseTree.
	tree := nil.
	answer := false.
	[ workingTree := aParseTree copy.
	workingTree parent: nil.
	result := self visitNode: workingTree.
	result parent: nil.
	result isMethod ifTrue: [ result clearReplacements ].
	tree := result ]
		ensure: [ context := oldContext.
			originalTree := nil ].
	^ answer
]

{ #category : #rewriting }
GtParseTreeRewriter >> isDeclaration: aNode [
	^ aNode isVariable and: [ aNode isPseudoVariable not ]
]

{ #category : #rewriting }
GtParseTreeRewriter >> originalNodeFor: aNode [
	originalTree
		ifNotNil: [ originalTree
				nodesDo: [ :each | 
					(each start = aNode start and: [ each stop = aNode stop and: [ each = aNode ] ])
						ifTrue: [ ^ each ] ] ].
	^ aNode
]

{ #category : #rewriting }
GtParseTreeRewriter >> performSearches: aSearchCollection on: aNode [
	| replacement |
	replacement := [ super performSearches: aSearchCollection on: aNode ]
			on: Error
			do: [ :error | 
				(error isKindOf: GtParseTreeRewriteError) ifTrue: [ error pass ].
				GtParseTreeRewriteError new
					node: (self originalNodeFor: aNode);
					originalError: error;
					messageText: 'Error while matching or replacing: ' , error messageText;
					signal ].
	replacement ifNotNil: [ self validateReplacement: replacement for: aNode ].
	^ replacement
]

{ #category : #rewriting }
GtParseTreeRewriter >> preserveCommentsFrom: aNode in: aReplacement [
	| present missing comments |
	present := ((self commentsIn: aReplacement)
			collect: [ :each | self commentKey: each ]) asSet.
	missing := (self commentsIn: aNode)
			reject: [ :comment | present includes: (self commentKey: comment) ].
	missing
		ifNotEmpty: [ comments := aReplacement comments asArray , missing asArray.
			aReplacement
				comments: (comments sorted: [ :left :right | left start < right start ]) ]
]

{ #category : #rewriting }
GtParseTreeRewriter >> reject: aReplacement for: aNode because: aString [
	^ GtParseTreeRewriteError new
		node: (self originalNodeFor: aNode);
		replacementNode: aReplacement;
		messageText: aString;
		signal
]

{ #category : #rewriting }
GtParseTreeRewriter >> replacement: aReplacement fits: aNode [
	| parent |
	parent := aNode parent.
	parent
		ifNil: [ aNode isMethod ifTrue: [ ^ aReplacement isMethod ].
			aNode isSequence ifTrue: [ ^ aReplacement isSequence ].
			aNode isPragma ifTrue: [ ^ aReplacement isPragma ].
			aNode isReturn
				ifTrue: [ ^ aReplacement isReturn or: [ aReplacement isValue ] ].
			^ aReplacement isValue ].
	parent isCascade
		ifTrue: [ ^ aReplacement isMessage or: [ aReplacement isCascade ] ].
	parent isAssignment
		ifTrue: [ ^ parent variable == aNode
				ifTrue: [ self isDeclaration: aReplacement ]
				ifFalse: [ aReplacement isValue ] ].
	(parent isMethod or: [ parent isKindOf: OCBlockNode ])
		ifTrue: [ parent body == aNode ifTrue: [ ^ aReplacement isSequence ].
			(parent arguments anySatisfy: [ :each | each == aNode ])
				ifTrue: [ ^ self isDeclaration: aReplacement ].
			parent isMethod ifTrue: [ ^ aReplacement isPragma ] ].
	parent isSequence
		ifTrue: [ (parent temporaries anySatisfy: [ :each | each == aNode ])
				ifTrue: [ ^ self isDeclaration: aReplacement ].
			^ aReplacement isValue or: [ aReplacement isReturn ] ].
	(parent isPragma or: [ parent isLiteralArray ])
		ifTrue: [ ^ aReplacement isLiteralNode or: [ aReplacement isLiteralArray ] ].
	^ aReplacement isValue
]

{ #category : #rewriting }
GtParseTreeRewriter >> validateReplacement: aReplacement for: aNode [
	(aReplacement isKindOf: OCProgramNode)
		ifFalse: [ ^ self
				reject: aReplacement
				for: aNode
				because: 'A replacement must be an AST node' ].
	(self replacement: aReplacement fits: aNode)
		ifFalse: [ self
				reject: aReplacement
				for: aNode
				because: 'Replacement node is incompatible with its syntactic position' ]
]

{ #category : #rewriting }
GtParseTreeRewriter >> visitCascadeNode: aCascadeNode [
	| replacements receiver newMessages origins baseline originalSize |
	originalSize := aCascadeNode messages size.
	replacements := aCascadeNode messages
			collect: [ :each | self performSearches: searches on: each ].
	(replacements allSatisfy: [ :each | each isNil ])
		ifTrue: [ receiver := self visitNode: aCascadeNode receiver.
			aCascadeNode messages
				do: [ :each | 
					each receiver: receiver.
					each
						arguments: (each arguments collect: [ :argument | self visitNode: argument ]) ].
			^ aCascadeNode ].
	(replacements anySatisfy: [ :each | each isNil ])
		ifTrue: [ receiver := self visitNode: aCascadeNode receiver ].
	newMessages := OrderedCollection new.
	origins := OrderedCollection new.
	aCascadeNode messages
		with: replacements
		do: [ :old :replacement | 
			| rewritten |
			rewritten := replacement
					ifNil: [ old
							receiver: receiver;
							arguments: (old arguments collect: [ :each | self visitNode: each ]);
							yourself ].
			rewritten isCascade
				ifTrue: [ rewritten messages
						do: [ :each | 
							newMessages add: each.
							origins add: old ] ]
				ifFalse: [ newMessages add: rewritten.
					origins add: old ] ].
	baseline := receiver ifNil: [ newMessages first receiver ].
	newMessages
		with: origins
		do: [ :message :old | 
			message receiver = baseline
				ifFalse: [ self
						reject: message
						for: old
						because: 'Cascade messages must have the same receiver' ] ].
	newMessages do: [ :each | self preserveCommentsFrom: each receiver in: baseline ].
	newMessages do: [ :each | each receiver: baseline ].
	aCascadeNode messages: newMessages.
	newMessages size = originalSize
		ifFalse: [ aCascadeNode
				semicolons: (Array new: (newMessages size - 1 max: 0) withAll: aCascadeNode start) ].
	replacements
		do: [ :each | each ifNotNil: [ self preserveCommentsFrom: each in: aCascadeNode ] ].
	^ aCascadeNode
]
