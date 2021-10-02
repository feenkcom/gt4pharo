Class {
	#name : #GtCoderSmalltalkEnvironmentDriver,
	#superclass : #Object,
	#category : #'GToolkit-Coder-Environment-Smalltalk-Core'
}

{ #category : #'private - methods' }
GtCoderSmalltalkEnvironmentDriver >> primitiveMethodProtocolOf: aGtCoderSmalltalkMethodDictionary [
	^ self subclassResponsibility
]

{ #category : #'private - methods' }
GtCoderSmalltalkEnvironmentDriver >> primitiveMethodSourceCodeOf: aGtCoderSmalltalkMethodDictionary [
	^ self subclassResponsibility
]
