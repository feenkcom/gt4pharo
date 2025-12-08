Class {
	#name : #GtPharoTemplateKeywordMessageNode,
	#superclass : #GtPharoKeywordMessageNode,
	#instVars : [
		'parts'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplateKeywordMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateKeywordMessage: self
]

{ #category : #generated }
GtPharoTemplateKeywordMessageNode >> compositeNodeVariables [
	^ #(#parts #values)
]

{ #category : #'generated-initialize-release' }
GtPharoTemplateKeywordMessageNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoTemplateKeywordMessageNode >> parts [
	^ parts
]

{ #category : #generated }
GtPharoTemplateKeywordMessageNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]
