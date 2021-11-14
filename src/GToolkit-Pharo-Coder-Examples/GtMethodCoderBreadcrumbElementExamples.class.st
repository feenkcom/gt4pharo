Class {
	#name : #GtMethodCoderBreadcrumbElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #examples }
GtMethodCoderBreadcrumbElementExamples >> breadcrumbForSourceCoder [
	<gtExample>
	| aCoderUIModel aCoderBreadcrumb |
	
	aCoderUIModel := self methodCoderUIModel.

	aCoderBreadcrumb := GtMethodCoderBreadcrumbElement new.
	aCoderBreadcrumb textualCoderViewModel: aCoderUIModel.
	
	self assert: aCoderBreadcrumb numberOfItems equals: 2.
	self assert: (aCoderBreadcrumb itemAt: 1) model package name equals: #'GToolkit-Coder-Examples'.
	self assert: (aCoderBreadcrumb itemAt: 2) model name equals: #'GtBehaviorCoderDummyClass'.
	
	^ aCoderBreadcrumb
]

{ #category : #'instance creation' }
GtMethodCoderBreadcrumbElementExamples >> methodCoder [
	<gtExample>
	
	^ GtPharoMethodCoder forMethod: (GtBehaviorCoderDummyClass >> #instVarB:)
]

{ #category : #'instance creation' }
GtMethodCoderBreadcrumbElementExamples >> methodCoderUIModel [
	<gtExample>
	
	^ GtSourceCoderViewModel new coder: self methodCoder
]
