Class {
	#name : #GtStackContextVariableValueStylerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #examples }
GtStackContextVariableValueStylerExamples >> classReferencesHaveNoValue [
	"The debugger shows the values of the variables of a context, but not of the classes the method refers to
	(the variable name is a String from the source, the class name a Symbol)"

	<gtExample>
	<return: #GtStackContextVariableValueStyler>
	| styler |
	styler := GtStackContextVariableValueStyler new
			coderViewModel: (GtPharoMethodContextCoder forContext: (self contextWithClassReference: 42) session: nil)
					asCoderViewModel.
	self assert: (styler hasValueForVariableNamed: 'aNumber').
	self assert: (styler hasValueForVariableNamed: 'OrderedCollection') not.
	^ styler
]

{ #category : #private }
GtStackContextVariableValueStylerExamples >> contextWithClassReference: aNumber [
	| aCollection |
	aCollection := OrderedCollection new.
	aCollection add: aNumber.
	^ thisContext
]
