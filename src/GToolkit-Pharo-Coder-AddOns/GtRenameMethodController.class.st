Class {
	#name : #GtRenameMethodController,
	#superclass : #GtRenameController,
	#instVars : [
		'selector',
		'someImplementor',
		'newSelectorParts',
		'currentNode',
		'moveAttributes',
		'permutations'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtRenameMethodController >> currentNode [
	^ currentNode ifNil: [ self originalNode ]
]

{ #category : #initialization }
GtRenameMethodController >> initialize [
	super initialize.
	moveAttributes := #()
]

{ #category : #executing }
GtRenameMethodController >> installRenamer [
	| message oldAction |
	message := self currentNode.
	selector := message selector.
	(permutations isNil or: [ permutations size ~= selector numArgs ])
		ifTrue: [ permutations := (1 to: selector numArgs) asArray ].
	self someImplementor isNil ifTrue: [ ^ self ].

	newSelectorParts := selector keywords.

	oldAction := renameAction.

	renameAction := GtRenameSelectorAction
			message: message
			textualCoderViewModel: sourceCoderViewModel.
	oldAction
		ifNil: [ renameAction newSelector: message selector ]
		ifNotNil: [ renameAction newSelector: oldAction newSelector.
			renameAction focusedIndex: oldAction focusedIndex ].
	renameAction selectAll: true.
	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated ifTrue: [ self updateSelector ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ]
		for: self.
	renameAction install
]

{ #category : #executing }
GtRenameMethodController >> installReorderAttributes [
	| attribute message |
	message := self currentNode.
	message arguments size > 1 ifFalse: [ ^ self ].
	moveAttributes := OrderedCollection new.
	message arguments
		keysAndValuesDo:
			[ :i :each | 
			i > 1
				ifTrue:
					[ attribute := GtReorderParametersAttribute
						action: [ self swapParameterWithNext: i - 1 ]
						icon: BrGlamorousVectorIcons left.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each startPosition - 1
						to: each startPosition - 1 ].
			i < message arguments size
				ifTrue:
					[ attribute := GtReorderParametersAttribute
						action: [ self swapParameterWithNext: i ]
						icon: BrGlamorousVectorIcons right.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each stopPosition
						to: each stopPosition ] ]
]

{ #category : #accessing }
GtRenameMethodController >> newName [
	^ self newSelectorName
]

{ #category : #private }
GtRenameMethodController >> newSelectorName [
	^ (String
		streamContents: [ :stream | newSelectorParts do: [ :each | stream nextPutAll: each ] ])
		asSymbol
]

{ #category : #accessing }
GtRenameMethodController >> originalName [
	^ selector
]

{ #category : #private }
GtRenameMethodController >> refactoring [
	| implementor newSelector model refactoring isCoderMethodBeingRenamed |
	implementor := self someImplementor.
	implementor isNil ifTrue: [ ^ nil ].
	newSelector := self newSelectorName.
	(newSelector = selector and: [ permutations = (1 to: permutations size) ])
		ifTrue: [ ^ nil ].
	model := self createModel.
	isCoderMethodBeingRenamed := sourceCoderViewModel coderModel isForMethod
			and: [ sourceCoderViewModel coderModel selector = selector ].
	refactoring := (isCoderMethodBeingRenamed
			ifTrue: [ GtCoderRenameMethodRefactoring ]
			ifFalse: [ GtRBRenameMethodRefactoring ])
			model: model
			renameMethod: selector
			in: (model classFor: implementor)
			to: newSelector
			permutation: permutations.
	isCoderMethodBeingRenamed
		ifTrue: [ refactoring methodCoder: sourceCoderViewModel coderModel ].
	^ refactoring
]

{ #category : #accessing }
GtRenameMethodController >> refactoringName [
	^ 'Rename method'
]

{ #category : #executing }
GtRenameMethodController >> removeReorderParametersAttributes [
	moveAttributes do: [ :each | self sourceCoderViewModel removeAttribute: each ]
]

{ #category : #accessing }
GtRenameMethodController >> renamePosition [
	^ self currentNode selectorParts last stopPosition
]

{ #category : #executing }
GtRenameMethodController >> safelyExecute [
	super safelyExecute.
	self installReorderAttributes
]

{ #category : #private }
GtRenameMethodController >> someImplementor [
	^ someImplementor
		ifNil: [ (SystemNavigation default allImplementorsOf: selector)
				ifEmpty: [ nil ]
				ifNotEmpty: [ :impls | someImplementor := impls anyOne methodClass ] ]
]

{ #category : #private }
GtRenameMethodController >> swapNode: firstNode with: secondNode [
	| aNewSourceText aFirstNode aSecondNode |
	renameAction ifNotNil: [ renameAction uninstall ].
	self removeReorderParametersAttributes.
	aNewSourceText := self sourceText copy.
	firstNode startPosition < secondNode startPosition
		ifTrue: [ aFirstNode := firstNode.
			aSecondNode := secondNode ]
		ifFalse: [ aFirstNode := secondNode.
			aSecondNode := firstNode ].
	aNewSourceText := (aNewSourceText copyFrom: 1 to: aFirstNode startPosition - 1)
			, aSecondNode source asRopedText
			, (aNewSourceText
					copyFrom: aFirstNode stopPosition + 1
					to: aSecondNode startPosition - 1) , aFirstNode source asRopedText
			, (aSecondNode stopPosition = aNewSourceText size
					ifTrue: [ '' asRopedText ]
					ifFalse: [ aNewSourceText copyFrom: aSecondNode stopPosition + 1 to: aNewSourceText size ]).
	self setText: aNewSourceText.
	self updateCurrentNodeFor: aNewSourceText asString.
	self installRenamer.
	self installReorderAttributes
]

{ #category : #private }
GtRenameMethodController >> swapParameterWithNext: anInteger [
	permutations swap: anInteger with: anInteger + 1.
	self
		swapNode: (self currentNode arguments at: anInteger)
		with: (self currentNode arguments at: anInteger + 1).
	self updateSelector
]

{ #category : #private }
GtRenameMethodController >> updateCurrentNodeFor: aString [
	| method |
	method := GtPharoParser
			parse: aString
			startingAt: (self sourceCoderViewModel coder isForMethod
					ifTrue: [ GtPharoParser startingStateForMethod ]
					ifFalse: [ GtPharoParser startingStateForMethodSequence ]).
	method
		withAllNodesDo: [ :each | 
			(each class = self originalNode class
				and: [ each sourceInterval = self originalNode sourceInterval ])
				ifTrue: [ ^ currentNode := each ] ].
	self error: 'Cannot find node'
]

{ #category : #executing }
GtRenameMethodController >> updateSelector [
	renameAction isValid
		ifTrue: [ newSelectorParts := renameAction newSelector asSymbol keywords.
			(selector = renameAction newSelector
				and: [ permutations = (1 to: permutations size) ])
				ifTrue: [ self removeRefactoringAttribute ]
				ifFalse: [ self addRefactoringPreview ] ]
]
