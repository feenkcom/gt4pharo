Class {
	#name : #GtCoderPharoEnvironmentDriver,
	#superclass : #GtCoderSmalltalkEnvironmentDriver,
	#category : #'GToolkit-Coder-Environment-Pharo-Driver-GToolkit-Coder-Environment-Pharo-Driver'
}

{ #category : #'private - methods' }
GtCoderPharoEnvironmentDriver >> primitiveMethodProtocolOf: aGtCoderSmalltalkMethodDictionary [
	| aPharoMethod |

	aPharoMethod := GtCoderBaseSmalltalkMethod fromJSONDictionary: aGtCoderSmalltalkMethodDictionary.

	^ ((self class environment at: aPharoMethod behavior name) >> aPharoMethod selector) protocol
]

{ #category : #'private - methods' }
GtCoderPharoEnvironmentDriver >> primitiveMethodSourceCodeOf: aGtCoderSmalltalkMethodDictionary [
	| aPharoMethod |
	
	aPharoMethod := GtCoderBaseSmalltalkMethod fromJSONDictionary: aGtCoderSmalltalkMethodDictionary.

	^ ((self class environment at: aPharoMethod behavior name) >> aPharoMethod selector) sourceCode
]
