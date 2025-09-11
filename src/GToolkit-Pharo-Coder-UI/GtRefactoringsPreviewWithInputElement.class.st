Class {
	#name : #GtRefactoringsPreviewWithInputElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'inputElement'
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

	self addAptitude: (BrLayoutResizerAptitude new hInherit: inputElement).
	self hExact: 350.
	self vFitContentLimited
]

{ #category : #initialization }
GtRefactoringsPreviewWithInputElement >> initializeInputElement [
	inputElement := GtRefactoringsInputElement new 
		margin: (BlInsets all: 5)
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewWithInputElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement
]

{ #category : #'private - updating' }
GtRefactoringsPreviewWithInputElement >> updateElement [
	self updateInputElement.
	self updatePreviewElement.
]

{ #category : #'private - updating' }
GtRefactoringsPreviewWithInputElement >> updateInputElement [
	inputElement refactoringsViewModel: self refactoringsViewModel
]

{ #category : #'private - updating' }
GtRefactoringsPreviewWithInputElement >> updatePreviewElement [
	| aPreviewPane refactoringButton |
	self removeChildren.
	refactoringButton := GtRefactoringsWithInputPreviewElement new.
	refactoringButton cancelBlock: [  ].
	refactoringButton editorElement: inputElement removeFromParent.
	inputElement
		when: GtRefactoringsPreviewRefactoringsWish
		do: [ :event | 
			event consumed: true.
			refactoringButton refactorings: event refactoringsBlock ].
	refactoringButton
		when: GtRefactoringsAboutToApplyEvent
		do: [ :event | self refactoringsViewModel beforeApplyBlock value ].
	aPreviewPane := refactoringButton
			buildPreviewForButton: (self refactoringsViewModel anchorElement ifNil: [ self ]).

	aPreviewPane
		when: GtRefactoringsAboutToApplyEvent
		do: [ :anEvent | inputElement disableEditing ].

	self refactoringsViewModel
		menuModelDo: [ :aMenuModel | 
			self
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						withPostEndPinBlock: [ :aContext | 
							aContext menuElement
								when: GtRefactoringsAppliedEvent
									do: [ :anEvent | 
										| aMenuElement |
										aMenuElement := anEvent currentTarget.
										BlTaskAction
											enqueueElement: aMenuElement
											action: [ inputElement enableEditing.
												aMenuElement removeFromParent ] ];
								when: GtRefactoringsFailedEvent
									do: [ :anEvent | 
										| aMenuElement |
										aMenuElement := anEvent currentTarget.
										BlTaskAction
											enqueueElement: aMenuElement
											action: [ inputElement enableEditing ] ].
							BlTaskAction
								enqueueElement: inputElement
								action: [ inputElement requestFocus ] ];
						withResizers;
						withAllPinActions;
						menuModel: aMenuModel) ].

	self addChild: aPreviewPane
]
