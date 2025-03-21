Class {
	#name : #GtPharoCoderMethodHeaderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'attributeElementStencil'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #'as yet unclassified' }
GtPharoCoderMethodHeaderStyler >> = anObject [
	^ self class == anObject class
]

{ #category : #accessing }
GtPharoCoderMethodHeaderStyler >> attributeElementStencil: aStencilOrBlock [
	attributeElementStencil := aStencilOrBlock asStencil
]

{ #category : #comparing }
GtPharoCoderMethodHeaderStyler >> hash [
	"To satisfy advices about implementing along with ="
	^ super hash
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
