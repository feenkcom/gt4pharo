Class {
	#name : #GtRBAddInstanceVariableRefactoring,
	#superclass : #RBAddInstanceVariableRefactoring,
	#instVars : [
		'classObject'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #transforming }
GtRBAddInstanceVariableRefactoring >> prepareForExecution [
	class := self classObjectFor: classObject.
	super prepareForExecution
]

{ #category : #initialization }
GtRBAddInstanceVariableRefactoring >> refactoredClassName [
	^ classObject isString ifTrue: [ classObject ] ifFalse: [ classObject name ]
]

{ #category : #initialization }
GtRBAddInstanceVariableRefactoring >> variable: aVarName class: aClassName [
	classObject := aClassName.
	variableName := aVarName
]
