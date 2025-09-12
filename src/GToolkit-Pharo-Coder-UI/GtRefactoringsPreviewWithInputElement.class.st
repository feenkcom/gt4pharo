Class {
	#name : #GtRefactoringsPreviewWithInputElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'inputElement',
		'previewElement',
		'toolbarElement'
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
	self initializeToolbarElement.

	self addChild: inputElement as: #input.
	self addChild: previewElement as: #previewContainer.
	self addChild: toolbarElement as: #toolbar.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: inputElement;
				hExactToMatchParent: inputElement;
				hFitContentToFitContent: inputElement;
				hFitContentLimitedToFitContentLimited: inputElement;
				inherit: previewElement;
				hMatchParentToMatchParent: toolbarElement;
				hExactToMatchParent: toolbarElement;
				hFitContentToFitContent: toolbarElement;
				hFitContentLimitedToFitContentLimited: toolbarElement).

	self hExact: 350.
	self vFitContentLimited
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initializeInputElement [
	inputElement := GtRefactoringsInputElement new 
		margin: (BlInsets all: 5)
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
	toolbarElement refactoringsViewModel: self refactoringsViewModel.
]
