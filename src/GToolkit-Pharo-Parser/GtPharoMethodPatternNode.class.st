Class {
	#name : #GtPharoMethodPatternNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'selectorParts',
		'variables'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoMethodPatternNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMethodPattern: self
]

{ #category : #generated }
GtPharoMethodPatternNode >> compositeNodeVariables [
	^ #(#variables)
]

{ #category : #'generated-initialize-release' }
GtPharoMethodPatternNode >> initialize [
	super initialize.
	selectorParts := OrderedCollection new: 2.
	variables := OrderedCollection new: 2.
]

{ #category : #testing }
GtPharoMethodPatternNode >> isMethodPattern [
	^ true
]

{ #category : #generated }
GtPharoMethodPatternNode >> otherVariables [
	^ #(#selectorParts)
]

{ #category : #accessing }
GtPharoMethodPatternNode >> selector [
	^ Symbol streamContents: [ :stream | self selectorParts do: [ :each | stream nextPutAll: each selector ] ]
]

{ #category : #generated }
GtPharoMethodPatternNode >> selectorParts [
	^ selectorParts
]

{ #category : #generated }
GtPharoMethodPatternNode >> selectorParts: anOrderedCollection [
	self setParent: self selectorParts to: nil.
	selectorParts := anOrderedCollection.
	self setParent: self selectorParts to: self
]

{ #category : #generated }
GtPharoMethodPatternNode >> variables [
	^ variables
]

{ #category : #generated }
GtPharoMethodPatternNode >> variables: anOrderedCollection [
	self setParents: self variables to: nil.
	variables := anOrderedCollection.
	self setParents: self variables to: self
]
