Class {
	#name : #GtPharoArrayNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'leftBrace',
		'rightBrace',
		'periods',
		'values'
	],
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoArrayNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitArray: self
]

{ #category : #generated }
GtPharoArrayNode >> compositeNodeVariables [
	^ #(#values)
]

{ #category : #accessing }
GtPharoArrayNode >> guessType: completionStrategy [
	^ Array
]

{ #category : #generated }
GtPharoArrayNode >> ignoredCompositeTokenVariables [
	^ #(#periods #leftParens #rightParens)
]

{ #category : #'generated-initialize-release' }
GtPharoArrayNode >> initialize [
	super initialize.
	periods := OrderedCollection new: 2.
	values := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoArrayNode >> leftBrace [
	^ leftBrace
]

{ #category : #generated }
GtPharoArrayNode >> leftBrace: aSmaCCToken [
	leftBrace := aSmaCCToken
]

{ #category : #accessing }
GtPharoArrayNode >> nestingLevel [
	^ 1 + super nestingLevel
]

{ #category : #generated }
GtPharoArrayNode >> periods [
	^ periods
]

{ #category : #generated }
GtPharoArrayNode >> periods: anOrderedCollection [
	periods := anOrderedCollection
]

{ #category : #generated }
GtPharoArrayNode >> rightBrace [
	^ rightBrace
]

{ #category : #generated }
GtPharoArrayNode >> rightBrace: aSmaCCToken [
	rightBrace := aSmaCCToken
]

{ #category : #generated }
GtPharoArrayNode >> tokenVariables [
	^ #(#leftBrace #rightBrace)
]

{ #category : #generated }
GtPharoArrayNode >> values [
	^ values
]

{ #category : #generated }
GtPharoArrayNode >> values: anOrderedCollection [
	self setParents: self values to: nil.
	values := anOrderedCollection.
	self setParents: self values to: self
]
