Class {
	#name : #GtPharoRenameSelectorRefactoringStencil,
	#superclass : #BlStencil,
	#instVars : [
		'selectorModel',
		'sourceCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'api - instantiation' }
GtPharoRenameSelectorRefactoringStencil >> create [
	
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringStencil >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringStencil >> selectorModel: anObject [
	selectorModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringStencil >> sourceCoderViewModel [
	^ sourceCoderViewModel
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringStencil >> sourceCoderViewModel: anObject [
	sourceCoderViewModel := anObject
]
