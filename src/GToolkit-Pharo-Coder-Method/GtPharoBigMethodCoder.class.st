Class {
	#name : #GtPharoBigMethodCoder,
	#superclass : #GtPharoMethodCoder,
	#category : #'GToolkit-Pharo-Coder-Method-Big Methods'
}

{ #category : #initialization }
GtPharoBigMethodCoder class >> initialize [
	super initialize.
	GtMethodCoderRegistry default addCoderClass: self
]

{ #category : #'coder selection' }
GtPharoBigMethodCoder class >> isCoderValidFor: aCompiledMethod [
	^ aCompiledMethod sourceCode size > 10000
]

{ #category : #'coder selection' }
GtPharoBigMethodCoder class >> priority [
	^50
]
