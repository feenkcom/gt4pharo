Class {
	#name : #GtPharoCharacterLiteralNode,
	#superclass : #GtPharoLiteralNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoCharacterLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCharacterLiteral: self
]

{ #category : #accessing }
GtPharoCharacterLiteralNode >> guessType: completionStrategy [
	^ Character
]

{ #category : #accessing }
GtPharoCharacterLiteralNode >> literalValue [
	^ self value value second
]

{ #category : #generated }
GtPharoCharacterLiteralNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoCharacterLiteralNode >> value [
	^ value
]

{ #category : #generated }
GtPharoCharacterLiteralNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
