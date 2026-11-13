Class {
	#name : #GtParseTreeRewriterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-BaseRefactorings-Examples'
}

{ #category : #examples }
GtParseTreeRewriterExamples >> allCascadeReceiversChange [
	<gtExample>
	| result |
	result := self
			rewrite: 'example aStream print: object; print: object'
			from: '``@rcvr print: ``@obj'
			to: '``@obj printOn: ``@rcvr'.
	self
		assert: (result body statements first messages
				allSatisfy: [ :each | each receiver name = 'object' and: [ each selector = #printOn: ] ]).
	^ result
]

{ #category : #examples }
GtParseTreeRewriterExamples >> allCascadeReceiversDisagree [
	<gtExample>
	| ast rewriter error |
	ast := OCParser parseMethod: 'example aStream print: first; print: second'.
	rewriter := GtParseTreeRewriter new.
	rewriter replace: '``@rcvr print: ``@obj' with: '``@obj printOn: ``@rcvr'.
	error := self errorDuring: [ rewriter executeTree: ast ].
	self assert: error node == ast body statements first messages last.
	^ error
]

{ #category : #examples }
GtParseTreeRewriterExamples >> argumentDeclarationCannotBecomeLiteral [
	<gtExample>
	| rewriter |
	rewriter := GtParseTreeRewriter new.
	rewriter
		replaceArgument: 'argument'
		withValueFrom: [ :node | OCParser parseExpression: '42' ].
	^ self
		errorDuring: [ rewriter executeTree: (OCParser parseMethod: 'example: argument ^ argument') ]
]

{ #category : #examples }
GtParseTreeRewriterExamples >> blockCannotMutateInput [
	<gtExample>
	| ast rewriter original |
	ast := OCParser parseMethod: 'example ^ self oldName'.
	original := ast formattedCode.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: 'self oldName'
		withValueFrom: [ :node | 
			node selector: #newName.
			node ].
	rewriter executeTree: ast.
	self assert: ast formattedCode equals: original.
	self
		assert: rewriter tree body statements first value selector
		equals: #newName.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> blockControlsReplacementComments [
	<gtExample>
	| ast rewriter comments |
	ast := OCParser parseMethod: 'example "outside" ^ self old: (1 "discarded")'.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '``@receiver old: ``@arg'
		withValueFrom: [ :node | OCParser parseExpression: '2 "created"' ].
	rewriter executeTree: ast.
	comments := (rewriter
			commentsIn: (OCParser parseMethod: rewriter tree formattedCode))
			collect: [ :each | each contents ].
	self assert: (comments includes: 'outside').
	self assert: (comments includes: 'created').
	self assert: (comments includes: 'discarded') not.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> cascadeArgumentRewrite [
	<gtExample>
	^ self
		rewrite: 'example stream print: object oldName; cr'
		from: '``@rcvr oldName'
		to: '``@rcvr newName'
]

{ #category : #examples }
GtParseTreeRewriterExamples >> cascadeBlockControlsComments [
	<gtExample>
	| ast rewriter comments |
	ast := OCParser parseMethod: 'example stream old: (1 "discarded"); cr'.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '``@receiver old: ``@arg'
		withValueFrom: [ :node | OCParser parseExpression: 'stream new: (2 "created")' ].
	rewriter executeTree: ast.
	comments := (rewriter
			commentsIn: (OCParser parseMethod: rewriter tree formattedCode))
			collect: [ :each | each contents ].
	self assert: (comments includes: 'created').
	self assert: (comments includes: 'discarded') not.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> cascadeExpansionPreservesComments [
	<gtExample>
	| rewriter ast comments |
	ast := OCParser parseMethod: 'example stream old; cr'.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '``@receiver old'
		withValueFrom: [ :node | 
			| replacement |
			replacement := OCParser parseExpression: 'stream first; second'.
			replacement comments: {OCCommentNode with: 'expanded cascade' at: 1}.
			replacement ].
	rewriter executeTree: ast.
	self assert: rewriter tree body statements first messages size equals: 3.
	comments := rewriter
			commentsIn: (OCParser parseMethod: rewriter tree formattedCode).
	self
		assert: (comments anySatisfy: [ :each | each contents = 'expanded cascade' ]).
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> cascadeReceiverCommentsPreserved [
	<gtExample>
	| rewriter ast comments |
	ast := OCParser parseMethod: 'example stream first; second'.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '``@receiver first'
		withValueFrom: [ :node | OCParser parseExpression: 'target "first receiver" first' ].
	rewriter
		replace: '``@receiver second'
		withValueFrom: [ :node | OCParser parseExpression: 'target "second receiver" second' ].
	rewriter executeTree: ast.
	comments := (rewriter
			commentsIn: (OCParser parseMethod: rewriter tree formattedCode))
			collect: [ :each | each contents ].
	self assert: (comments includes: 'first receiver').
	self assert: (comments includes: 'second receiver').
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> commentsOnDiscardedSubtrees [
	<gtExample>
	| ast rewriter before after reparsed |
	ast := OCParser
			parseMethod: 'example
 "method"
 ^ (self "receiver" old: (1 "argument")) "tail"'.
	rewriter := GtParseTreeRewriter new.
	rewriter replace: '``@receiver old: ``@arg' with: '2'.
	before := (rewriter commentsIn: ast) collect: [ :each | each contents ].
	rewriter executeTree: ast.
	reparsed := OCParser parseMethod: rewriter tree formattedCode.
	after := (rewriter commentsIn: reparsed) collect: [ :each | each contents ].
	self assert: after asBag equals: before asBag.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> declarationRules [
	<gtExample>
	| ast rewriter |
	ast := OCParser
			parseMethod: 'example: argument | temporary | ^ [ :blockArgument | argument ]'.
	rewriter := GtParseTreeRewriter new.
	rewriter replaceArgument: 'argument' with: 'renamedArgument'.
	rewriter replaceArgument: 'temporary' with: 'renamedTemporary'.
	rewriter replaceArgument: 'blockArgument' with: 'renamedBlockArgument'.
	self assert: (rewriter executeTree: ast).
	self assert: rewriter tree arguments first name equals: 'renamedArgument'.
	self
		assert: rewriter tree body temporaries first name
		equals: 'renamedTemporary'.
	self
		assert: rewriter tree body statements first value arguments first name
		equals: 'renamedBlockArgument'.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> enclosingStringRewriteUsesStandardComments [
	<gtExample>
	| results |
	results := {OCParseTreeRewriter.
			GtParseTreeRewriter}
			collect: [ :rewriterClass | 
				| ast rewriter |
				ast := OCParser
						parseMethod: 'example ^ self outer: (self inner: (1 "discarded"))'.
				rewriter := rewriterClass new.
				rewriter
					replace: '``@receiver outer: ``@arg'
					with: '``@receiver renamed: ``@arg'.
				rewriter
					replace: '``@receiver inner: ``@arg'
					withValueFrom: [ :node | OCParser parseExpression: '2 "created"' ].
				rewriter executeTree: ast.
				rewriter tree ].
	self assert: results first formattedCode equals: results second formattedCode.
	^ results second
]

{ #category : #helpers }
GtParseTreeRewriterExamples >> errorDuring: aBlock [
	^ [ aBlock value.
	self error: 'Expected a rewrite error' ]
		on: GtParseTreeRewriteError
		do: [ :error | error ]
]

{ #category : #examples }
GtParseTreeRewriterExamples >> existingSourceReplacements [
	<gtExample>
	| ast first second |
	ast := OCParser parseMethod: 'example ^ 1'.
	first := OCParseTreeRewriter new.
	first replace: '1' with: '2'.
	first executeTree: ast.
	second := GtParseTreeRewriter new.
	second replace: '2' with: '3'.
	self assert: (second executeTree: first tree).
	self assert: (OCParser parseMethod: second tree newSource) equals: second tree.
	self assert: first tree body statements first value value equals: 2.
	^ second tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> inconsistentCascade [
	<gtExample>
	| ast rewriter error |
	ast := OCParser
			parseMethod: 'printOn: aStream
 "Put a printed version of the receiver onto aStream."
 aStream nextPutAll: self class name; nextPutAll: '': ''; print: file name'.
	rewriter := GtParseTreeRewriter new.
	rewriter replace: '``@rcvr print: ``@obj' with: '``@obj printOn: ``@rcvr'.
	error := self errorDuring: [ rewriter executeTree: ast ].
	self assert: error node == ast body statements first messages last.
	self assert: error node parent == ast body statements first.
	self assert: error replacementNode receiver formattedCode equals: 'file name'.
	self assert: rewriter tree isNil.
	^ error
]

{ #category : #examples }
GtParseTreeRewriterExamples >> invalidReplacementValues [
	<gtExample>
	^ {nil.
		42.
		'not an AST'}
		collect: [ :value | 
			| ast rewriter error |
			ast := OCParser parseMethod: 'example ^ 42'.
			rewriter := GtParseTreeRewriter new.
			rewriter replace: '42' withValueFrom: [ :node | value ].
			error := self errorDuring: [ rewriter executeTree: ast ].
			self assert: error node == ast body statements first value.
			self assert: error originalError class equals: MessageNotUnderstood.
			self assert: error originalError receiver == value.
			self assert: rewriter tree isNil.
			error ]
]

{ #category : #examples }
GtParseTreeRewriterExamples >> literalCannotBecomeSequence [
	<gtExample>
	| ast rewriter error |
	ast := OCParser parseMethod: 'example ^ 42'.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '42'
		withValueFrom: [ :node | (OCParser parseMethod: 'replacement 1. 2') body ].
	error := self errorDuring: [ rewriter executeTree: ast ].
	self assert: error node == ast body statements first value.
	self assert: error replacementNode isSequence.
	^ error
]

{ #category : #examples }
GtParseTreeRewriterExamples >> literalOnlyPositions [
	<gtExample>
	^ #('example <tag: 42> ^ self' 'example ^ #(42)')
		collect: [ :source | 
			| rewriter |
			rewriter := GtParseTreeRewriter new.
			rewriter
				replace: '42'
				withValueFrom: [ :node | OCParser parseExpression: 'self foo' ].
			self errorDuring: [ rewriter executeTree: (OCParser parseMethod: source) ] ]
]

{ #category : #examples }
GtParseTreeRewriterExamples >> malformedReplacementSubtrees [
	"Only the replacement's top-level type is checked; its creator owns its children."

	<gtExample>
	| replacements |
	replacements := {(OCParser parseExpression: 'self foo: 1')
				arguments: #();
				yourself.
			(OCParser parseExpression: '[ 1 ]')
				body: (OCParser parseExpression: '42');
				yourself.
			(OCParser parseExpression: 'x := 1')
				variable: (OCParser parseExpression: '42');
				yourself}.
	replacements
		do: [ :replacement | 
			| rewriter |
			rewriter := GtParseTreeRewriter new.
			rewriter replace: '42' withValueFrom: [ :node | replacement ].
			self assert: (rewriter executeTree: (OCParser parseMethod: 'example ^ 42')).
			self
				assert: rewriter tree body statements first value class
				equals: replacement class ].
	^ replacements collect: [ :each | each class ]
]

{ #category : #examples }
GtParseTreeRewriterExamples >> matchingCodeError [
	<gtExample>
	| ast rewriter cause error |
	ast := OCParser parseMethod: 'example ^ self old'.
	cause := Error new messageText: 'Matching failed'.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: 'self old'
		with: 'self new'
		when: [ :node | cause signal ].
	error := self errorDuring: [ rewriter executeTree: ast ].
	self assert: error node == ast body statements first value.
	self assert: error originalError == cause.
	self assert: (error messageText includesSubstring: cause messageText).
	self assert: rewriter tree isNil.
	^ error
]

{ #category : #examples }
GtParseTreeRewriterExamples >> methodAndTreeRules [
	<gtExample>
	| ast rewriter |
	ast := OCParser parseMethod: 'example ^ 1'.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replaceMethod: 'example ^ 1'
		with: 'example ^ 2'
		when: [ :node | true ].
	self assert: (rewriter executeTree: ast).
	self assert: rewriter tree body statements first value value equals: 2.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replaceTree: (OCParser parseExpression: '1')
		withTree: (OCParser parseExpression: '3')
		when: [ :node | true ].
	self assert: (rewriter executeTree: ast).
	self assert: rewriter tree body statements first value value equals: 3.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> nestedCompositeNodes [
	<gtExample>
	^ self
		rewrite: 'example: argument
 <tag: 1>
 | temp |
 temp := [ :blockArgument | | local | local := { argument oldName. #(1 2) }. ^ local ].
 ^ temp'
		from: '``@receiver oldName'
		to: '``@receiver newName'
]

{ #category : #examples }
GtParseTreeRewriterExamples >> nestedReplacementErrorPreservesNode [
	<gtExample>
	| ast rewriter cause error expected |
	ast := OCParser parseMethod: 'example ^ self outer: 42'.
	expected := ast body statements first value arguments first.
	cause := Error new messageText: 'Inner replacement failed'.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '``@receiver outer: ``@argument'
		with: '``@receiver renamed: ``@argument'.
	rewriter replace: '42' withValueFrom: [ :node | cause signal ].
	error := self errorDuring: [ rewriter executeTree: ast ].
	self assert: error node == expected.
	self assert: error originalError == cause.
	^ error
]

{ #category : #examples }
GtParseTreeRewriterExamples >> nestedValidationErrorIsNotWrapped [
	<gtExample>
	| ast rewriter error expected |
	ast := OCParser parseMethod: 'example ^ self outer: 42'.
	expected := ast body statements first value arguments first.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '``@receiver outer: ``@argument'
		with: '``@receiver renamed: ``@argument'.
	rewriter
		replace: '42'
		withValueFrom: [ :node | (OCParser parseMethod: 'replacement 1. 2') body ].
	error := self errorDuring: [ rewriter executeTree: ast ].
	self assert: error node == expected.
	self assert: error originalError isNil.
	self assert: error replacementNode isSequence.
	^ error
]

{ #category : #examples }
GtParseTreeRewriterExamples >> noMatchLeavesInputUnchanged [
	<gtExample>
	| ast rewriter |
	ast := OCParser parseMethod: 'example "comment" ^ 1'.
	rewriter := GtParseTreeRewriter new.
	rewriter replace: '2' with: '3'.
	self assert: (rewriter executeTree: ast) not.
	self assert: rewriter tree equals: ast.
	self assert: rewriter tree ~~ ast.
	self assert: rewriter tree body statements first ~~ ast body statements first.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> nonMessageInCascade [
	<gtExample>
	| rewriter |
	rewriter := GtParseTreeRewriter new.
	rewriter replace: '``@receiver print: ``@object' with: '42'.
	^ self
		errorDuring: [ rewriter
				executeTree: (OCParser parseMethod: 'example stream cr; print: object') ]
]

{ #category : #examples }
GtParseTreeRewriterExamples >> originalNodeLookupDistinguishesEqualNodes [
	<gtExample>
	| ast cascade expected rewriter error |
	ast := OCParser parseMethod: 'example stream print: object; cr; print: object'.
	cascade := ast body statements first.
	expected := cascade messages last.
	self assert: cascade messages first equals: expected.
	self assert: cascade messages first stop ~= expected stop.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '``@receiver print: ``@object'
		with: '``@object printOn: ``@receiver'
		when: [ :node | node stop = expected stop ].
	error := self errorDuring: [ rewriter executeTree: ast ].
	self assert: error node == expected.
	self assert: error node parent == cascade.
	^ error
]

{ #category : #examples }
GtParseTreeRewriterExamples >> receiverChangeInEveryCascadePosition [
	<gtExample>
	^ #('example stream print: object; cr; flush' 'example stream cr; print: object; flush' 'example stream cr; flush; print: object')
		collect: [ :source | 
			| ast rewriter error |
			ast := OCParser parseMethod: source.
			rewriter := GtParseTreeRewriter new.
			rewriter
				replace: '``@receiver print: ``@object'
				with: '``@object printOn: ``@receiver'.
			error := self errorDuring: [ rewriter executeTree: ast ].
			self assert: error node selector equals: #print:.
			error ]
]

{ #category : #examples }
GtParseTreeRewriterExamples >> repeatedCommentsPreserved [
	<gtExample>
	| ast rewriter comments |
	ast := OCParser parseMethod: 'example ^ self old: (1 "same") with: (2 "same")'.
	rewriter := GtParseTreeRewriter new.
	rewriter replace: '``@receiver old: ``@a with: ``@b' with: '42'.
	rewriter executeTree: ast.
	comments := rewriter
			commentsIn: (OCParser parseMethod: rewriter tree formattedCode).
	self assert: (comments count: [ :each | each contents = 'same' ]) equals: 2.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> replacementCodeError [
	<gtExample>
	| ast rewriter cause error |
	ast := OCParser parseMethod: 'example ^ 42'.
	cause := Error new messageText: 'Replacement failed'.
	rewriter := GtParseTreeRewriter new.
	rewriter replace: '42' withValueFrom: [ :node | cause signal ].
	error := self errorDuring: [ rewriter executeTree: ast ].
	self assert: error node == ast body statements first value.
	self assert: error originalError == cause.
	self assert: (error messageText includesSubstring: cause messageText).
	self assert: rewriter tree isNil.
	^ error
]

{ #category : #examples }
GtParseTreeRewriterExamples >> resultNodesAreIndependent [
	<gtExample>
	| ast rewriter inputNodes |
	ast := OCParser parseMethod: 'example "method comment" ^ self oldName'.
	inputNodes := ast allChildren reject: [ :each | each isCommentNode ].
	rewriter := GtParseTreeRewriter new.
	rewriter replace: 'self oldName' with: 'self newName'.
	rewriter executeTree: ast.
	rewriter tree
		nodesDo: [ :resultNode | 
			resultNode isCommentNode
				ifFalse: [ self
						assert: (inputNodes noneSatisfy: [ :inputNode | inputNode == resultNode ]) ] ].
	self assert: rewriter tree comments first == ast comments first.
	^ rewriter tree
]

{ #category : #helpers }
GtParseTreeRewriterExamples >> rewrite: source from: pattern to: replacement [
	| ast rewriter originalCode parents nodes |
	ast := OCParser parseMethod: source.
	originalCode := ast formattedCode.
	nodes := ast allChildren.
	parents := nodes collect: [ :each | each parent ].
	rewriter := GtParseTreeRewriter new.
	rewriter replace: pattern with: replacement.
	self assert: (rewriter executeTree: ast).
	self assert: ast formattedCode equals: originalCode.
	nodes with: parents do: [ :node :parent | self assert: node parent == parent ].
	self assert: rewriter tree ~~ ast.
	self
		assert: (OCParser parseMethod: rewriter tree formattedCode)
		equals: rewriter tree.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> rewriterReusableAfterFailure [
	<gtExample>
	| rewriter |
	rewriter := GtParseTreeRewriter new.
	rewriter
		replace: '``@receiver print: ``@object'
		with: '``@object printOn: ``@receiver'.
	self
		errorDuring: [ rewriter
				executeTree: (OCParser parseMethod: 'example stream cr; print: object') ].
	self
		assert: (rewriter executeTree: (OCParser parseMethod: 'example stream print: object')).
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> rewritesTheSingleWorkingCopy [
	<gtExample>
	| source ast rewriter workingRoot workingMessage |
	source := 'example ^ {self unchanged. self old}'.
	ast := OCParser parseMethod: source.
	rewriter := GtParseTreeRewriter new.
	rewriter
		replaceMethod: source
		with: 'example ^ 0'
		when: [ :node | 
			workingRoot := node.
			false ].
	rewriter
		replace: 'self unchanged'
		with: 'self replacement'
		when: [ :node | 
			workingMessage := node.
			false ].
	rewriter replace: 'self old' with: 'self new'.
	self assert: (rewriter executeTree: ast).
	self assert: rewriter tree == workingRoot.
	self
		assert: rewriter tree body statements first value statements first == workingMessage.
	self assert: rewriter tree ~~ ast.
	self
		assert: ast body statements first value statements last selector
		equals: #old.
	^ rewriter tree
]

{ #category : #examples }
GtParseTreeRewriterExamples >> selectorOnlyCascadeRewrite [
	<gtExample>
	^ self
		rewrite: 'example stream nextPutAll: ''hello''; print: object'
		from: '``@rcvr print: ``@obj'
		to: '``@rcvr display: ``@obj'
]

{ #category : #examples }
GtParseTreeRewriterExamples >> sharedCascadeReceiverRewrite [
	<gtExample>
	^ self
		rewrite: 'example (self oldStream) print: object; cr'
		from: 'self oldStream'
		to: 'self newStream'
]

{ #category : #examples }
GtParseTreeRewriterExamples >> standaloneReceiverChange [
	<gtExample>
	| result |
	result := self
			rewrite: 'example: aStream ^ aStream print: file name'
			from: '``@rcvr print: ``@obj'
			to: '``@obj printOn: ``@rcvr'.
	self
		assert: result body statements first value receiver formattedCode
		equals: 'file name'.
	^ result
]

{ #category : #examples }
GtParseTreeRewriterExamples >> stringReplacementCommentsMatchOriginal [
	<gtExample>
	| results |
	results := {{'example "outside" ^ self "receiver" old: (1 "argument") "message"'.
				'``@receiver old: ``@arg'.
				'``@arg'}.
			{'example ^ self old'.
				'self old'.
				'42 "template"'}}
			collect: [ :spec | 
				| trees |
				trees := {OCParseTreeRewriter.
						GtParseTreeRewriter}
						collect: [ :rewriterClass | 
							| rewriter |
							rewriter := rewriterClass new.
							rewriter replace: spec second with: spec third.
							rewriter executeTree: (OCParser parseMethod: spec first).
							rewriter tree ].
				self assert: trees first formattedCode equals: trees second formattedCode.
				trees second ].
	^ results
]

{ #category : #examples }
GtParseTreeRewriterExamples >> usesStandardReplacementRules [
	<gtExample>
	| rewriter |
	rewriter := GtParseTreeRewriter new.
	rewriter replace: '1' with: '2'.
	rewriter replace: '3' withValueFrom: [ :node | OCParser parseExpression: '4' ].
	self
		assert: (rewriter instVarNamed: #searches) first class
		equals: OCStringReplaceRule.
	self
		assert: (rewriter instVarNamed: #searches) second class
		equals: OCBlockReplaceRule.
	self
		assert: (GtParseTreeRewriter lookupSelector: #addRule:) methodClass
		equals: OCParseTreeSearcher.
	self
		assert: (GtParseTreeRewriter lookupSelector: #addArgumentRule:) methodClass
		equals: OCParseTreeSearcher.
	self
		assert: (GtParseTreeRewriter lookupSelector: #recusivelySearchInContext) methodClass
		equals: OCParseTreeSearcher.
	^ rewriter
]
