Class {
	#name : #GtRefactoringsWithInputWidgetElement,
	#superclass : #GtRefactoringsBasicElement,
	#traits : 'TGtRefactoringsPopoverElement',
	#classTraits : 'TGtRefactoringsPopoverElement classTrait',
	#instVars : [
		'titleElement',
		'inputElement',
		'messagesElement',
		'previewElement',
		'toolbarElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Core'
}

{ #category : #initialization }
GtRefactoringsWithInputWidgetElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsWithInputWidgetElement >> initialize [
	super initialize.
	self background: self theme default contentBackground.

	self initializeTitleElement.
	self initializeInputElement.
	self initializeMessagesElement.
	self initializePreviewElement.
	self initializeToolbarElement.

	previewElement
		constraintsDo: [ :c | 
			c minHeight: GtRefactoringsConstants collapsedPreviewHeight.
			c
				margin: (BlInsets
						top: GtRefactoringsConstants spaceBetweenComposedElements
						bottom: GtRefactoringsConstants spaceBetweenComposedElements) ].

	inputElement addAptitude: (BrLayoutResizerAptitude new 
		inherit: [ inputElement children ]).

	self addChild: titleElement as: #refactoringTitle.
	self addChild: inputElement as: #refactoringInput.
	self addChild: messagesElement as: #refactoringMessages.
	self addChild: previewElement as: #refactoringPreviewContainer.
	self addChild: toolbarElement as: #refactoringToolbar.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hCommon: titleElement;
				hCommon: inputElement;
				common: previewElement;
				hCommon: messagesElement;
				hCommon: toolbarElement).

	self beContextMenuElement
]

{ #category : #initialization }
GtRefactoringsWithInputWidgetElement >> initializeInputElement [
	inputElement := BrFrame new fitContentLimited
]

{ #category : #initialization }
GtRefactoringsWithInputWidgetElement >> initializeMessagesElement [
	messagesElement := GtRefactoringsMessagesElement new
]

{ #category : #initialization }
GtRefactoringsWithInputWidgetElement >> initializePreviewElement [
	previewElement := GtRefactoringsJustPreviewElement new
]

{ #category : #initialization }
GtRefactoringsWithInputWidgetElement >> initializeTitleElement [
	titleElement := GtRefactoringsTitleElement new
]

{ #category : #initialization }
GtRefactoringsWithInputWidgetElement >> initializeToolbarElement [
	toolbarElement := GtRefactoringsToolbarElement new
]

{ #category : #'private - event handling' }
GtRefactoringsWithInputWidgetElement >> onGtRefactoringsViewModelInputElementChanged: anAnnouncement [
	anAnnouncement refactoringsViewModel = self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateElement ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsWithInputWidgetElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	titleElement refactoringsViewModel: self refactoringsViewModel.
	previewElement refactoringsViewModel: self refactoringsViewModel.
	messagesElement refactoringsViewModel: self refactoringsViewModel.
	toolbarElement refactoringsViewModel: self refactoringsViewModel.
	self updateElement
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsWithInputWidgetElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.
	self refactoringsViewModel weak
		when: GtRefactoringsViewModelInputElementChanged
		send: #onGtRefactoringsViewModelInputElementChanged:
		to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsWithInputWidgetElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.
	self refactoringsViewModel unsubscribe: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsWithInputWidgetElement >> updateElement [
	inputElement removeChildren.
	self refactoringsViewModel inputElement
		ifNotNil: [ :anElement | 
			inputElement addChild: anElement removeFromParent.
			inputElement requestStyle ]
]
