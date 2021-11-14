Class {
	#name : #GtAsyncSearchMethodGroupStream,
	#superclass : #GtAsyncSearchTypedGroupStream,
	#category : #'GToolkit-Pharo-Coder-Filters - Stream'
}

{ #category : #converting }
GtAsyncSearchMethodGroupStream >> asCoder [
	^ GtFilteredMethodsCoder forFilter: self filter
]

{ #category : #'gt - extensions' }
GtAsyncSearchMethodGroupStream >> gtCompositionChildren [
	^ { itemsStream }
]

{ #category : #'gt - extensions' }
GtAsyncSearchMethodGroupStream >> gtItemsFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live' translated;
		priority: 10;
		stencil: [
			| aStream |			

			aStream := self asyncSimilarCopy map: [ :eachCompiledMethod |
				((GtPharoMethodCoder forMethod: eachCompiledMethod)
					highlighter: self highlighter)
						asCoderViewModel
							expanded: false ].

			BrSimpleList new
				itemStencil: [ GtExpandableMethodCoderForBehaviorElement new ];
				itemDataBinder: [ :aCoderElement :aCoderViewModel | aCoderElement coderUIModel: aCoderViewModel ];
				stream: aStream ]
]

{ #category : #'gt - extensions' }
GtAsyncSearchMethodGroupStream >> gtMetricsFor: aView [
	<gtView>

	^ aView forward
		title: 'Metrics';
		object: [ self metrics ];
		view: #gtMetricsFor:
]

{ #category : #'source code management' }
GtAsyncSearchMethodGroupStream >> linesOfCode [
	<return: #TAsyncFuture>

	^ self metrics map: [ :theMetrics | theMetrics linesOfCode ]
]

{ #category : #'source code management' }
GtAsyncSearchMethodGroupStream >> metrics [
	<return: #TAsyncFuture>

	^ self filteredItemsStream inject: GtAsyncSearchMethodGroupMetrics new into: [ :metrics :eachMethod | metrics accumulateMethod: eachMethod ]
]
