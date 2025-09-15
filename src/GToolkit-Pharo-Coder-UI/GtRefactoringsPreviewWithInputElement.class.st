Class {
	#name : #GtRefactoringsPreviewWithInputElement,
	#superclass : #GtRefactoringsBasicElement,
	#traits : 'TGtRefactoringsPinnableElement',
	#classTraits : 'TGtRefactoringsPinnableElement classTrait',
	#instVars : [
		'inputElement',
		'previewElement',
		'toolbarElement',
		'messagesElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initialize [
	super initialize.
	self background: self theme default contentBackground.

	self initializeInputElement.
	self initializePreviewElement.
	self initializeMessagesElement.
	self initializeToolbarElement.

	self addChild: inputElement as: #refactoringInput.
	self addChild: previewElement as: #refactoringPreviewContainer.
	self addChild: messagesElement as: #refactoringMessages.
	self addChild: toolbarElement as: #refactoringToolbar.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: inputElement;
				hExactToMatchParent: inputElement;
				hFitContentToFitContent: inputElement;
				hFitContentLimitedToFitContentLimited: inputElement;
				inherit: previewElement;
				hMatchParentToMatchParent: messagesElement;
				hExactToMatchParent: messagesElement;
				hFitContentToFitContent: messagesElement;
				hFitContentLimitedToFitContentLimited: messagesElement;
				hMatchParentToMatchParent: toolbarElement;
				hExactToMatchParent: toolbarElement;
				hFitContentToFitContent: toolbarElement;
				hFitContentLimitedToFitContentLimited: toolbarElement).

	self padding: (BlInsets all: 5).
	self hExact: 350.
	self vFitContentLimited
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initializeInputElement [
	inputElement := GtRefactoringsInputElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initializeMessagesElement [
	messagesElement := GtRefactoringsMessagesElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initializePreviewElement [
	previewElement := GtRefactoringsJustPreviewElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initializeToolbarElement [
	toolbarElement := GtRefactoringsToolbarElement new
			visibility: BlVisibility gone
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewWithInputElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	toolbarElement visibility: BlVisibility visible.
	inputElement refactoringsViewModel: self refactoringsViewModel.
	previewElement refactoringsViewModel: self refactoringsViewModel.
	messagesElement refactoringsViewModel: self refactoringsViewModel.
	toolbarElement refactoringsViewModel: self refactoringsViewModel.
]
