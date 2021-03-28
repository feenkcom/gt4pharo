Class {
	#name : #GtCoderContentElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #examples }
GtCoderContentElementExamples >> methodCoder [
	<gtExample>
	
	^ GtPharoMethodCoder forMethod: (BlElement >> #position:extent:context:)
]
