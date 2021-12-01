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

	aCoderBreadcrumb := GtPharoMethodCoderHeaderElement new.
	aCoderBreadcrumb textualCoderViewModel: aCoderUIModel.
	
	self assert: aCoderBreadcrumb packageButton label asString equals: 'GToolkit-Coder-Examples'.
	self assert: aCoderBreadcrumb behaviorButton label asString equals: 'GtBehaviorCoderDummyClass'.
	
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
