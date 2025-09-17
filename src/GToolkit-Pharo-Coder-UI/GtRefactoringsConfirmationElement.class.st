Class {
	#name : #GtRefactoringsConfirmationElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'confirmationLabelElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsConfirmationElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsConfirmationElement >> initialize [
	super initialize.

	self initializeConfirmationLabelElement.

	self addChild: confirmationLabelElement as: #refactoringConfirmationLabel.

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsConfirmationElement >> initializeConfirmationLabelElement [
	confirmationLabelElement := BrLabel new
			fitContent;
			aptitude: BrGlamorousLabelAptitude new;
			text: 'Confirmation'
]

{ #category : #'private - event handling' }
GtRefactoringsConfirmationElement >> onGtRefactoringsViewModelSubmitExecutedRefactoringsRequested: anAnnouncement [
	self refactoringsViewModel == anAnnouncement refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self previewRefactoring ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsConfirmationElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement
]

{ #category : #'private - event handling' }
GtRefactoringsConfirmationElement >> previewRefactoring [
	self refactoringsViewModel confirmRefactorings
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsConfirmationElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.

	self refactoringsViewModel weak
		when: GtRefactoringsViewModelSubmitExecutedRefactoringsRequested
		send: #onGtRefactoringsViewModelSubmitExecutedRefactoringsRequested:
		to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsConfirmationElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.

	self refactoringsViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtRefactoringsConfirmationElement >> updateElement [
	confirmationLabelElement text: self refactoringsViewModel confirmationLabel
]
