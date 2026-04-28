Class {
	#name : #GtPharoRenameSelectorModel,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'originalAstNode',
		'originalSelector',
		'selectorParameters',
		'selectorParts',
		'isModified'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'instance creation' }
GtPharoRenameSelectorModel class >> forAstMethodNode: anAstNode [
	^ self new initializeForAstMethodNode: anAstNode
]

{ #category : #accessing }
GtPharoRenameSelectorModel >> announcer [
	^ announcer
]

{ #category : #'private - updating' }
GtPharoRenameSelectorModel >> computeIsModified [
	^ (self selectorParts anySatisfy: #isModified)
		or: [ self parameters anySatisfy: #isModified ]
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
GtPharoRenameSelectorModel >> displayRefactoringsPreviewOrFocusNextSelectorPart: anInteger [
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger <= selectorParts size ].

	(anInteger = selectorParts size and: [ self isModified ])
		ifTrue: [ self notifyShowPreviewRequested ]
		ifFalse: [ self focusNextSelectorPart: anInteger ]
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
		column: 'Is modified'
			text: [ :anItem :aRowIndex :aCellIndex :aTheme | 
				anItem isModified
					ifTrue: [ 'yes']
					ifFalse: [ 'no' asRopedText foreground: aTheme button disabledTextColor ] ]
			width: 80;
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

{ #category : #'api - ui' }
GtPharoRenameSelectorModel >> highlight: isHighligthed selectorParameterWithNext: anInteger source: aSource [
	| aParameterOne aParameterTwo |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger < selectorParts size ].
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger + 1.

	self
		selectorPartsAndParametersDo: [ :eachPart :eachParameter | 
			eachParameter
				ifNotNil: [ eachParameter = aParameterOne
						ifTrue: [ eachParameter requestHighlightChange: isHighligthed source: aSource ] ] ]
]

{ #category : #'api - ui' }
GtPharoRenameSelectorModel >> highlight: isHighligthed selectorParameterWithPrevious: anInteger source: aSource [
	| aParameterOne aParameterTwo |
	self assert: [ anInteger > 1 ].
	self assert: [ anInteger <= selectorParts size ].

	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger - 1.
	
	self
		selectorPartsAndParametersDo: [ :eachPart :eachParameter | 
			eachParameter
				ifNotNil: [ eachParameter = aParameterOne
						ifTrue: [ eachParameter requestHighlightChange: isHighligthed source: aSource ] ] ]
]

{ #category : #'api - ui' }
GtPharoRenameSelectorModel >> highlight: isHighligthed selectorPartAndParameterWithNext: anInteger source: aSource [
	| aPartOne aPartTwo aParameterOne aParameterTwo |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger < selectorParts size ].

	aPartOne := selectorParts at: anInteger.
	aPartTwo := selectorParts at: anInteger + 1.
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger + 1.

	self
		selectorPartsAndParametersDo: [ :eachPart :eachParameter | 
			eachPart = aPartOne
				ifTrue: [ eachPart requestHighlightChange: isHighligthed source: aSource ].
			eachParameter
				ifNotNil: [ eachParameter = aParameterOne
						ifTrue: [ eachParameter requestHighlightChange: isHighligthed source: aSource ] ] ]
]

{ #category : #'api - ui' }
GtPharoRenameSelectorModel >> highlight: isHighligthed selectorPartAndParameterWithPrevious: anInteger source: aSource [
	| aKeywordOne aKeywordTwo aParameterOne aParameterTwo |
	self assert: [ anInteger > 1 ].
	self assert: [ anInteger <= selectorParts size ].

	aKeywordOne := selectorParts at: anInteger.
	aKeywordTwo := selectorParts at: anInteger - 1.
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger - 1.

	self
		selectorPartsAndParametersDo: [ :eachPart :eachParameter | 
			eachPart = aKeywordOne
				ifTrue: [ eachPart requestHighlightChange: isHighligthed source: aSource ].
			eachParameter
				ifNotNil: [ eachParameter = aParameterOne
						ifTrue: [ eachParameter requestHighlightChange: isHighligthed source: aSource ] ] ]
]

{ #category : #initialization }
GtPharoRenameSelectorModel >> initialize [
	super initialize.
	announcer := Announcer new.
	isModified := false.
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
						aPartModel announcer
							when: GtPharoRenameSelectorPartNameChanged
								send: #onGtPharoRenameSelectorPartNameChanged:
								to: self;
							when: GtPharoRenameSelectorParameterIndexChanged
								send: #onGtPharoRenameSelectorParameterIndexChanged:
								to: self.
						aStream nextPut: aPartModel.
						anIndex := anIndex + 1 ] ].

	selectorParameters := (aSelectorArguments
			withIndexCollect: [ :eachArgument :anIndex | 
				| aParameterModel |
				aParameterModel := GtPharoRenameSelectorParameterModel
						forAstVariableNodeArgument: eachArgument
						index: anIndex.

				aParameterModel announcer
					when: GtPharoRenameSelectorParameterNameChanged
					send: #onGtPharoRenameSelectorParameterNameChanged:
					to: self.

				aParameterModel ]) asArray.

	selectorParameters
		ifEmpty: [ selectorParameters := Array new: selectorParts size withAll: nil ]
]

{ #category : #testing }
GtPharoRenameSelectorModel >> isModified [
	^ self computeIsModified
]

{ #category : #private }
GtPharoRenameSelectorModel >> notifyShowPreviewRequested [
	self announcer
		announce: (GtPharoRenameSelectorModelRefactoringsPreviewRequested new selectorModel: self)
]

{ #category : #'api - accessing' }
GtPharoRenameSelectorModel >> numberOfParameters [
	^ self parameters size
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorModel >> onGtPharoRenameSelectorParameterIndexChanged: anAnnouncement [
	self updateModificationStatus
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorModel >> onGtPharoRenameSelectorParameterNameChanged: anAnnouncement [
	self updateModificationStatus
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorModel >> onGtPharoRenameSelectorPartNameChanged: anAnnouncement [
	self updateModificationStatus
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
GtPharoRenameSelectorModel >> privateSwapItem: anItemOne with: anItemTwo source: aSource [
	| aNameOne anIndexOne aNameTwo anIndexTwo |
	aNameOne := anItemOne currentName.
	anIndexOne := anItemOne currentIndex.
	aNameTwo := anItemTwo currentName.
	anIndexTwo := anItemTwo currentIndex.

	anItemOne updateCurrentName: aNameTwo source: self.
	anItemOne updateCurrentIndex: anIndexTwo source: self.
	anItemTwo updateCurrentName: aNameOne source: self.
	anItemTwo updateCurrentIndex: anIndexOne source: self
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> requestCancelRenameSelectorSource: aSource [
	self announcer
		announce: (GtPharoRenameSelectorModelRefactoringsCancelRequested new
				selectorModel: self;
				source: aSource)
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

{ #category : #'api - ui' }
GtPharoRenameSelectorModel >> show: isDisplayed switchButtonsForSelectorPart: aSelectorPart source: aSource [
	| aRelevantModels |
	self assert: [ aSelectorPart originalIndex <= selectorParts size ].
	self assert: [ aSelectorPart originalIndex > 0 ].
	self
		assert: (selectorParts at: aSelectorPart originalIndex)
		equals: aSelectorPart.

	aRelevantModels := (selectorParameters at: aSelectorPart originalIndex)
			ifNil: [ {aSelectorPart} ]
			ifNotNil: [ :aParameter | 
				{aSelectorPart.
					aParameter} ].

	self announcer
		announce: (GtPharoRenameSelectorSwapVisibilityChanged new
				selectorModel: self;
				correspondingModels: aRelevantModels;
				isVisible: isDisplayed;
				source: aSource)
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapParameterWithNext: anInteger source: aSource [
	| aParameterOne aParameterTwo |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger < selectorParts size ].
	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger + 1.
	self
		privateSwapItem: aParameterOne
		with: aParameterTwo
		source: aSource
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapParameterWithPrevious: anInteger source: aSource [
	| aParameterOne aParameterTwo |
	self assert: [ anInteger > 1 ].
	self assert: [ anInteger <= selectorParts size ].

	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger - 1.
	self
		privateSwapItem: aParameterOne
		with: aParameterTwo
		source: aSource
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapSelectorPartAndParameterWithNext: anInteger  source: aSource [
	| aPartOne aPartTwo aParameterOne aParameterTwo |
	self assert: [ anInteger > 0 ].
	self assert: [ anInteger < selectorParts size ].

	aPartOne := selectorParts at: anInteger.
	aPartTwo := selectorParts at: anInteger + 1.
	self
		privateSwapItem: aPartOne
		with: aPartTwo
		source: aSource.

	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger + 1.
	self
		privateSwapItem: aParameterOne
		with: aParameterTwo
		source: aSource
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModel >> swapSelectorPartAndParameterWithPrevious: anInteger source: aSource [
	| aKeywordOne aKeywordTwo aParameterOne aParameterTwo |
	self assert: [ anInteger > 1 ].
	self assert: [ anInteger <= selectorParts size ].

	aKeywordOne := selectorParts at: anInteger.
	aKeywordTwo := selectorParts at: anInteger - 1.
	self
		privateSwapItem: aKeywordOne
		with: aKeywordTwo
		source: aSource.

	aParameterOne := selectorParameters at: anInteger.
	aParameterTwo := selectorParameters at: anInteger - 1.
	self
		privateSwapItem: aParameterOne
		with: aParameterTwo
		source: aSource
]

{ #category : #'private - updating' }
GtPharoRenameSelectorModel >> updateModificationStatus [
	| oldModified |
	oldModified := isModified.
	isModified := self computeIsModified.
	"isModified = oldModified ifTrue: [ ^ self ]."

	self announcer
		announce: (GtPharoRenameSelectorModificationChanged new
				selectorModel: self;
				isModified: isModified)
]
