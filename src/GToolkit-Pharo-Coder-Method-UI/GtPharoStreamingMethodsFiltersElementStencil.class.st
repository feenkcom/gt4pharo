Class {
	#name : #GtPharoStreamingMethodsFiltersElementStencil,
	#superclass : #BrStencil,
	#instVars : [
		'streamingCodersViewModel'
	],
	#classVars : [
		'DefaultBuilderClass'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> beDescriptorsStencilDefault [
	DefaultBuilderClass := GtPharoStreamingMethodsFiltersElementFromDescriptorsStencil
]

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> beModelStencilDefault [
	DefaultBuilderClass := GtPharoStreamingMethodsFiltersElementFromModelStencil
]

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> defaultStencil [
	^ self defaultStencilClass new
]

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> defaultStencilClass [
	^ DefaultBuilderClass
		ifNil: [ DefaultBuilderClass := GtPharoStreamingMethodsFiltersElementFromDescriptorsStencil ]
]

{ #category : #accessing }
GtPharoStreamingMethodsFiltersElementStencil >> streamingCodersViewModel [
	^ streamingCodersViewModel
]

{ #category : #accessing }
GtPharoStreamingMethodsFiltersElementStencil >> streamingCodersViewModel: aViewModel [
	self
		assert: [ aViewModel isNotNil ]
		description: [ 'Streaming coders view model must be non-nil' ].
	self
		assert: [ streamingCodersViewModel isNil ]
		description: [ 'Streaming coders view model can be set only once' ].

	streamingCodersViewModel := aViewModel
]

{ #category : #'api - updating' }
GtPharoStreamingMethodsFiltersElementStencil >> updateFiltersElement: aFilterElement [
	self subclassResponsibility
]
