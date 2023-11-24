Class {
	#name : #GtPharoSequenceNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'periods',
		'statements',
		'leftBar',
		'variables',
		'rightBar'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoSequenceNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSequence: self
]

{ #category : #generated }
GtPharoSequenceNode >> compositeNodeVariables [
	^ #(#statements #variables)
]

{ #category : #testing }
GtPharoSequenceNode >> defines: aString [
	^ variables anySatisfy: [ :each | each name value = aString ]
]

{ #category : #generated }
GtPharoSequenceNode >> ignoredCompositeTokenVariables [
	^ #(#periods)
]

{ #category : #generated }
GtPharoSequenceNode >> ignoredTokenVariables [
	^ #(#leftBar #rightBar)
]

{ #category : #'generated-initialize-release' }
GtPharoSequenceNode >> initialize [
	super initialize.
	statements := OrderedCollection new: 2.
	periods := OrderedCollection new: 2.
	variables := OrderedCollection new: 2.
]

{ #category : #testing }
GtPharoSequenceNode >> isSequence [
	^ true
]

{ #category : #testing }
GtPharoSequenceNode >> lastIsReturn [
	^ statements notEmpty and: [ statements last isReturn ]
]

{ #category : #generated }
GtPharoSequenceNode >> leftBar [
	^ leftBar
]

{ #category : #generated }
GtPharoSequenceNode >> leftBar: aSmaCCToken [
	leftBar := aSmaCCToken
]

{ #category : #accessing }
GtPharoSequenceNode >> localVariablesInto: aCollection [
	variables do: [ :each | aCollection add: each variableName ].
	super localVariablesInto: aCollection
]

{ #category : #generated }
GtPharoSequenceNode >> periods [
	^ periods
]

{ #category : #generated }
GtPharoSequenceNode >> periods: anOrderedCollection [
	periods := anOrderedCollection
]

{ #category : #accessing }
GtPharoSequenceNode >> pragmas [
	^ #()
]

{ #category : #generated }
GtPharoSequenceNode >> rightBar [
	^ rightBar
]

{ #category : #generated }
GtPharoSequenceNode >> rightBar: aSmaCCToken [
	rightBar := aSmaCCToken
]

{ #category : #generated }
GtPharoSequenceNode >> statements [
	^ statements
]

{ #category : #generated }
GtPharoSequenceNode >> statements: anOrderedCollection [
	self setParents: self statements to: nil.
	statements := anOrderedCollection.
	self setParents: self statements to: self
]

{ #category : #generated }
GtPharoSequenceNode >> variables [
	^ variables
]

{ #category : #generated }
GtPharoSequenceNode >> variables: anOrderedCollection [
	self setParents: self variables to: nil.
	variables := anOrderedCollection.
	self setParents: self variables to: self
]
