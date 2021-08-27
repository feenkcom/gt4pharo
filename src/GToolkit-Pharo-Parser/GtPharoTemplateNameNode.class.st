Class {
	#name : 'GtPharoTemplateNameNode',
	#superclass : 'GtPharoTemplatableNode',
	#instVars : [
		'nameParts'
	],
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'generated' }
GtPharoTemplateNameNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateName: self
]

{ #category : 'converting' }
GtPharoTemplateNameNode >> asSymbol [
	^ self source asSymbol
]

{ #category : 'generated-initialize-release' }
GtPharoTemplateNameNode >> initialize [
	super initialize.
	nameParts := OrderedCollection new: 2.
]

{ #category : 'generated' }
GtPharoTemplateNameNode >> nameParts [
	^ nameParts
]

{ #category : 'generated' }
GtPharoTemplateNameNode >> nameParts: anOrderedCollection [
	self setParent: self nameParts to: nil.
	nameParts := anOrderedCollection.
	self setParent: self nameParts to: self
]

{ #category : 'generated' }
GtPharoTemplateNameNode >> otherVariables [
	^ #(#nameParts)
]
