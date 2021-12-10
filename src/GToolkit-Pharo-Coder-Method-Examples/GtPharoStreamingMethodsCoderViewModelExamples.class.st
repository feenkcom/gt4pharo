Class {
	#name : #GtPharoStreamingMethodsCoderViewModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoStreamingMethodsCoderViewModelExamples >> forSuperclass [
	<gtExample>
	| aCoder aViewModel theCoderViewModels |
	
	aCoder := GtPharoStreamingBehaviorMethodsCoderExamples new forSuperclass.
	aViewModel := GtPharoStreamingMethodsCoderViewModel new streamingCodersModel: aCoder.
	
	self assert: aViewModel selfObject isNil.
	self assert: aViewModel shouldExpandByDefault not.
	self assert: aViewModel shouldHaveHeaderByDefault not.
	self assert: aViewModel hasScrollTarget not.
	self assert: aViewModel highlighter isNil.
	
	theCoderViewModels := aViewModel coderViewModelsStream toArray wait.
	self assert: theCoderViewModels size equals: 1.
	
	self assert: theCoderViewModels first expanded not.
	self assert: theCoderViewModels first wantsHeader not.
	self assert: theCoderViewModels first highlighter isNil.
	self assert: theCoderViewModels first selfObject isNil.

	^ aViewModel
]
