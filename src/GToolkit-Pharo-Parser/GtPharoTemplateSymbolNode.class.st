Class {
	#name : 'GtPharoTemplateSymbolNode',
	#superclass : 'GtPharoTemplatableNode',
	#instVars : [
		'_hash',
		'symbolParts'
	],
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'generated' }
GtPharoTemplateSymbolNode >> _hash [
	^ _hash
]

{ #category : 'generated' }
GtPharoTemplateSymbolNode >> _hash: aSmaCCToken [
	_hash := aSmaCCToken
]

{ #category : 'generated' }
GtPharoTemplateSymbolNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateSymbol: self
]

{ #category : 'generated-initialize-release' }
GtPharoTemplateSymbolNode >> initialize [
	super initialize.
	symbolParts := OrderedCollection new: 2.
]

{ #category : 'generated' }
GtPharoTemplateSymbolNode >> otherVariables [
	^ #(#symbolParts)
]

{ #category : 'generated' }
GtPharoTemplateSymbolNode >> symbolParts [
	^ symbolParts
]

{ #category : 'generated' }
GtPharoTemplateSymbolNode >> symbolParts: anOrderedCollection [
	self setParent: self symbolParts to: nil.
	symbolParts := anOrderedCollection.
	self setParent: self symbolParts to: self
]

{ #category : 'generated' }
GtPharoTemplateSymbolNode >> tokenVariables [
	^ #(#_hash)
]
