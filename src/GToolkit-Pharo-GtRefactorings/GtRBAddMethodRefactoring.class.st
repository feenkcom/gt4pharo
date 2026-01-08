Class {
	#name : #GtRBAddMethodRefactoring,
	#superclass : #RBAddMethodRefactoring,
	#instVars : [
		'classObject'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #accessing }
GtRBAddMethodRefactoring >> gtDescription [
	^ 'Add method ' , self methodClassName , '>>' , self selector
]

{ #category : #initialization }
GtRBAddMethodRefactoring >> initializeTransformation [
	transformation := RBAddMethodTransformation
			model: model
			sourceCode: source
			in: self methodClass
			withProtocol: protocol
]

{ #category : #accessing }
GtRBAddMethodRefactoring >> methodClass [
	^ class ifNil: [ class := self classObjectFor: classObject ]
]

{ #category : #accessing }
GtRBAddMethodRefactoring >> methodClassName [
	^ classObject isString ifTrue: [ classObject ] ifFalse: [ classObject name ]
]

{ #category : #transforming }
GtRBAddMethodRefactoring >> prepareForExecution [
	self initializeTransformation.
	super prepareForExecution
]

{ #category : #accessing }
GtRBAddMethodRefactoring >> selector [
	^ [ | ast |
	ast := RBParser parseFaultyMethod: source.
	ast selector ] on: Error do: [ :ex | ex return: '???' ]
]

{ #category : #initialization }
GtRBAddMethodRefactoring >> sourceCode: aString in: aClass withProtocol: aProtocol [
	classObject := aClass.
	source := aString.
	protocol := aProtocol
]
