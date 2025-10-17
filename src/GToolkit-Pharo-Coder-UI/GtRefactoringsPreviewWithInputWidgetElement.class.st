Class {
	#name : #GtRefactoringsPreviewWithInputWidgetElement,
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
GtRefactoringsPreviewWithInputWidgetElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputWidgetElement >> initialize [
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
	self addChild: inputElement as: #refactoringInputWidgetContainer.
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
GtRefactoringsPreviewWithInputWidgetElement >> initializeInputElement [
	inputElement := BrFrame new
			fitContentLimited;
			when: GtRefactoringsViewModelWish
				do: [ :aWish | self onGtRefactoringsViewModelWish: aWish ]
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputWidgetElement >> initializeMessagesElement [
	messagesElement := GtRefactoringsMessagesElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputWidgetElement >> initializePreviewElement [
	previewElement := GtRefactoringsJustPreviewElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputWidgetElement >> initializeTitleElement [
	titleElement := GtRefactoringsTitleElement new
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputWidgetElement >> initializeToolbarElement [
	toolbarElement := GtRefactoringsToolbarElement new
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewWithInputWidgetElement >> onGtRefactoringsViewModelInputElementChanged: anAnnouncement [
	anAnnouncement refactoringsViewModel = self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateElement ]
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputWidgetElement >> onGtRefactoringsViewModelWish: aWish [
	aWish consumed: true.
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	aWish refactoringsViewModel: self refactoringsViewModel
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewWithInputWidgetElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	titleElement refactoringsViewModel: self refactoringsViewModel.
	previewElement refactoringsViewModel: self refactoringsViewModel.
	messagesElement refactoringsViewModel: self refactoringsViewModel.
	toolbarElement refactoringsViewModel: self refactoringsViewModel.
	self updateElement
]

{ #category : #'private - updating' }
GtRefactoringsPreviewWithInputWidgetElement >> removeExistingInputWidget [
	| removedChildren |
	removedChildren := inputElement children asArray.
	inputElement removeChildren.
	BrWidgetPermanentlyRemovedEvent notifyElements: removedChildren
]

{ #category : #'private - updating' }
GtRefactoringsPreviewWithInputWidgetElement >> replaceInputWidgetBy: anElement [
	(anElement hasParent and: [ anElement parent == inputElement ])
		ifTrue: [ ^ self ].
	self removeExistingInputWidget.
	inputElement addChild: anElement removeFromParent.
	inputElement requestStyle
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewWithInputWidgetElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.
	self refactoringsViewModel weak
		when: GtRefactoringsViewModelInputElementChanged
		send: #onGtRefactoringsViewModelInputElementChanged:
		to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewWithInputWidgetElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.
	self refactoringsViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtRefactoringsPreviewWithInputWidgetElement >> updateElement [
	self refactoringsViewModel inputElement
		ifNotNil: [ :anElement | 
			self replaceInputWidgetBy: anElement ]
		ifNil: [ 
			"Since there is no input element, 
			the refactoring is ready to compute."
			self removeExistingInputWidget.
			self refactoringsViewModel inputReady ]
]
