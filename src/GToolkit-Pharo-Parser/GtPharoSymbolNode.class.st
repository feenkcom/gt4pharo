Class {
	#name : #GtPharoSymbolNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'_hash',
		'symbolParts'
	],
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoSymbolNode >> _hash [
	^ _hash
]

{ #category : #generated }
GtPharoSymbolNode >> _hash: aSmaCCToken [
	_hash := aSmaCCToken
]

{ #category : #generated }
GtPharoSymbolNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSymbol: self
]

{ #category : #'generated-initialize-release' }
GtPharoSymbolNode >> initialize [
	super initialize.
	symbolParts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoSymbolNode >> otherVariables [
	^ #(#symbolParts)
]

{ #category : #generated }
GtPharoSymbolNode >> symbolParts [
	^ symbolParts
]

{ #category : #generated }
GtPharoSymbolNode >> symbolParts: anOrderedCollection [
	self setParent: self symbolParts to: nil.
	symbolParts := anOrderedCollection.
	self setParent: self symbolParts to: self
]

{ #category : #generated }
GtPharoSymbolNode >> tokenVariables [
	^ #(#_hash)
]
