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
		'inputLabel',
		'refactoringTitle',
		'targetName'
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

	refactoringTitle := nil.
	targetName := nil.
	isEditorFocused := false.
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

{ #category : #accessing }
GtRefactoringsViewModel >> refactoringTitle [
	<return: #String or: nil>
	^ refactoringTitle
]

{ #category : #accessing }
GtRefactoringsViewModel >> refactoringTitle: aString [
	"Set the refactoring title, e.g., Convert to sibling"

	refactoringTitle := aString
]

{ #category : #accessing }
GtRefactoringsViewModel >> refactoringTitleDo: aBlock [
	refactoringTitle ifNotNil: aBlock
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetName [
	<return: #String or: nil>
	^ targetName
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetName: aString [
	"Set the refactoring target name, e.g., class name"

	targetName := aString
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetNameDo: aBlock [
	targetName ifNotNil: aBlock
]
