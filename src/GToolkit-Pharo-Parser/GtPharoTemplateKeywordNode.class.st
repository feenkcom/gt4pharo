Class {
	#name : #GtPharoTemplateKeywordNode,
	#superclass : #GtPharoTemplatableNode,
	#instVars : [
		'selectorParts'
	],
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoTemplateKeywordNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateKeyword: self
]

{ #category : #'generated-initialize-release' }
GtPharoTemplateKeywordNode >> initialize [
	super initialize.
	selectorParts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoTemplateKeywordNode >> otherVariables [
	^ #(#selectorParts)
]

{ #category : #generated }
GtPharoTemplateKeywordNode >> selectorParts [
	^ selectorParts
]

{ #category : #generated }
GtPharoTemplateKeywordNode >> selectorParts: anOrderedCollection [
	self setParent: self selectorParts to: nil.
	selectorParts := anOrderedCollection.
	self setParent: self selectorParts to: self
]
