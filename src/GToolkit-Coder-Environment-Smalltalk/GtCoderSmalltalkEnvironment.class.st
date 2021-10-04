Class {
	#name : #GtCoderSmalltalkEnvironment,
	#superclass : #Object,
	#category : #'GToolkit-Coder-Environment-Smalltalk'
}

{ #category : #accessing }
GtCoderSmalltalkEnvironment >> driver [
	^ self subclassResponsibility
]

{ #category : #'api - queries' }
GtCoderSmalltalkEnvironment >> methodProtocolOf: aGtCoderSmalltalkMethod [
	^ GtCoderSmalltalkMethodProtocolFuture new future: ([ self driver primitiveMethodProtocolOf: aGtCoderSmalltalkMethod asDictionaryForExport ] asFuture)
]

{ #category : #'api - queries' }
GtCoderSmalltalkEnvironment >> methodSourceCodeOf: aGtCoderSmalltalkMethod [
	^ GtCoderSmalltalkMethodSourceCodeFuture new future: ([ self driver primitiveMethodSourceCodeOf: aGtCoderSmalltalkMethod asDictionaryForExport ] asFuture)
]
