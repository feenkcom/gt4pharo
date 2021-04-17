Class {
	#name : #GtPharoPragmaNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'lessThan',
		'selectorParts',
		'greaterThan',
		'values'
	],
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoPragmaNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPragma: self
]

{ #category : #generated }
GtPharoPragmaNode >> greaterThan [
	^ greaterThan
]

{ #category : #generated }
GtPharoPragmaNode >> greaterThan: aSmaCCToken [
	greaterThan := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GtPharoPragmaNode >> initialize [
	super initialize.
	selectorParts := OrderedCollection new: 2.
	values := OrderedCollection new: 2.
]

{ #category : #testing }
GtPharoPragmaNode >> isPragma [
	^ true
]

{ #category : #generated }
GtPharoPragmaNode >> lessThan [
	^ lessThan
]

{ #category : #generated }
GtPharoPragmaNode >> lessThan: aSmaCCToken [
	lessThan := aSmaCCToken
]

{ #category : #generated }
GtPharoPragmaNode >> otherVariables [
	^ #(#selectorParts #values)
]

{ #category : #accessing }
GtPharoPragmaNode >> selector [
	^ Symbol streamContents: [ :stream | self selectorParts do: [ :each | stream nextPutAll: each value ] ]
]

{ #category : #generated }
GtPharoPragmaNode >> selectorParts [
	^ selectorParts
]

{ #category : #generated }
GtPharoPragmaNode >> selectorParts: anOrderedCollection [
	self setParent: self selectorParts to: nil.
	selectorParts := anOrderedCollection.
	self setParent: self selectorParts to: self
]

{ #category : #generated }
GtPharoPragmaNode >> tokenVariables [
	^ #(#lessThan #greaterThan)
]

{ #category : #generated }
GtPharoPragmaNode >> values [
	^ values
]

{ #category : #generated }
GtPharoPragmaNode >> values: anOrderedCollection [
	self setParent: self values to: nil.
	values := anOrderedCollection.
	self setParent: self values to: self
]
