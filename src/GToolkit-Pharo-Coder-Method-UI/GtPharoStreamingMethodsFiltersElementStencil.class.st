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
	self defaultStencilClass: GtPharoStreamingMethodsFiltersElementFromDescriptorsStencil
]

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> beModelStencilDefault [
	self defaultStencilClass: GtPharoStreamingMethodsFiltersElementFromModelStencil
]

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> defaultStencil [
	^ self defaultStencilClass new
]

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> defaultStencilClass [
	^ DefaultBuilderClass
		ifNil: [ DefaultBuilderClass := GtPharoStreamingMethodsFiltersElementFromModelStencil ]
]

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> defaultStencilClass: aClassOrNil [
	GtPharoStreamingMethodsFiltersElementStencilDefaultChangedSignal new
		previousClass: DefaultBuilderClass;
		newClass: aClassOrNil;
		emit.
	DefaultBuilderClass := aClassOrNil
]

{ #category : #defaults }
GtPharoStreamingMethodsFiltersElementStencil class >> defaultStencilClassOrNil [
	^ DefaultBuilderClass
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
