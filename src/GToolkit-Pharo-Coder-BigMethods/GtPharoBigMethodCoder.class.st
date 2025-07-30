Class {
	#name : #GtPharoBigMethodCoder,
	#superclass : #GtPharoMethodCoder,
	#category : #'GToolkit-Pharo-Coder-BigMethods-Coder'
}

{ #category : #'as yet unclassified' }
GtPharoBigMethodCoder >> asCoderViewModel [
	^ GtPharoBigMethodCoderViewModel new
		coder: self;
		yourself
]
