Class {
	#name : #GtPharoStreamingMethodsFiltersElementFromDescriptorsStencil,
	#superclass : #GtPharoStreamingMethodsFiltersElementStencil,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #'api - instantiation' }
GtPharoStreamingMethodsFiltersElementFromDescriptorsStencil >> create [
	<return: #GtFiltersElement>
	| aFilterDescriptors aFiltersElement |
	self
		assert: [ streamingCodersViewModel isNotNil ]
		description: [ 'Streaming coders view model must be initialized' ].

	aFilterDescriptors := streamingCodersViewModel streamingCodersModel
			filterDescriptors.

	aFiltersElement := GtFiltersElement new
			padding: (BlInsets all: 2);
			descriptors: aFilterDescriptors;
			yourself.
	self updateFiltersElement: aFiltersElement.
	aFiltersElement
		when: GtFiltersChangedEvent
		do: [ :anEvent | self updateCodersFilters: anEvent ].

	^ aFiltersElement
]

{ #category : #'event handling' }
GtPharoStreamingMethodsFiltersElementFromDescriptorsStencil >> updateCodersFilters: anEvent [
	| filters |
	
	filters := OrderedCollection new.

	anEvent filterElement filtersDo: [ :descriptor :value |
		filters add: (descriptor newFilterWithValue: value) ].
	
	streamingCodersViewModel streamingCodersModel additionalFilters: filters
]

{ #category : #'api - updating' }
GtPharoStreamingMethodsFiltersElementFromDescriptorsStencil >> updateFiltersElement: aFiltersElement [
	self
		assert: [ aFiltersElement isKindOf: GtFiltersElement ]
		description: [ '{1} must be kind of {2}'
				format: {aFiltersElement.
						GtFiltersElement} ].
	self
		assert: [ streamingCodersViewModel isNotNil ]
		description: [ 'Streaming coders view model must be initialized' ].

	aFiltersElement
		buildFilters: [ streamingCodersViewModel streamingCodersModel additionalFilters
				do: [ :eachFilter | 
					(eachFilter class filterDescriptorFor: streamingCodersViewModel streamingCodersModel)
						ifNotNil: [ :aDescriptor | 
							| aLabel |
							aLabel := aDescriptor valueIsRequired ifTrue: [ eachFilter filterValueString ].
							aFiltersElement addFilterForDescriptor: aDescriptor andValue: aLabel ] ] ]
]
