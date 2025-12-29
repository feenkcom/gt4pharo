Class {
	#name : #GtRBAddMethodRefactoring,
	#superclass : #RBAddMethodRefactoring,
	#instVars : [
		'classObject'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

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

{ #category : #transforming }
GtRBAddMethodRefactoring >> prepareForExecution [
	self initializeTransformation.
	super prepareForExecution
]

{ #category : #initialization }
GtRBAddMethodRefactoring >> sourceCode: aString in: aClass withProtocol: aProtocol [
	classObject := aClass.
	source := aString.
	protocol := aProtocol
]
