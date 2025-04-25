Class {
	#name : #GtRenameMethodController2,
	#superclass : #GtRenameController,
	#instVars : [
		'selector',
		'someImplementor',
		'newSelectorParts',
		'currentNode',
		'moveAttributes',
		'permutations',
		'mouseHandler',
		'mouseOverActions',
		'hovered',
		'focused'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #'as yet unclassified' }
GtRenameMethodController2 >> cleanUp [
	super cleanUp.
	mouseHandler ifNotNil: [ element removeEventHandler: mouseHandler ]
]

{ #category : #accessing }
GtRenameMethodController2 >> currentNode [
	^ currentNode ifNil: [ self originalNode ]
]

{ #category : #initialization }
GtRenameMethodController2 >> initialize [
	super initialize.
	moveAttributes := #()
]

{ #category : #executing }
GtRenameMethodController2 >> installMouseMoveHandler [
	mouseHandler := BlEventHandler
			on: BlMouseMoveEvent
			do: [ :event | self mouseMoved: event ].
	element addEventHandler: mouseHandler
]

{ #category : #executing }
GtRenameMethodController2 >> installRenamer [
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
				ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ];
		when: GtRenameSelectorKeywordFocused
			do: [ :ann | self updateFocused: ann keyword ].
	renameAction install
]

{ #category : #executing }
GtRenameMethodController2 >> installReorderAttributes [
	| attribute message |
	message := self currentNode.
	message arguments size > 1 ifFalse: [ ^ self ].
	self mouseOverActions removeAll.
	moveAttributes := OrderedCollection new.
	message arguments
		keysAndValuesDo: [ :i :each | 
			i > 1
				ifTrue: [ attribute := GtRefactoringButtonAttribute
							action: [ self swapKeywordAndParameterWithNext: i - 1 ]
							icon: BrGlamorousVectorIcons left
							label: 'Swap keyword and parameter with previous'.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: (message selectorParts at: i) startPosition - 1
						to: (message selectorParts at: i) startPosition - 1.
					attribute := GtRefactoringButtonAttribute
							action: [ self swapParameterWithNext: i - 1 ]
							icon: BrGlamorousVectorIcons left
							label: 'Swap parameter with previous'.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each startPosition - 1
						to: each startPosition - 1 ].
			i < message arguments size
				ifTrue: [ attribute := GtRefactoringButtonAttribute
							action: [ self swapParameterWithNext: i ]
							icon: BrGlamorousVectorIcons right
							label: 'Swap parameter with next'.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each stopPosition
						to: each stopPosition.
					attribute := GtRefactoringButtonAttribute
							action: [ self swapKeywordAndParameterWithNext: i ]
							icon: BrGlamorousVectorIcons right
							label: 'Swap keyword and parameter with next'.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each stopPosition
						to: each stopPosition ].
			self
				whenMouseOver: ((message selectorParts at: i) startPosition - 1 to: each stopPosition)
				do: [ self updateHovered: i ] ].
	self installMouseMoveHandler
]

{ #category : #private }
GtRenameMethodController2 >> mouseMoved: anEvent [
	| index |
	index := element editor navigator
			findTextIndexAtScreenPosition: anEvent localPosition
			ifAbsent: [ -1 ].
	self mouseOverActions
		detect: [ :each | each key includes: index ]
		ifFound: [ :each | each value cull: index ]
		ifNone: [ self updateHovered: -1 ]
]

{ #category : #accessing }
GtRenameMethodController2 >> mouseOverActions [
	^ mouseOverActions ifNil: [ mouseOverActions := OrderedCollection new ]
]

{ #category : #accessing }
GtRenameMethodController2 >> newName [
	^ self newSelectorName
]

{ #category : #private }
GtRenameMethodController2 >> newSelectorName [
	^ (String
		streamContents: [ :stream | newSelectorParts do: [ :each | stream nextPutAll: each ] ])
		asSymbol
]

{ #category : #accessing }
GtRenameMethodController2 >> originalName [
	^ selector
]

{ #category : #private }
GtRenameMethodController2 >> refactoring [
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
GtRenameMethodController2 >> refactoringName [
	^ 'Rename method'
]

{ #category : #executing }
GtRenameMethodController2 >> removeReorderParametersAttributes [
	moveAttributes do: [ :each | self sourceCoderViewModel removeAttribute: each ]
]

{ #category : #accessing }
GtRenameMethodController2 >> renamePosition [
	^ self currentNode selectorParts last stopPosition
]

{ #category : #executing }
GtRenameMethodController2 >> safelyExecute [
	super safelyExecute.
	self installReorderAttributes
]

{ #category : #private }
GtRenameMethodController2 >> someImplementor [
	^ someImplementor
		ifNil: [ (SystemNavigation default allImplementorsOf: selector)
				ifEmpty: [ nil ]
				ifNotEmpty: [ :impls | someImplementor := impls anyOne methodClass ] ]
]

{ #category : #executing }
GtRenameMethodController2 >> swapKeywordAndParameterWithNext: anInteger [
	renameAction isValid ifFalse: [ ^ self ].
	permutations swap: anInteger with: anInteger + 1.
	self
		swapNode: (self currentNode arguments at: anInteger)
		with: (self currentNode arguments at: anInteger + 1).
	newSelectorParts swap: anInteger with: anInteger + 1.
	renameAction swapKeywordWithNext: anInteger.
	renameAction newSelector: self newSelectorName.
	(selector = renameAction newSelector
		and: [ permutations = (1 to: permutations size) ])
		ifTrue: [ self removeRefactoringAttribute ]
		ifFalse: [ self addRefactoringPreview ]
]

{ #category : #private }
GtRenameMethodController2 >> swapNode: firstNode with: secondNode [
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
GtRenameMethodController2 >> swapParameterWithNext: anInteger [
	permutations swap: anInteger with: anInteger + 1.
	self
		swapNode: (self currentNode arguments at: anInteger)
		with: (self currentNode arguments at: anInteger + 1).
	self updateSelector
]

{ #category : #private }
GtRenameMethodController2 >> updateCurrentNodeFor: aString [
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
GtRenameMethodController2 >> updateFocused: anInteger [
	focused := anInteger.
	self updateVisibleMoveAttributes
]

{ #category : #executing }
GtRenameMethodController2 >> updateHovered: anInteger [
	hovered := anInteger.
	self updateVisibleMoveAttributes
]

{ #category : #executing }
GtRenameMethodController2 >> updateSelector [
	renameAction isValid
		ifTrue: [ newSelectorParts := renameAction newSelector asSymbol keywords.
			(selector = renameAction newSelector
				and: [ permutations = (1 to: permutations size) ])
				ifTrue: [ self removeRefactoringAttribute ]
				ifFalse: [ self addRefactoringPreview ] ]
]

{ #category : #executing }
GtRenameMethodController2 >> updateVisibleMoveAttributes [
	moveAttributes
		doWithIndex: [ :each :i | 
			| index |
			index := (i + 1) // 4 + 1.
			each visible: (index = hovered or: [ index = focused ]) ]
]

{ #category : #executing }
GtRenameMethodController2 >> whenMouseOver: anInterval do: aBlock [
	self mouseOverActions add: anInterval -> aBlock
]
