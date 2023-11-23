Class {
	#name : #GtPharoCoderMethodHeaderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'attributeElementStencil'
	],
	#category : #'GToolkit-Pharo-Coder-SelectorAttributes'
}

{ #category : #accessing }
GtPharoCoderMethodHeaderStyler >> attributeElementStencil: aStencilOrBlock [
	attributeElementStencil := aStencilOrBlock asStencil
]

{ #category : #accessing }
GtPharoCoderMethodHeaderStyler >> instantiateMethodHeaderAttribute [
	^ GtPharoCoderMethodHeaderTextAdornmentAttribute  new
			coderViewModel: self coderViewModel;
			attributeElementStencil: attributeElementStencil
]

{ #category : #visiting }
GtPharoCoderMethodHeaderStyler >> visitMethod: aMethodNode [
	self
		attribute: self instantiateMethodHeaderAttribute
		from: aMethodNode pattern stopPosition
		to: aMethodNode pattern stopPosition
]
