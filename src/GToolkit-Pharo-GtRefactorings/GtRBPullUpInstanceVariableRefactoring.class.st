Class {
	#name : #GtRBPullUpInstanceVariableRefactoring,
	#superclass : #RBPullUpInstanceVariableRefactoring,
	#instVars : [
		'classObject'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #transforming }
GtRBPullUpInstanceVariableRefactoring >> prepareForExecution [
	class := self classObjectFor: classObject.
	super prepareForExecution
]

{ #category : #initialization }
GtRBPullUpInstanceVariableRefactoring >> variable: aVarName class: aClassName [
	classObject := aClassName.
	variableName := aVarName
]
