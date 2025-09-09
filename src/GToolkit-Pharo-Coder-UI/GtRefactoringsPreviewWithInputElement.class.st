Class {
	#name : #GtRefactoringsPreviewWithInputElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'inputElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
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
	| aPreviewPane |
	self removeChildren.
	aPreviewPane := GtRefactoringsWithInputPreviewElement
			elementForRefactoringInputElement: inputElement removeFromParent
			from: (self refactoringsViewModel anchorElement ifNil: [ self ])
			beforeApplyingDo: self refactoringsViewModel beforeApplyBlock.

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
