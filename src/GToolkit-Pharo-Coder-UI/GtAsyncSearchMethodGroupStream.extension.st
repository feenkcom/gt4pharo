Extension { #name : #GtAsyncSearchMethodGroupStream }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> asCoder [
	^ GtFilteredMethodsCoder forFilter: self filter
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> gtItemsFor: aView [
	<gtView>
	
	^ (GtPharoCoderUIUtility
		filteredMethodsPhlowViewFor: aView
		filter: filter
		testsRunner: true
		examplesRunner: true)
			title: 'Live' translated;
			priority: 10
]
