Class {
	#name : #GtMethodRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'methodNode'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtMethodRefactoringController >> methodClass [
	^ sourceCoderViewModel behavior
]

{ #category : #accessing }
GtMethodRefactoringController >> methodNode [
	^ methodNode
]

{ #category : #accessing }
GtMethodRefactoringController >> methodNode: aGtPharoMethodNode [
	methodNode := aGtPharoMethodNode
]

{ #category : #accessing }
GtMethodRefactoringController >> methodSelector [
	^ sourceCoderViewModel selector
]

{ #category : #executing }
GtMethodRefactoringController >> previewPosition [
	^ methodNode pattern stopPosition
]

{ #category : #executing }
GtMethodRefactoringController >> safelyExecute [
	self preventSave.
	sourceCoderViewModel selectNone.
	self addRefactoringPreview
]
