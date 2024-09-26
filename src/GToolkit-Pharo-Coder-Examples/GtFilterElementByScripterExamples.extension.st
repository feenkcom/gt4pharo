Extension { #name : #GtFilterElementByScripterExamples }

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> itemsModelWithMethodsCoder [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtFilterModelExamples new itemsModelWithMethodsCoder ]
			element: [ :aModel | self newFilterItemsElementForFiltersModel: aModel ].

	^ aScripter
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> newFilterItemsElementForFiltersModel: aFiltersModel [
	<gtExample>
	
	| aMethodsCoder aList |
	aList := BrSimpleList new
		itemStencil: [ GtExpandableMethodCoderElement new ];
		itemDataBinder: [ :aCoderElement :aCoderViewModel | 
			aCoderElement coderViewModel: aCoderViewModel ].
	aMethodsCoder := aFiltersModel availableFiltersBuilder ifNotNil: #coders.
	aMethodsCoder ifNotNil: [
		| aStream aCodersUpdater aListUpdater |
		aCodersUpdater := GtFilterMethodCodersAdditionalFiltersUpdater new 
			coders: aMethodsCoder;
			filtersModel: aFiltersModel.
		aFiltersModel weak 
			when: GtFiltersModelUpdated 
			send: #onFiltersUpdated:
			to: aCodersUpdater.
		
		aStream := aMethodsCoder asAsyncStream
			map: [ :eachCoder | eachCoder asCoderViewModel expanded: false ].
		aList stream: aStream.	
		aListUpdater := GtFilterMethodsCoderListUpdater new
			coders: aMethodsCoder;
			list: aList.
		aList userData at: GtFilterMethodCodersAdditionalFiltersUpdater put: aCodersUpdater.
		aList userData at: GtFilterMethodsCoderListUpdater put: aListUpdater ].

	^ BrVerticalPane new
		matchParent;
		addChild: aFiltersModel asFiltersElement;
		addChild: aList
]
