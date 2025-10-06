Class {
	#name : #GtRefactoringsConfirmationElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'confirmationLabelElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
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
			text: 'Confirmation';
			withAsyncFutureDo: [ :anElementFuture | 
				anElementFuture
					executionConfiguration: GtRefactoringsConstants futureExecutionConfiguration;
					whenPending: [ :anElement | self onFuturePending ];
					whenError: [ :anElement :anError | self onFutureError: anError ];
					whenSuccess: [ :anElement :aResult | self onFutureSuccess: aResult ] ]
]

{ #category : #'private - event handling' }
GtRefactoringsConfirmationElement >> onFutureError: anError [
	| aCopyError |
	self hasRefactoringsViewModel ifFalse: [ ^ self ].

	aCopyError := GtSystemUtility freeze: anError.
	self refactoringsViewModel notifyComputingRefactoringsFailed: aCopyError
]

{ #category : #'private - event handling' }
GtRefactoringsConfirmationElement >> onFuturePending [
]

{ #category : #'private - event handling' }
GtRefactoringsConfirmationElement >> onFutureSuccess: aResult [
	
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
	confirmationLabelElement asyncFuture future: [ self refactoringsViewModel confirmRefactorings ] asAsyncFuture
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
