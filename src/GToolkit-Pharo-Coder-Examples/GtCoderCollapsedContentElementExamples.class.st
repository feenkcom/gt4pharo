Class {
	#name : #GtCoderCollapsedContentElementExamples,
	#superclass : #GtCoderContentElementExamples,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #accessing }
GtCoderCollapsedContentElementExamples >> addOnsAptitude_withTestMethod [
	<gtExample>
	| aMethodCoder aContentElement |
	aMethodCoder := GtPharoMethodCoder
		forMethod: GtPharoDummyTestCase >> #testPassedOne.
	aContentElement := GtSourceCoderCollapsedContentElement new
		coderViewModel: aMethodCoder asCoderViewModel.
	
	^ aContentElement
]

{ #category : #'examples - looks' }
GtCoderCollapsedContentElementExamples >> forExampleCoder [
	<gtExample>
	| aMethodCoder aContentElement |
	
	aMethodCoder := GtPharoMethodCoder forMethod: self class >> #greenExample.
	aContentElement := GtSourceCoderCollapsedContentElement new
		coderViewModel: aMethodCoder asCoderViewModel.

	^ aContentElement
]

{ #category : #examples }
GtCoderCollapsedContentElementExamples >> forMethodCoder [
	<gtExample>
	| aMethodCoder aContentElement |
	aMethodCoder := GtPharoMethodCoder
		forMethod: BlElement >> #position:extent:context:.
	aContentElement := GtSourceCoderCollapsedContentElement new
		coderViewModel: aMethodCoder asCoderViewModel.	
	^ aContentElement
]

{ #category : #'example - samples' }
GtCoderCollapsedContentElementExamples >> greenExample [
	<gtExample>
	^ 42
]

{ #category : #'example - samples' }
GtCoderCollapsedContentElementExamples >> noExample [
	^ 42
]

{ #category : #'examples - looks' }
GtCoderCollapsedContentElementExamples >> textAndExampleLook_withExampleMethod [
	<gtExample>
	| aMethodCoder aContentElement |
	aMethodCoder := GtPharoMethodCoder forMethod: self class >> #greenExample.
	aMethodCoder example run.
	aContentElement := GtSourceCoderCollapsedContentElement new
		coderViewModel: aMethodCoder asCoderViewModel.
	aContentElement addAptitude: BrLayoutResizerAptitude inherit.
	^ aContentElement
]

{ #category : #'examples - looks' }
GtCoderCollapsedContentElementExamples >> textAndExampleLook_withRegularMethod [
	<gtExample>
	| aMethodCoder aContentElement |
	aMethodCoder := GtPharoMethodCoder forMethod: self class >> #noExample.
	aContentElement := GtSourceCoderCollapsedContentElement new
		coderViewModel: aMethodCoder asCoderViewModel.
	^ aContentElement
]
