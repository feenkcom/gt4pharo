Class {
	#name : #GtRBAddClassVariableRefactoring,
	#superclass : #RBAddClassVariableRefactoring,
	#instVars : [
		'classObject'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #transforming }
GtRBAddClassVariableRefactoring >> prepareForExecution [
	class := self classObjectFor: classObject.
	super prepareForExecution
]

{ #category : #initialization }
GtRBAddClassVariableRefactoring >> variable: aVarName class: aClassName [
	classObject := aClassName.
	variableName := aVarName
]
