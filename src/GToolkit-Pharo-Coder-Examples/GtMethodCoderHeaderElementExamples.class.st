Class {
	#name : #GtMethodCoderHeaderElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #examples }
GtMethodCoderHeaderElementExamples >> headerForMethodFromClass [
	<gtExample>
	| aCoder aCoderViewModel aCoderBreadcrumb |
	
	aCoder := GtPharoMethodCoder forMethod: (GtBehaviorCoderDummyClass>>#instVarB:).
	aCoderViewModel := GtPharoMethodCoderViewModel new coderModel: aCoder.

	aCoderBreadcrumb := GtPharoMethodCoderHeaderElement new.
	aCoderBreadcrumb textualCoderViewModel: aCoderViewModel.
	
	self
		assert: aCoderBreadcrumb packageButton label asString
		equals: 'GToolkit-Coder-Examples'.
	self
		assert: aCoderBreadcrumb behaviorButton label asString
		equals: 'GtBehaviorCoderDummyClass'.
	
	
	
	^ aCoderBreadcrumb
]

{ #category : #examples }
GtMethodCoderHeaderElementExamples >> headerForMethodFromTrait [
	<gtExample>
	| aCoder aCoderViewModel aCoderBreadcrumb |
	
	aCoder := GtPharoMethodCoder forMethod: (GtBehaviorCoderDummyClass>>#methodFromTrait).
	aCoderViewModel := GtPharoMethodCoderViewModel new coderModel: aCoder.

	aCoderBreadcrumb := GtPharoMethodCoderHeaderElement new.
	aCoderBreadcrumb textualCoderViewModel: aCoderViewModel.
	
	self assert: aCoderBreadcrumb packageButton label asString equals: 'GToolkit-Coder-Examples'.
	self assert: aCoderBreadcrumb behaviorButton label asString equals: 'TGtBehaviorCoderDummyTrait'.
	
	^ aCoderBreadcrumb
]

{ #category : #examples }
GtMethodCoderHeaderElementExamples >> headerForOverwrittenMethodFromTrait [
	<gtExample>
	| aCoder aCoderViewModel aCoderBreadcrumb |
	
	aCoder := GtPharoMethodCoder forMethod: (GtBehaviorCoderDummyClass>>#overwrittenMethodFromTrait).
	aCoderViewModel := GtPharoMethodCoderViewModel new coderModel: aCoder.

	aCoderBreadcrumb := GtPharoMethodCoderHeaderElement new.
	aCoderBreadcrumb textualCoderViewModel: aCoderViewModel.
	
	self assert: aCoderBreadcrumb packageButton label asString equals: 'GToolkit-Coder-Examples'.
	self assert: aCoderBreadcrumb behaviorButton label asString equals: 'GtBehaviorCoderDummyClass'.
	
	^ aCoderBreadcrumb
]
