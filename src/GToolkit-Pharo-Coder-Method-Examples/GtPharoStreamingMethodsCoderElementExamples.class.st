Class {
	#name : #GtPharoStreamingMethodsCoderElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoStreamingMethodsCoderElementExamples >> forSuperclass [
	<gtExample>
	| aViewModel anElement aScripter |
	
	aViewModel := GtPharoStreamingMethodsCoderViewModelExamples new forSuperclass.

	anElement := GtPharoStreamingMethodsCoderElement new
		streamingCodersViewModel: aViewModel.

	aScripter := BlDevScripter new
		element: anElement.

	^ aScripter
]
