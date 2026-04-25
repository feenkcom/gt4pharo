Class {
	#name : #GtPharoRenameSelectorModel,
	#superclass : #Object,
	#instVars : [
		'selectorParameters',
		'originalAstNode',
		'originalSelector',
		'selectorParts'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'instance creation' }
GtPharoRenameSelectorModel class >> forAstMethodNode: anAstNode [
	^ self new initializeForAstMethodNode: anAstNode
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> currentParameterPermutations [
	^ self parameters collect: #currentIndex
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> currentSelector [
	^ Symbol
		streamContents: [ :aStream | 
			self selectorParts
				do: [ :eachPart | aStream nextPutAll: eachPart currentName ] ]
]

{ #category : #'api - ui' }
GtPharoRenameSelectorModel >> focusNextSelectorPart: anInteger [
	| aNextPart |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger <= selectorParts size ].
	selectorParts size = 1 ifTrue: [ ^ self ].

	aNextPart := anInteger = selectorParts size
			ifTrue: [ selectorParts at: 1 ]
			ifFalse: [ selectorParts at: anInteger + 1 ].

	aNextPart notifyFocusRequested
]

{ #category : #'api - ui' }
GtPharoRenameSelectorModel >> focusPreviousSelectorPart: anInteger [
	| aPreviousPart |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger <= selectorParts size ].

	selectorParts size = 1 ifTrue: [ ^ self ].

	aPreviousPart := anInteger = 1
			ifTrue: [ selectorParts at: selectorParts size ]
			ifFalse: [ selectorParts at: anInteger - 1 ].

	aPreviousPart notifyFocusRequested
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorModel >> gtSelectorViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Selector';
		items: [ self selectorPartsAndParameters ];
		column: 'Index'
			text: [ :anItem | 
				anItem currentIndex = anItem originalIndex
					ifTrue: [ anItem currentIndex ]
					ifFalse: [ '{1} (previously {2})'
							format: {anItem originalIndex.
									anItem currentIndex} ] ];
		column: 'Type'
			text: #typeName
			width: 70;
		column: 'Value'
			text: [ :anItem | 
				anItem currentName = anItem originalName
					ifTrue: [ anItem currentName ]
					ifFalse: [ '{1} (previously {2})'
							format: {anItem currentName.
									anItem originalName} ] ]
			weight: 3
]

{ #category : #initialization }
GtPharoRenameSelectorModel >> initializeForAstMethodNode: anAstNode [
	| aSelectorParts aSelectorPartRanges aSelectorArguments aComponentsBuilder |
	originalAstNode := anAstNode.
	originalSelector := anAstNode selector.
	aSelectorParts := originalSelector keywords.
	aSelectorPartRanges := anAstNode keywordsIntervals.
	aSelectorArguments := anAstNode arguments.
	aComponentsBuilder := GtPharoRenameSelectorPartComponentsBuilder new
		astNode: anAstNode;
		build.

	selectorParts := Array
			streamContents: [ :aStream | 
				| anIndex |
				anIndex := 1.
				aSelectorParts
					with: aSelectorPartRanges
					do: [ :aPart :aRange | 
						| aPartModel |
						aPartModel := GtPharoRenameSelectorPartModel
									forSelectorPart: aPart
									interval: aRange
									index: anIndex.
						aPartModel validator: aComponentsBuilder validator.
						aPartModel styler: aComponentsBuilder styler.
						aPartModel filter: aComponentsBuilder filter.
						aStream
							nextPut: aPartModel.
						anIndex := anIndex + 1 ] ].

	selectorParameters := (aSelectorArguments
			withIndexCollect: [ :eachArgument :anIndex | 
				GtPharoRenameSelectorParameterModel
					forAstVariableNodeArgument: eachArgument
					index: anIndex ]) asArray.

	selectorParameters
		ifEmpty: [ selectorParameters := Array new: selectorParts size withAll: nil ]
]

{ #category : #testing }
GtPharoRenameSelectorModel >> isModified [
	^ (self selectorParts anySatisfy: #isModified)
		or: [ self parameters anySatisfy: #isModified ]
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> numberOfParameters [
	^ selectorParameters size
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> originalSelector [
	^ originalSelector
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> parameters [
	^ selectorParameters reject: #isNil
]

{ #category : #private }
GtPharoRenameSelectorModel >> privateSwapItem: anItemOne with: anItemTwo [
	| aNameOne anIndexOne aNameTwo anIndexTwo |
	aNameOne := anItemOne currentName.
	anIndexOne := anItemOne currentIndex.
	aNameTwo := anItemTwo currentName.
	anIndexTwo := anItemTwo currentIndex.

	anItemOne updateCurrentName: aNameTwo source: self.
	anItemOne updateCurrentIndex: anIndexTwo.
	anItemTwo updateCurrentName: aNameOne source: self.
	anItemTwo updateCurrentIndex: anIndexOne
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> selectorParts [
	^ selectorParts
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> selectorPartsAndParameters [
	^ Array
		streamContents: [ :aStream | 
			selectorParts
				with: selectorParameters
				do: [ :eachPart :eachParamter | 
					aStream nextPut: eachPart.
					eachParamter ifNotNil: [ aStream nextPut: eachParamter ] ] ]
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> selectorPartsAndParametersDo: aBlock [
	"Note that parameter may be nil if it does not exist."

	selectorParts with: selectorParameters do: aBlock
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapParameterWithNext: anInteger [
	| aParameterOne aParameterTwo |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger < selectorParts size ].
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger + 1.
	self privateSwapItem: aParameterOne with: aParameterTwo
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapParameterWithPrevious: anInteger [
	| aParameterOne aParameterTwo |
	self assert: [ anInteger > 1 ].
	self assert: [ anInteger <= selectorParts size ].

	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger - 1.
	self privateSwapItem: aParameterOne with: aParameterTwo
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapSelectorPartAndParameterWithNext: anInteger [
	| aPartOne aPartTwo aParameterOne aParameterTwo |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger < selectorParts size ].

	aPartOne := selectorParts at: anInteger.
	aPartTwo := selectorParts at: anInteger + 1.
	self privateSwapItem: aPartOne with: aPartTwo.
	
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger + 1.
	self privateSwapItem: aParameterOne with: aParameterTwo
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapSelectorPartAndParameterWithPrevious: anInteger [
	| aKeywordOne aKeywordTwo aParameterOne aParameterTwo |
	self assert: [ anInteger > 1 ].
	self assert: [ anInteger <= selectorParts size ].

	aKeywordOne := selectorParts at: anInteger.
	aKeywordTwo := selectorParts at: anInteger - 1.
	self privateSwapItem: aKeywordOne with: aKeywordTwo.
	
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger - 1.
	self privateSwapItem: aParameterOne with: aParameterTwo
]
