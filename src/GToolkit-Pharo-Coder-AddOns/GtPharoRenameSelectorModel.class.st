Class {
	#name : #GtPharoRenameSelectorModel,
	#superclass : #Object,
	#instVars : [
		'selectorParameters',
		'selectorKeywords',
		'originalAstNode',
		'originalSelector'
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
			self keywords
				do: [ :eachKeyword | aStream nextPutAll: eachKeyword currentKeyword ] ]
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorModel >> gtSelectorViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Selector';
		items: [ self keywordsAndParameters ];
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
	| aSelectorParts aSelectorPartRanges aSelectorArguments |
	originalAstNode := anAstNode.
	originalSelector := anAstNode selector.
	aSelectorParts := originalSelector keywords.
	aSelectorPartRanges := anAstNode keywordsIntervals.
	aSelectorArguments := anAstNode arguments.

	selectorKeywords := Array
			streamContents: [ :aStream | 
				| anIndex |
				anIndex := 1.
				aSelectorParts
					with: aSelectorPartRanges
					do: [ :aPart :aRange | 
						aStream
							nextPut: (GtPharoRenameSelectorKeywordModel
									forSelectorPart: aPart
									interval: aRange
									index: anIndex).
						anIndex := anIndex + 1 ] ].

	selectorParameters := (aSelectorArguments
			withIndexCollect: [ :eachArgument :anIndex | 
				GtPharoRenameSelectorParameterModel
					forAstVariableNodeArgument: eachArgument
					index: anIndex ]) asArray.

	selectorParameters
		ifEmpty: [ selectorParameters := Array new: selectorKeywords size withAll: nil ]
]

{ #category : #testing }
GtPharoRenameSelectorModel >> isModified [
	^ (self keywords anySatisfy: #isModified)
		or: [ self parameters anySatisfy: #isModified ]
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> keywords [
	^ selectorKeywords
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> keywordsAndParameters [
	^ Array
		streamContents: [ :aStream | 
			selectorKeywords
				with: selectorParameters
				do: [ :eachKeyword :eachParamter | 
					aStream nextPut: eachKeyword.
					eachParamter ifNotNil: [ aStream nextPut: eachParamter ] ] ]
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> keywordsAndParametersDo: aBlock [
	"Note that parameter may be nil if it does not exist."

	selectorKeywords with: selectorParameters do: aBlock
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

	anItemOne updateCurrentName: aNameTwo.
	anItemOne updateCurrentIndex: anIndexTwo.
	anItemTwo updateCurrentName: aNameOne.
	anItemTwo updateCurrentIndex: anIndexOne
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapKeywordAndParameterWithNext: anInteger [
	| aKeywordOne aKeywordTwo aParameterOne aParameterTwo |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger < selectorKeywords size ].

	aKeywordOne := selectorKeywords at: anInteger.
	aKeywordTwo := selectorKeywords at: anInteger + 1.
	self privateSwapItem: aKeywordOne with: aKeywordTwo.
	
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger + 1.
	self privateSwapItem: aParameterOne with: aParameterTwo
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapKeywordAndParameterWithPrevious: anInteger [
	| aKeywordOne aKeywordTwo aParameterOne aParameterTwo |
	self assert: [ anInteger > 1 ].
	self assert: [ anInteger <= selectorKeywords size ].

	aKeywordOne := selectorKeywords at: anInteger.
	aKeywordTwo := selectorKeywords at: anInteger - 1.
	self privateSwapItem: aKeywordOne with: aKeywordTwo.
	
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger - 1.
	self privateSwapItem: aParameterOne with: aParameterTwo
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapParameterWithNext: anInteger [
	| aParameterOne aParameterTwo |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger < selectorKeywords size ].
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger + 1.
	self privateSwapItem: aParameterOne with: aParameterTwo
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapParameterWithPrevious: anInteger [
	| aParameterOne aParameterTwo |
	self assert: [ anInteger > 1 ].
	self assert: [ anInteger <= selectorKeywords size ].

	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger - 1.
	self privateSwapItem: aParameterOne with: aParameterTwo
]
