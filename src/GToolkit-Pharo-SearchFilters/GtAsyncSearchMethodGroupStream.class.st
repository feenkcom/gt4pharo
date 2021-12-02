Class {
	#name : #GtAsyncSearchMethodGroupStream,
	#superclass : #GtAsyncSearchTypedGroupStream,
	#category : #'GToolkit-Pharo-SearchFilters-Streams'
}

{ #category : #'gt - extensions' }
GtAsyncSearchMethodGroupStream >> gtCompositionChildren [
	^ { itemsStream }
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
