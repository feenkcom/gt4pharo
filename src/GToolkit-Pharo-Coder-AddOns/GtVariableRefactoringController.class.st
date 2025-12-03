Class {
	#name : #GtVariableRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'variableNode'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtVariableRefactoringController >> previewPosition [
	^ variableNode stopPosition
]

{ #category : #executing }
GtVariableRefactoringController >> safelyExecute [
	self preventSave.
	sourceCoderViewModel selectNone.
	self addRefactoringPreview
]

{ #category : #accessing }
GtVariableRefactoringController >> variableName [
	^ self variableNode variableName
]

{ #category : #accessing }
GtVariableRefactoringController >> variableNode [

	^ variableNode
]

{ #category : #accessing }
GtVariableRefactoringController >> variableNode: anObject [

	variableNode := anObject
]
