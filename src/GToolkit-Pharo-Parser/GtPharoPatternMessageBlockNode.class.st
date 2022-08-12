Class {
	#name : #GtPharoPatternMessageBlockNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'leftBrace',
		'colons',
		'variables',
		'bar',
		'body',
		'rightBrace',
		'node'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoPatternMessageBlockNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPatternMessageBlock: self
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> bar [
	^ bar
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> bar: aSmaCCToken [
	bar := aSmaCCToken
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> body [
	^ body
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> body: aGtPharoSequenceNode [
	self body notNil ifTrue: [ self body parent: nil ].
	body := aGtPharoSequenceNode.
	self body notNil ifTrue: [ self body parent: self ]
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> colons [
	^ colons
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> colons: anOrderedCollection [
	colons := anOrderedCollection
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> compositeNodeVariables [
	^ #(#variables)
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> ignoredCompositeTokenVariables [
	^ #(#colons #leftParens #rightParens)
]

{ #category : #'generated-initialize-release' }
GtPharoPatternMessageBlockNode >> initialize [
	super initialize.
	colons := OrderedCollection new: 2.
	variables := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> leftBrace [
	^ leftBrace
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> leftBrace: aSmaCCToken [
	leftBrace := aSmaCCToken
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> node [
	^ node
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> node: aGtPharoValueNode [
	self node notNil ifTrue: [ self node parent: nil ].
	node := aGtPharoValueNode.
	self node notNil ifTrue: [ self node parent: self ]
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> nodeVariables [
	^ #(#body #node)
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> rightBrace [
	^ rightBrace
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> rightBrace: aSmaCCToken [
	rightBrace := aSmaCCToken
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> tokenVariables [
	^ #(#leftBrace #bar #rightBrace)
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> variables [
	^ variables
]

{ #category : #generated }
GtPharoPatternMessageBlockNode >> variables: anOrderedCollection [
	self setParents: self variables to: nil.
	variables := anOrderedCollection.
	self setParents: self variables to: self
]
