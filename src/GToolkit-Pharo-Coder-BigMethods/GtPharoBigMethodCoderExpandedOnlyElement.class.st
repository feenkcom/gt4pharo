Class {
	#name : #GtPharoBigMethodCoderExpandedOnlyElement,
	#superclass : #GtPharoMethodCoderExpandedOnlyElement,
	#category : #'GToolkit-Pharo-Coder-BigMethods-Coder'
}

{ #category : #initialization }
GtPharoBigMethodCoderExpandedOnlyElement >> newExpandedElement [
	^ GtPharoBigMethodExpandedSourceCoderElement new
		yourself
]
