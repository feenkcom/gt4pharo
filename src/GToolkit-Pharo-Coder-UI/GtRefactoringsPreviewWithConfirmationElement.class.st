Class {
	#name : #GtRefactoringsPreviewWithConfirmationElement,
	#superclass : #GtRefactoringsBasicElement,
	#traits : 'TGtRefactoringsPopoverElement',
	#classTraits : 'TGtRefactoringsPopoverElement classTrait',
	#instVars : [
		'toolbarElement',
		'messagesElement',
		'previewElement',
		'titleElement',
		'confirmationElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsPreviewWithConfirmationElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #'focus requesting' }
GtRefactoringsPreviewWithConfirmationElement >> focusTarget [
	^ toolbarElement focusTarget
]

{ #category : #initialization }
GtRefactoringsPreviewWithConfirmationElement >> initialize [
	super initialize.
	self background: self theme default contentBackground.

	self initializeTitleElement.
	self initializeConfirmationElement.
	self initializePreviewElement.
	self initializeMessagesElement.
	self initializeToolbarElement.

	previewElement
		constraintsDo: [ :c | 
			c
				margin: (BlInsets
						top: GtRefactoringsConstants spaceBetweenComposedElements
						bottom: GtRefactoringsConstants spaceBetweenComposedElements).
			c minHeight: GtRefactoringsConstants collapsedPreviewHeight ].

	self addChild: titleElement as: #refactoringInput.
	self addChild: confirmationElement as: #refactoringConfirmation.
	self addChild: previewElement as: #refactoringPreviewContainer.
	self addChild: messagesElement as: #refactoringMessages.
	self addChild: toolbarElement as: #refactoringToolbar.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: titleElement;
				hExactToMatchParent: titleElement;
				hFitContentToFitContent: titleElement;
				hFitContentLimitedToFitContentLimited: titleElement;
				hMatchParentToMatchParent: confirmationElement;
				hExactToMatchParent: confirmationElement;
				hFitContentToFitContent: confirmationElement;
				hFitContentLimitedToFitContentLimited: confirmationElement;
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
GtRefactoringsPreviewWithConfirmationElement >> initializeConfirmationElement [
	confirmationElement := GtRefactoringsConfirmationElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithConfirmationElement >> initializeMessagesElement [
	messagesElement := GtRefactoringsMessagesElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithConfirmationElement >> initializePreviewElement [
	previewElement := GtRefactoringsJustPreviewElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithConfirmationElement >> initializeTitleElement [
	titleElement := GtRefactoringsTitleElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithConfirmationElement >> initializeToolbarElement [
	toolbarElement := GtRefactoringsToolbarElement new
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewWithConfirmationElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	titleElement refactoringsViewModel: self refactoringsViewModel.
	confirmationElement refactoringsViewModel: self refactoringsViewModel.
	previewElement refactoringsViewModel: self refactoringsViewModel.
	messagesElement refactoringsViewModel: self refactoringsViewModel.
	toolbarElement refactoringsViewModel: self refactoringsViewModel.
]
