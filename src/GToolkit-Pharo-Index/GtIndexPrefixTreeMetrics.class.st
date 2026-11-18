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
	"Classify every node by its target data (see #targetDataForNode:): 
	nil, a single method, or a collection of methods, whose sizes we track."

	| sizeValues |
	self resetValues.

	sizeValues := OrderedDictionary new.
	aPrefixTree
		allNodesDo: [ :aNode | 
			| aData |
			totalNodesCount := totalNodesCount + 1.
			aData := self targetDataForNode: aNode.
			aData
				ifNil: [ nilReferencesCount := nilReferencesCount + 1 ]
				ifNotNil: [ aData gtIsIndexMethod
						ifTrue: [ compiledMethodsCount := compiledMethodsCount + 1 ]
						ifFalse: [ sizeValues at: aData size put: (sizeValues at: aData size ifAbsent: [ 0 ]) + 1 ] ] ].
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
		items: [ {'Total nodes count' -> totalNodesCount.
				'Nodes without data' -> nilReferencesCount.
				'Nodes with a single method' -> compiledMethodsCount.
				'Nodes with a collection of methods'
					-> (totalNodesCount - compiledMethodsCount - nilReferencesCount)} ];
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
