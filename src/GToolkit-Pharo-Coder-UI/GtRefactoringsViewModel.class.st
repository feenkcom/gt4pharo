Class {
	#name : #GtRefactoringsViewModel,
	#superclass : #Object,
	#instVars : [
		'isEditorFocused',
		'beforeApplyBlock',
		'initialText',
		'refactoringBlock',
		'inputFilter',
		'cancelBlock',
		'isPreviewButtonFocused',
		'inputLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsViewModel >> beforeApplyBlock [
	<return: #BlockClosure>
	^ beforeApplyBlock
]

{ #category : #accessing }
GtRefactoringsViewModel >> beforeApplyBlock: anObject [
	beforeApplyBlock := anObject
]

{ #category : #accessing }
GtRefactoringsViewModel >> cancelBlock [
	<return: #BlockClosure>
	^ cancelBlock
]

{ #category : #accessing }
GtRefactoringsViewModel >> cancelBlock: anObject [
	cancelBlock := anObject
]

{ #category : #accessing }
GtRefactoringsViewModel >> initialText [
	<return: #String or: #BlText>
	^ initialText
]

{ #category : #accessing }
GtRefactoringsViewModel >> initialText: anObject [
	initialText := anObject
]

{ #category : #initialization }
GtRefactoringsViewModel >> initialize [
	super initialize.

	isEditorFocused := true.
	isPreviewButtonFocused := false.
	beforeApplyBlock := [  ].
	cancelBlock := [ ].
	refactoringBlock := [ :anInput | nil ].
	inputLabel := 'Input:'.
	initialText := ''.
	inputFilter := BrTextEditorNoLineBreakInputFilter new
]

{ #category : #accessing }
GtRefactoringsViewModel >> inputFilter [
	<return: #BrTextEditorInputFilter>
	^ inputFilter
]

{ #category : #accessing }
GtRefactoringsViewModel >> inputFilter: anObject [
	inputFilter := anObject
]

{ #category : #accessing }
GtRefactoringsViewModel >> inputLabel [
	<return: #String>
	^ inputLabel
]

{ #category : #accessing }
GtRefactoringsViewModel >> inputLabel: anObject [
	inputLabel := anObject
]

{ #category : #accessing }
GtRefactoringsViewModel >> isEditorFocused [
	<return: #Boolean>
	^ isEditorFocused
]

{ #category : #accessing }
GtRefactoringsViewModel >> isEditorFocused: anObject [
	isEditorFocused := anObject
]

{ #category : #accessing }
GtRefactoringsViewModel >> isPreviewButtonFocused [
	<return: #Boolean>
	^ isPreviewButtonFocused
]

{ #category : #accessing }
GtRefactoringsViewModel >> isPreviewButtonFocused: anObject [
	isPreviewButtonFocused := anObject
]

{ #category : #accessing }
GtRefactoringsViewModel >> refactoringBlock [
	<return: #BlockClosure of: #RBRefactoring>
	^ refactoringBlock
]

{ #category : #accessing }
GtRefactoringsViewModel >> refactoringBlock: anObject [
	refactoringBlock := anObject
]
