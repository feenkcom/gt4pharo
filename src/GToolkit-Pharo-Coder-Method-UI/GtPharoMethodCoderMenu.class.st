Class {
	#name : #GtPharoMethodCoderMenu,
	#superclass : #GtTextualCoderMenu,
	#traits : 'TGtCoderWithSelfObjectHolder',
	#classTraits : 'TGtCoderWithSelfObjectHolder classTrait',
	#category : #'GToolkit-Pharo-Coder-Method-UI-Menu'
}

{ #category : #visiting }
GtPharoMethodCoderMenu >> acceptVisitor: aVisitor [
	^ aVisitor visitPharoMethodCoderMenu: self
]

{ #category : #'api - initialization' }
GtPharoMethodCoderMenu >> forMethod: aCompiledMethod [
	self coder: (GtPharoMethodCoder forMethod: aCompiledMethod)
]
