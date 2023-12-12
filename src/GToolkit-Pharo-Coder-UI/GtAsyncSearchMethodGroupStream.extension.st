Extension { #name : #GtAsyncSearchMethodGroupStream }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> asCoder [
	^ GtFilteredMethodsCoder forFilter: self filter
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> gtItemsFor: aView [
	<gtView>
	^ aView forward
		title: 'Live' translated;
		priority: 10;
		object: [ self ];
		view: #gtItemsFor:context:
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> gtItemsFor: aView context: aPhlowContext [
	<gtView>
	^ (GtPharoCoderUIUtility
		filteredMethodsPhlowViewFor: aView
		context: aPhlowContext
		filter: filter
		testsRunner: true
		examplesRunner: true)
			title: 'Live' translated;
			priority: 10
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> gtLiveFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Methods' translated;
		priority: 11;
		column: 'Class' text: [ :eachItem | eachItem methodClass name ];
		column: 'Selector' text: [ :eachItem | eachItem selector ];
		column: 'Package' text: [ :eachItem | eachItem package name ];
		items: [ self asyncSimilarCopy ]
]
