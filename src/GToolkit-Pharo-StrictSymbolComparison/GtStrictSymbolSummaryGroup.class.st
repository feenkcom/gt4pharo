Class {
	#name : #GtStrictSymbolSummaryGroup,
	#superclass : #Object,
	#traits : 'TGtGroup',
	#classTraits : 'TGtGroup classTrait',
	#instVars : [
		'items',
		'byMethod',
		'invalidItems'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Analysis'
}

{ #category : #'instance creation' }
GtStrictSymbolSummaryGroup class >> allItems: aCollection [
	| validItems invalidItems |

	validItems := aCollection select: #isValid.
	invalidItems := aCollection copy.
	validItems keysAndValuesDo: [ :key :value |
		invalidItems removeKey: key ].
	^ self new 
		invalidItems: invalidItems;
		items: validItems.
]

{ #category : #'instance creation' }
GtStrictSymbolSummaryGroup class >> loadFromFile: aFilename [

	^ self allItems: (aFilename asFileReference readStreamDo: [ :stream |
		STON fromStream: stream ])
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> assertionOnlyItems [

	^ items select: [ :item | item isAssertionOnly ]
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> byMethod [

	^ byMethod ifNil: [ byMethod := items groupedBy: #methodName ]
]

{ #category : #initialization }
GtStrictSymbolSummaryGroup >> clearAssertions [

	items values do: [ :item |
		item addAssertion: false ]
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> comparisonCount [

	^ (items values collect: #sampleCount) sumNumbers
]

{ #category : #ui }
GtStrictSymbolSummaryGroup >> gtAssertionOnlyItemsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Assertion Only';
		priority: 20;
		items: [ self assertionOnlyItems values sorted: #id ascending ];
		column: 'Method' text: [ :item | item id ];
		column: 'Summary' text: [ :item | item summaryString ];
		column: 'Count' text: [ :item | item sampleCount ].
]

{ #category : #ui }
GtStrictSymbolSummaryGroup >> gtInvalidItemsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Invalid';
		priority: 20;
		items: [ invalidItems values sorted: #id ascending ];
		column: 'Method' text: [ :item | item id ];
		column: 'CanBeStrict' text: [ :item | item canBeStrict ];
		column: 'Count' text: [ :item | item sampleCount ].
]

{ #category : #ui }
GtStrictSymbolSummaryGroup >> gtItemsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Items';
		priority: 10;
		items: [ items values sorted: #id ascending ];
		column: 'Method' text: [ :item | item id ];
		column: 'Summary' text: [ :item | item summaryString ];
		column: 'Count' text: [ :item | item sampleCount ].
]

{ #category : #ui }
GtStrictSymbolSummaryGroup >> gtLiteralTypeCorrectionItemsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Literal Type Correction';
		priority: 20;
		items: [ self literalTypeCorrectionItems values sorted: #id ascending ];
		column: 'Method' text: [ :item | item id ];
		column: 'Summary' text: [ :item | item summaryString ];
		column: 'Count' text: [ :item | item sampleCount ].
]

{ #category : #ui }
GtStrictSymbolSummaryGroup >> gtSameContentAsItemsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'SameContentAs';
		priority: 20;
		items: [ self sameContentAsItems values sorted: #id ascending ];
		column: 'Method' text: [ :item | item id ];
		column: 'Summary' text: [ :item | item summaryString ];
		column: 'Count' text: [ :item | item sampleCount ].
]

{ #category : #ui }
GtStrictSymbolSummaryGroup >> gtSummaryFor: aView [
	<gtView>

	^ aView columnedList
		  title: 'Summary';
		  priority: 10;
		  items: [ self summaryAttributes ];
		  column: #Attribute text: [ :item | item first ];
		  column: #Value text: [ :item | item second ];
		  send: [ :item | item last ];
		  actionUpdateButton
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> invalidItems [
	^ invalidItems
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> invalidItems: anObject [
	invalidItems := anObject
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> items [

	^ items
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> items: aDictionary [

	items := aDictionary.
	byMethod := nil.
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> literalTypeCorrectionItems [

	^ items select: [ :item | item isLiteralTypeCorrection ]
]

{ #category : #actions }
GtStrictSymbolSummaryGroup >> refactor: aCollection [ 
	| filtered refactor |

	filtered := aCollection select: #shouldRefactor.
	filtered ifEmpty: [ ^ self ].
	filtered size = 1 ifTrue: [ ^ filtered anyOne refactor ].
	refactor := GtStrictSymbolRefactor new method: aCollection anyOne method.
	aCollection do: [ :change | refactor addChange: change ].
	refactor refactor.
]

{ #category : #actions }
GtStrictSymbolSummaryGroup >> refactorAll [

	self byMethod values do: [ :aCollection | 
		self refactor: aCollection ].
	(self invalidItems reject: #canBeStrict) do: #refactor
]

{ #category : #accessing }
GtStrictSymbolSummaryGroup >> sameContentAsItems [

	^ items select: [ :item | item comparisonSelector == #sameContentAs: ]
]

{ #category : #initialization }
GtStrictSymbolSummaryGroup >> setAssertions [

	items values do: [ :item |
		item addAssertion: true ]
]

{ #category : #ui }
GtStrictSymbolSummaryGroup >> summaryAttributes [

	^ {
		{ 'Message Sends'. items size. }.
		{ 'Method Count'. self byMethod size. }.
		{ 'SameContentAs Count'. self sameContentAsItems size. }.
		{ 'Literal Type Correction Count'. self literalTypeCorrectionItems size. }.
		{ 'Assertion Only Count'. self assertionOnlyItems size. }.
		{ 'Invalid Count'. self invalidItems size. }.
		{ 'Comparison Logged'. self comparisonCount. }.
		{ 'Reference Count'. #= gtReferences result toArray wait size. }.
	} collect: [ :each |
		each second isInteger ifTrue:
			[ each at: 2 put: (String streamContents: [ :stream |
				each second printWithCommasOn: stream ]) ].
		each ].
]
