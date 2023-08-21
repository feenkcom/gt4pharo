Class {
	#name : #GtRBRenameClassRefactoring,
	#superclass : #RBRenameClassRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #transforming }
GtRBRenameClassRefactoring >> executeRenameExtensions [
	(Pragma allNamed: #gtRename in: self class)
		do: [ :each | self perform: each method selector ]
]

{ #category : #baselines }
GtRBRenameClassRefactoring >> renameBaselines [
	<gtRename>
	| baselineClass rewriter oldString newString |
	baselineClass := self model classFor: BaselineOf.
	(class includesClass: baselineClass) ifFalse: [ ^ self ].
	oldString := className allButFirst: 10.
	newString := newName allButFirst: 10.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: oldString asString storeString
		with: newString asString storeString
		when: [ :node | node gtIsBaselineName ].
	rewriter
		replace: oldString asSymbol storeString
		with: newString asSymbol storeString
		when: [ :node | node gtIsBaselineName ].
	baselineClass withAllSubclasses
		do: [ :each | 
			| selectors |
			selectors := Set
					withAll: (each whichSelectorsReferToSymbol: oldString asString).
			selectors addAll: (each whichSelectorsReferToSymbol: oldString asSymbol).
			selectors
				do: [ :sel | 
					| method |
					method := each methodFor: sel.
					(rewriter executeTree: method ast)
						ifTrue: [ method compileTree: rewriter tree ] ] ]
]

{ #category : #comments }
GtRBRenameClassRefactoring >> renameClassComments [
	"<gtRename>"
	self model
		allClassesDo: [ :each | 
			| newComment |
			each isMeta
				ifFalse: [ newComment := self renameClassInComment: each comment.
					newComment ~= each comment
						ifTrue: [ each comment: newComment ] ] ]
]

{ #category : #comments }
GtRBRenameClassRefactoring >> renameClassInComment: aString [
	| index indices |
	aString isNil ifTrue: [ ^ nil ].
	(aString includesSubstring: className) ifFalse: [ ^ aString ].
	indices := OrderedCollection new.
	index := 1.
	[ index := aString indexOfSubCollection: className startingAt: index.
	index > 0 ]
		whileTrue: [ indices add: index.
			index := index + className size ].
	index := 1.
	^ String
		streamContents: [ :stream | 
			indices
				do: [ :each | 
					| isWord |
					stream nextPutAll: (aString copyFrom: index to: each - 1).
					index := each + className size.
					isWord := (each > 1 and: [ (aString at: each - 1) isAlphaNumeric ]) not
							and: [ (index <= aString size and: [ (aString at: index) isAlphaNumeric ]) not ].
					stream nextPutAll: (isWord ifTrue: [ newName ] ifFalse: [ className ]) ].
			stream nextPutAll: (aString copyFrom: index to: aString size) ]
]

{ #category : #comments }
GtRBRenameClassRefactoring >> renameClassNameInMethodComments: aRBMethod [
	| comments index newSource originalSource |
	comments := OrderedCollection new.
	aRBMethod ast nodesDo: [ :each | comments addAll: each comments ].
	comments sort: [ :a :b | a start < b start ].
	originalSource := aRBMethod source.
	index := 1.
	newSource := String
			streamContents: [ :stream | 
				comments
					do: [ :each | 
						stream nextPutAll: (originalSource copyFrom: index to: each start).
						stream nextPutAll: (self renameClassInComment: each contents).
						index := each stop ].
				stream nextPutAll: (originalSource copyFrom: index to: originalSource size) ].
	newSource ~= originalSource
		ifTrue: [ aRBMethod methodClass compile: newSource ]
]

{ #category : #comments }
GtRBRenameClassRefactoring >> renameMethodComments [
	"<gtRename>"
	self model
		allClassesDo: [ :cls | 
			cls localSelectors
				do: [ :sel | 
					| method |
					method := cls methodFor: sel.
					(method containsSubstring: className)
						ifTrue: [ self renameClassNameInMethodComments: method ] ] ]
]

{ #category : #transforming }
GtRBRenameClassRefactoring >> renameReferences [
	super renameReferences.
	self executeRenameExtensions
]
