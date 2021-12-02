Class {
	#name : #GtMethodCoderHeaderElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #examples }
GtMethodCoderHeaderElementExamples >> headerForMethodCoder [
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
GtMethodCoderHeaderElementExamples >> methodCoder [
	<gtExample>
	
	^ GtPharoMethodCoder forMethod: (GtBehaviorCoderDummyClass >> #instVarB:)
]

{ #category : #'instance creation' }
GtMethodCoderHeaderElementExamples >> methodCoderUIModel [
	<gtExample>
	
	^ GtPharoMethodCoderViewModel new coderModel: self methodCoder
]
