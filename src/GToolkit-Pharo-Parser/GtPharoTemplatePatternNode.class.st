Class {
	#name : #GtPharoTemplatePatternNode,
	#superclass : #GtPharoMethodPatternNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplatePatternNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplatePattern: self
]

{ #category : #generated }
GtPharoTemplatePatternNode >> compositeNodeVariables [
	^ #(#parts #variables)
]

{ #category : #'generated-initialize-release' }
GtPharoTemplatePatternNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoTemplatePatternNode >> parts [
	^ parts
]

{ #category : #generated }
GtPharoTemplatePatternNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]
