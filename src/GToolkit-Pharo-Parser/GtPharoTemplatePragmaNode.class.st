Class {
	#name : #GtPharoTemplatePragmaNode,
	#superclass : #GtPharoPragmaNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplatePragmaNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplatePragma: self
]

{ #category : #generated }
GtPharoTemplatePragmaNode >> compositeNodeVariables [
	^ #(#parts #values)
]

{ #category : #'generated-initialize-release' }
GtPharoTemplatePragmaNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoTemplatePragmaNode >> parts [
	^ parts
]

{ #category : #generated }
GtPharoTemplatePragmaNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]
