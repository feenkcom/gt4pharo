Class {
	#name : #GtRefactoringsPreviewWithInputElement,
	#superclass : #GtRefactoringsBasicElement,
	#traits : 'TGtRefactoringsPopoverElement',
	#classTraits : 'TGtRefactoringsPopoverElement classTrait',
	#instVars : [
		'inputElement',
		'previewElement',
		'toolbarElement',
		'messagesElement',
		'titleElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #'focus requesting' }
GtRefactoringsPreviewWithInputElement >> focusTarget [
	^ inputElement focusTarget
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initialize [
	super initialize.
	self background: self theme default contentBackground.

	self initializeTitleElement.
	self initializeInputElement.
	self initializePreviewElement.
	self initializeMessagesElement.
	self initializeToolbarElement.

	previewElement
		constraintsDo: [ :c | 
			c minHeight: GtRefactoringsConstants collapsedPreviewHeight.
			c
				margin: (BlInsets
						top: GtRefactoringsConstants spaceBetweenComposedElements
						bottom: GtRefactoringsConstants spaceBetweenComposedElements) ].

	self addChild: titleElement as: #refactoringTitle.
	self addChild: inputElement as: #refactoringInput.
	self addChild: previewElement as: #refactoringPreviewContainer.
	self addChild: messagesElement as: #refactoringMessages.
	self addChild: toolbarElement as: #refactoringToolbar.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: titleElement;
				hExactToMatchParent: titleElement;
				hFitContentToFitContent: titleElement;
				hFitContentLimitedToFitContentLimited: titleElement;
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

	self beContextMenuElement
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
GtRefactoringsPreviewWithInputElement >> initializeTitleElement [
	titleElement := GtRefactoringsTitleElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initializeToolbarElement [
	toolbarElement := GtRefactoringsToolbarElement new
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewWithInputElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	titleElement refactoringsViewModel: self refactoringsViewModel.
	inputElement refactoringsViewModel: self refactoringsViewModel.
	previewElement refactoringsViewModel: self refactoringsViewModel.
	messagesElement refactoringsViewModel: self refactoringsViewModel.
	toolbarElement refactoringsViewModel: self refactoringsViewModel.
]
