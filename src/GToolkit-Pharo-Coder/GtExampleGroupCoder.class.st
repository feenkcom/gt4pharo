Class {
	#name : #GtExampleGroupCoder,
	#superclass : #GtPharoMethodsCoder,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtExampleGroupCoder >> newCoderFor: aMethod [
	| coder |
	coder := GtPharoMethodCoder forExample: aMethod.
	coder coders: self.
	^ coder
]
