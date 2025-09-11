Class {
	#name : #GtRefactoringsPreviewWithInputNewElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'inputElement',
		'previewElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsPreviewWithInputNewElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputNewElement >> initialize [
	super initialize.
	self background: self theme default contentBackground.

	self initializeInputElement.
	self initializePreviewElement.

	self addChild: inputElement as: #input.
	self addChild: previewElement as: #previewContainer.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: inputElement;
				hExactToMatchParent: inputElement;
				hFitContentToFitContent: inputElement;
				hFitContentLimitedToFitContentLimited: inputElement;
				inherit: previewElement).

	self hExact: 350.
	self vFitContentLimited
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputNewElement >> initializeInputElement [
	inputElement := GtRefactoringsInputElement new 
		margin: (BlInsets all: 5)
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputNewElement >> initializePreviewElement [
	previewElement := GtRefactoringsJustPreviewElement new
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewWithInputNewElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	inputElement refactoringsViewModel: self refactoringsViewModel.
	previewElement refactoringsViewModel: self refactoringsViewModel
]
