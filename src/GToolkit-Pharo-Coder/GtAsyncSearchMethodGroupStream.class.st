Class {
	#name : #GtAsyncSearchMethodGroupStream,
	#superclass : #GtAsyncSearchTypedGroupStream,
	#category : #'GToolkit-Pharo-Coder-Filters - Stream'
}

{ #category : #ui }
GtAsyncSearchMethodGroupStream >> gtItemsFor: aView [
	<gtView>

	^ aView list
		title: 'Live' translated;
		priority: 10;
		items: [
			self updateItems.
			itemsStream map: [ :eachCompiledMethod |
				(GtPharoMethodCoder forMethod: eachCompiledMethod) asCoderViewModel
					expanded: false ] ];
		itemStencil: [ GtExpandableMethodCoderForBehaviorElement new ];
		itemDataBinder: [ :aCoderElement :aCoderViewModel | aCoderElement coderUIModel: aCoderViewModel ]
]

{ #category : #updating }
GtAsyncSearchMethodGroupStream >> updateItems [
	itemsStream := scope filter: filter.
	itemsFuture := itemsStream collect map: [ :theMethods | theMethods sorted: GtMethodsSortFunction new ]
]
