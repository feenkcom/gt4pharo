Class {
	#name : #GtPharoStreamingMethodsFiltersElementFromModelStencil,
	#superclass : #GtPharoStreamingMethodsFiltersElementStencil,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #'api - instantiation' }
GtPharoStreamingMethodsFiltersElementFromModelStencil >> create [
	| aModel aMethodsCoder aBuilder anUpdater aFiltersElement |
	aModel := GtFilterItemsModel new.
	aFiltersElement := aModel asFiltersElement.
	aMethodsCoder := streamingCodersViewModel streamingCodersModel.
	self updateFiltersElement: aFiltersElement.
	aBuilder := GtFilterMethodsCoderAvailableFiltersBuilder new
			coders: aMethodsCoder.
	aModel availableFiltersBuilder: aBuilder.
	anUpdater := GtFilterMethodCodersAdditionalFiltersUpdater new
			coders: aMethodsCoder;
			filtersModel: aModel.
	aModel weak
		when: GtFiltersModelUpdated
		send: #onFiltersUpdated:
		to: anUpdater.
	aFiltersElement userData at: GtFilterMethodCodersAdditionalFiltersUpdater put: anUpdater.
	
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
	
	"aFiltersModel items ifNotEmpty: [ ^ self ]."

	someFilterModels := streamingCodersViewModel streamingCodersModel
			additionalFilters
			collect: [ :eachFilter | 
				eachFilter class
					filterDescriptor2For: streamingCodersViewModel streamingCodersModel ]
			thenReject: #isNil.
	
	aFiltersModel items: someFilterModels.
]
