Class {
	#name : #GtPharoTemplateVariableNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'parts'
	],
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplateVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateVariable: self
]

{ #category : #generated }
GtPharoTemplateVariableNode >> compositeNodeVariables [
	^ #(#parts)
]

{ #category : #'generated-initialize-release' }
GtPharoTemplateVariableNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoTemplateVariableNode >> parts [
	^ parts
]

{ #category : #generated }
GtPharoTemplateVariableNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]
