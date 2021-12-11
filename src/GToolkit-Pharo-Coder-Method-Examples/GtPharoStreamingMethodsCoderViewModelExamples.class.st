Class {
	#name : #GtPharoStreamingMethodsCoderViewModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoStreamingMethodsCoderViewModelExamples >> forSuperclass [
	<gtExample>
	| aCoder aViewModel theCoderViewModels |
	
	aCoder := GtPharoStreamingMethodsCoderExamples new forSuperclass.
	aViewModel := GtPharoStreamingMethodsCoderViewModel new streamingCodersModel: aCoder.
	
	self assert: aViewModel selfObject isNil.
	self assert: aViewModel shouldExpandByDefault not.
	self assert: aViewModel shouldHaveHeaderByDefault not.
	self assert: aViewModel hasScrollTarget not.
	self assert: aViewModel highlighter isNil.
	
	theCoderViewModels := aViewModel coderViewModelsStream toArray wait.
	self assert: theCoderViewModels size equals: 4.
	
	self assert: theCoderViewModels first expanded not.
	self assert: theCoderViewModels first wantsHeader not.
	self assert: theCoderViewModels first highlighter isNil.
	self assert: theCoderViewModels first selfObject isNil.
	self assert: theCoderViewModels first behavior equals: GtPharoCoderMockedSuperclass.
	self assert: theCoderViewModels first selector equals: #instanceMethodA.
	
	self assert: theCoderViewModels second expanded not.
	self assert: theCoderViewModels second wantsHeader not.
	self assert: theCoderViewModels second highlighter isNil.
	self assert: theCoderViewModels second selfObject isNil.
	self assert: theCoderViewModels second behavior equals: GtPharoCoderMockedSuperclass.
	self assert: theCoderViewModels second selector equals: #instanceMethodB.

	self assert: theCoderViewModels third expanded not.
	self assert: theCoderViewModels third wantsHeader not.
	self assert: theCoderViewModels third highlighter isNil.
	self assert: theCoderViewModels third selfObject isNil.
	self assert: theCoderViewModels third behavior equals: GtPharoCoderMockedSuperclass class.
	self assert: theCoderViewModels third selector equals: #classMethodA.

	self assert: theCoderViewModels fourth expanded not.
	self assert: theCoderViewModels fourth wantsHeader not.
	self assert: theCoderViewModels fourth highlighter isNil.
	self assert: theCoderViewModels fourth selfObject isNil.
	self assert: theCoderViewModels fourth behavior equals: GtPharoCoderMockedSuperclass class.
	self assert: theCoderViewModels fourth selector equals: #classMethodB.

	^ aViewModel
]
