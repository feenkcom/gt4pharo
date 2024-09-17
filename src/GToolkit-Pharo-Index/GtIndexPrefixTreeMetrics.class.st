Class {
	#name : #GtIndexPrefixTreeMetrics,
	#superclass : #Object,
	#instVars : [
		'sizeDistribution',
		'compiledMethodsCount',
		'nilReferencesCount',
		'totalNodesCount'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #'instance - creation' }
GtIndexPrefixTreeMetrics class >> forDefaultSelectorCache [
	^ self new
		computeForPrefixTree: GtPharoIndex current selectorCache
]

{ #category : #initialization }
GtIndexPrefixTreeMetrics >> computeForPrefixTree: aPrefixTree [
	| sizeValues |
	self resetValues.
	
	sizeValues := OrderedDictionary new.
	aPrefixTree allNodesDo: [ :aNode | 
	totalNodesCount := totalNodesCount + 1.
	aNode references 
		ifNil: [ nilReferencesCount := nilReferencesCount + 1 ]
		ifNotNil: [
			(self targetDataForNode: aNode) gtIsIndexMethod
				ifTrue: [ compiledMethodsCount := compiledMethodsCount + 1]
				ifFalse: [
					| currentCount|
					currentCount := sizeValues 
						at: aNode references size ifAbsent: [ 0 ].
					sizeValues 
						at: aNode references size put: currentCount + 1 ] ] ].
	sizeDistribution := GtIndexReferencesSizeDistribution new
		sizesWithCount: sizeValues
]

{ #category : #'gt - extensions' }
GtIndexPrefixTreeMetrics >> gtViewNodesSizeIntervalFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Size intervals';
		priority: 20;
		object: [ sizeDistribution ];
		view: #gtViewSizeIntervalsFor:
]

{ #category : #'gt - extensions' }
GtIndexPrefixTreeMetrics >> gtViewSummaryFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [ {
			'Total nodes count' -> totalNodesCount.
			'Nodes with nil references' -> nilReferencesCount.
			'Nodes with compiled method' -> compiledMethodsCount.
			'Nodes with references array' -> (totalNodesCount
				-compiledMethodsCount - nilReferencesCount)} ];
		column: 'Description' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtIndexPrefixTreeMetrics >> resetValues [
	sizeDistribution := nil.
	compiledMethodsCount := 0.
	nilReferencesCount := 0.
	totalNodesCount := 0. 
]

{ #category : #initialization }
GtIndexPrefixTreeMetrics >> targetDataForNode: aNode [ 
	self subclassResponsibility
]
