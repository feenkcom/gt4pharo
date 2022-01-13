Class {
	#name : #GtMethodCoderTagsElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #examples }
GtMethodCoderTagsElementExamples >> forMethodCoder [
	<gtExample>
	| aMethodCoder theTagsElement |
	aMethodCoder := GtPharoMethodCoder forMethod: GtPharoMethodCoderExamples >> #forExampleMethodCoder.
	theTagsElement := GtPharoMethodCoderTagsElement new pharoMethodCoderViewModel: aMethodCoder asCoderViewModel.
	^ theTagsElement
]
