Class {
	#name : #GtPharoTemplateUnaryMessageNode,
	#superclass : #GtPharoUnaryMessageNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplateUnaryMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateUnaryMessage: self
]

{ #category : #generated }
GtPharoTemplateUnaryMessageNode >> compositeNodeVariables [
	^ #(#parts)
]

{ #category : #'generated-initialize-release' }
GtPharoTemplateUnaryMessageNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoTemplateUnaryMessageNode >> parts [
	^ parts
]

{ #category : #generated }
GtPharoTemplateUnaryMessageNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]
