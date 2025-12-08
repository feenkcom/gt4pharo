Class {
	#name : #GtPharoTemplateNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'leftBraces',
		'expression',
		'rightBraces'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplateNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplate: self
]

{ #category : #accessing }
GtPharoTemplateNode >> asSymbol [
	^ self expression source asSymbol
]

{ #category : #generated }
GtPharoTemplateNode >> expression [
	^ expression
]

{ #category : #generated }
GtPharoTemplateNode >> expression: aGtPharoValueNode [
	self expression notNil ifTrue: [ self expression parent: nil ].
	expression := aGtPharoValueNode.
	self expression notNil ifTrue: [ self expression parent: self ]
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

{ #category : #accessing }
GtPharoTemplateNode >> selector [
	^ self asSymbol
]

{ #category : #generated }
GtPharoTemplateNode >> tokenVariables [
	^ #(#leftBraces #rightBraces)
]

{ #category : #accessing }
GtPharoTemplateNode >> variableName [
	^ self source asSymbol
]
