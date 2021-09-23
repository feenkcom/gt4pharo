Class {
	#name : 'GtVariableRefactoringController',
	#superclass : 'GtPharoSourceCoderRefactoringController',
	#instVars : [
		'variableNode'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : 'executing' }
GtVariableRefactoringController >> safelyExecute [
	self preventSave.

	sourceCoderViewModel selectNone.

	self
		addRefactoringChangesPreview: self refactoring
		at: variableNode stopPosition
		whenComplete: [
			self removeRefactoringAttribute.
			self allowSave ]
]

{ #category : 'accessing' }
GtVariableRefactoringController >> variableName [
	^ self variableNode variableName
]

{ #category : 'accessing' }
GtVariableRefactoringController >> variableNode [

	^ variableNode
]

{ #category : 'accessing' }
GtVariableRefactoringController >> variableNode: anObject [

	variableNode := anObject
]
