Class {
	#name : #GtPharoCoderMethodHeaderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'activationCodition',
		'attributeElementStencil'
	],
	#category : #'GToolkit-Pharo-Coder-SelectorAttributes'
}

{ #category : #accessing }
GtPharoCoderMethodHeaderStyler >> attributeElementStencil: aStencilOrBlock [
	attributeElementStencil := aStencilOrBlock "asStencil"
]

{ #category : #accessing }
GtPharoCoderMethodHeaderStyler >> instantiateMethodHeaderAttribute [
	^ GtPharoCoderMethodHeaderTextAdornmentAttribute  new
			coderViewModel: self coderViewModel;
			attributeElementStencil: attributeElementStencil
]

{ #category : #testing }
GtPharoCoderMethodHeaderStyler >> shouldShowAttribute [
	^ activationCodition 
		ifNil: [ true ]
		ifNotNil: [ :aBlock | 
			aBlock 
				cull: self coderViewModel coderModel 
				cull: self coderViewModel ]
]

{ #category : #configuration }
GtPharoCoderMethodHeaderStyler >> showWhen: aBlock [
	activationCodition := aBlock
]

{ #category : #visiting }
GtPharoCoderMethodHeaderStyler >> visitMethod: aMethodNode [
	self shouldShowAttribute ifFalse: [ ^ self ].

	self
		attribute: self instantiateMethodHeaderAttribute
		from: aMethodNode pattern stopPosition
		to: aMethodNode pattern stopPosition
]
