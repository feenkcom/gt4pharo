Class {
	#name : #GtPharoMethodCoderMenu,
	#superclass : #GtTextualCoderMenu,
	#traits : 'TGtPhlowWithSelfObjectHolder',
	#classTraits : 'TGtPhlowWithSelfObjectHolder classTrait',
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
