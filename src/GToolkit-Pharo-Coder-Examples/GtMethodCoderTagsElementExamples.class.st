Class {
	#name : #GtMethodCoderTagsElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #examples }
GtMethodCoderTagsElementExamples >> forClassSideMethodCoder [
	<gtExample>
	| aMethodCoder theTagsElement |
	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoDummyTwoObject class >> #sum21Reference.
	theTagsElement := GtPharoMethodCoderTagsElement new pharoMethodCoderViewModel: aMethodCoder asCoderViewModel.
	
	self assert: theTagsElement childrenCount equals: 2.
	self assert: (theTagsElement childAt: 2) label asString equals: 'class'.
	
	^ theTagsElement
]

{ #category : #examples }
GtMethodCoderTagsElementExamples >> forMethodCoder [
	<gtExample>
	| aMethodCoder theTagsElement |
	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoMethodCoderExamples >> #forExampleMethodCoder.
	theTagsElement := GtPharoMethodCoderTagsElement new pharoMethodCoderViewModel: aMethodCoder asCoderViewModel.
	
	self assert: theTagsElement childrenCount equals: 2.
	self assert: (theTagsElement childAt: 2) label asString equals: 'instance'.
	
	^ theTagsElement
]
