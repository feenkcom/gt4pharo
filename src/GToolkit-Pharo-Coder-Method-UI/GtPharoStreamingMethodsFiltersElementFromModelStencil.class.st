Class {
	#name : #GtPharoStreamingMethodsFiltersElementFromModelStencil,
	#superclass : #GtPharoStreamingMethodsFiltersElementStencil,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #'api - instantiation' }
GtPharoStreamingMethodsFiltersElementFromModelStencil >> create [
	| aModel aMethodsCoder aBuilder anUpdater aFiltersElement defaultModels allModels globalDefaultModels |
	aModel := GtFilterItemsModel new.
	aFiltersElement := aModel asFiltersElement.
	aFiltersElement 
		hMatchParent; 
		constraintsDo: [ :c | 
			c linear vertical alignCenter ].
	aMethodsCoder := streamingCodersViewModel streamingCodersModel.
	self updateFiltersElement: aFiltersElement.
	aBuilder := GtFilterMethodsCoderAvailableFiltersBuilder new
			coders: aMethodsCoder.
	aModel availableFiltersBuilder: aBuilder.
	defaultModels := aModel availableFilters select: [ :aFilterModel | 
		aFilterModel isDefaultFilterModel
			and: [ (aModel items includes: aFilterModel) not ] ].
	globalDefaultModels := GtFilterDefaultSearchFilters coderSearchFilters 
		collect: [ :eachFilter | 
				eachFilter filterDescriptor2For: streamingCodersViewModel streamingCodersModel ]
		thenReject: #isNil.
	
	anUpdater := GtFilterMethodCodersAdditionalFiltersUpdater new
			coders: aMethodsCoder;
			filtersModel: aModel.
	aFiltersElement userData at: GtFilterMethodCodersAdditionalFiltersUpdater put: anUpdater.
	
	(defaultModels isNotNil or: [ globalDefaultModels isNotNil ]) ifTrue: [ 
		allModels := Array streamContents: [ :aStream |
			aStream nextPutAll: aModel items.
			aStream nextPutAll: defaultModels.
			aStream nextPutAll: globalDefaultModels ].
		aModel items: allModels ].
	
	^ aFiltersElement
]

{ #category : #'api - updating' }
GtPharoStreamingMethodsFiltersElementFromModelStencil >> updateFiltersElement: aFiltersElement [
	| aFiltersModel someFilterModels |
	self
		assert: [ streamingCodersViewModel isNotNil ]
		description: [ 'Streaming coders view model must be initialized' ].

	aFiltersElement hasFiltersViewModel ifFalse: [ ^ self ].
	aFiltersModel := aFiltersElement filtersViewModel filtersModel.

	someFilterModels := streamingCodersViewModel streamingCodersModel
			additionalFilters
			collect: [ :eachFilter | 
				eachFilter filterDescriptor2For: streamingCodersViewModel streamingCodersModel ]
			thenReject: #isNil.
	
	aFiltersModel items: someFilterModels.
]
