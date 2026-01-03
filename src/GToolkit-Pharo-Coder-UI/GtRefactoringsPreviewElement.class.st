Class {
	#name : #GtRefactoringsPreviewElement,
	#superclass : #GtRefactoringsBasicElement,
	#traits : 'TGtRefactoringsPopoverElement',
	#classTraits : 'TGtRefactoringsPopoverElement classTrait',
	#instVars : [
		'toolbarElement',
		'messagesElement',
		'previewElement',
		'titleElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Core'
}

{ #category : #'api - initialization' }
GtRefactoringsPreviewElement >> beContextMenuElement [
	"The element is part of a popover, e.g., context menu.
	Make the element defaults."
	
	self padding: (BlInsets all: GtRefactoringsConstants contextMenuPadding).
	self hExact: GtRefactoringsConstants contextMenuWidth.
	self vFitContentLimited
]

{ #category : #'api - initialization' }
GtRefactoringsPreviewElement >> bePinnable: anExplicitMenu [
	"The element is part of a popover, e.g., context menu.
	Make the element pinnable."

	self assert: self hasRefactoringsViewModel.

	self
		addAptitude: (BrGlamorousPopoverPinnableAptitude new
				withAllPinActions;
				withResizers;
				menuModel: anExplicitMenu;
				withPostEndPinBlock: [
					self requestFocus.
					self refactoringsViewModel weak
						when: GtRefactoringsViewModelExecutedRefactoringsApplied
						send: #onClosePinnedElement:
						to: self ])
]

{ #category : #initialization }
GtRefactoringsPreviewElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #'focus requesting' }
GtRefactoringsPreviewElement >> focusTarget [
	^ toolbarElement focusTarget
]

{ #category : #initialization }
GtRefactoringsPreviewElement >> initialize [
	super initialize.
	self background: self theme default contentBackground.

	self initializeTitleElement.
	self initializeMessagesElement.
	self initializePreviewElement.
	self initializeToolbarElement.

	previewElement
		constraintsDo: [ :c | 
			c
				margin: (BlInsets
						top: GtRefactoringsConstants spaceBetweenComposedElements
						bottom: GtRefactoringsConstants spaceBetweenComposedElements).
			c minHeight: GtRefactoringsConstants collapsedPreviewHeight ].

	self addChild: titleElement as: #refactoringInput.
	self addChild: messagesElement as: #refactoringMessages.
	self addChild: previewElement as: #refactoringPreviewContainer.
	self addChild: toolbarElement as: #refactoringToolbar.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: titleElement;
				hExactToMatchParent: titleElement;
				hFitContentToFitContent: titleElement;
				hFitContentLimitedToFitContentLimited: titleElement;
				common: previewElement;
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
GtRefactoringsPreviewElement >> initializeMessagesElement [
	messagesElement := GtRefactoringsMessagesElement new
]

{ #category : #initialization }
GtRefactoringsPreviewElement >> initializePreviewElement [
	previewElement := GtRefactoringsJustPreviewElement new
]

{ #category : #initialization }
GtRefactoringsPreviewElement >> initializeTitleElement [
	titleElement := GtRefactoringsTitleElement new
]

{ #category : #initialization }
GtRefactoringsPreviewElement >> initializeToolbarElement [
	toolbarElement := GtRefactoringsToolbarElement new
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewElement >> onClosePinnedElement: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self removeFromParent ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	titleElement refactoringsViewModel: self refactoringsViewModel.
	previewElement refactoringsViewModel: self refactoringsViewModel.
	messagesElement refactoringsViewModel: self refactoringsViewModel.
	toolbarElement refactoringsViewModel: self refactoringsViewModel.
]
