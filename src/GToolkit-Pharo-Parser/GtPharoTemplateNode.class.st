Class {
	#name : #GtPharoTemplateNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'leftBraces',
		'expression',
		'rightBraces'
	],
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoTemplateNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplate: self
]

{ #category : #generated }
GtPharoTemplateNode >> expression [
	^ expression
]

{ #category : #generated }
GtPharoTemplateNode >> expression: aGtPharoValueNode [
	self expression notNil
		ifTrue: [ self expression parent: nil ].
	expression := aGtPharoValueNode.
	self expression notNil
		ifTrue: [ self expression parent: self ]
]

{ #category : #generated }
GtPharoTemplateNode >> leftBraces [
	^ leftBraces
]

{ #category : #generated }
GtPharoTemplateNode >> leftBraces: aSmaCCToken [
	leftBraces := aSmaCCToken
]

{ #category : #generated }
GtPharoTemplateNode >> nodeVariables [
	^ #(#expression)
]

{ #category : #generated }
GtPharoTemplateNode >> rightBraces [
	^ rightBraces
]

{ #category : #generated }
GtPharoTemplateNode >> rightBraces: aSmaCCToken [
	rightBraces := aSmaCCToken
]

{ #category : #generated }
GtPharoTemplateNode >> tokenVariables [
	^ #(#leftBraces #rightBraces)
]
