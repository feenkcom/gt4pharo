Class {
	#name : #GtRefactoringsMessagesElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'containerElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsMessagesElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsMessagesElement >> initialize [
	super initialize.
	self initializeContainerElement.

	self addChild: containerElement as: #refactoringMessagesContainer.

	containerElement
		margin: (BlInsets top: 5 bottom: 5);
		addAptitude: (BrLayoutResizerAptitude new inherit: [ containerElement children ]).

	self addAptitude: (BrLayoutResizerAptitude new hInherit: containerElement).

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsMessagesElement >> initializeContainerElement [
	containerElement := BrHorizontalPane new
			fitContentLimited;
			visibility: BlVisibility gone;
			alignTopLeft
]

{ #category : #'private - event handling' }
GtRefactoringsMessagesElement >> onGtRefactoringsViewModelExecutedRefactoringsChanged: anAnnouncement [
	self refactoringsViewModel == anAnnouncement refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateElement ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsMessagesElement >> onGtRefactoringsViewModelExecutedRefactoringsStateAnnouncement: anAnnouncement [
	self refactoringsViewModel == anAnnouncement refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateElement ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsMessagesElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsMessagesElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.

	self refactoringsViewModel weak
		when: GtRefactoringsViewModelExecutedRefactoringsChanged
			send: #onGtRefactoringsViewModelExecutedRefactoringsChanged:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement
			send: #onGtRefactoringsViewModelExecutedRefactoringsStateAnnouncement:
			to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsMessagesElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.

	self refactoringsViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtRefactoringsMessagesElement >> updateAsComputedRefactorings: aComputedRefactorings [
	aComputedRefactorings errorMessages ifNotEmpty: [ 
		^ self updateAsComputedRefactoringsWithErrorMessages: aComputedRefactorings ].
	aComputedRefactorings notificationMessages ifNotEmpty: [ 
		^ self updateAsComputedRefactoringsWithNotificationMessages: aComputedRefactorings ]
]

{ #category : #'private - updating' }
GtRefactoringsMessagesElement >> updateAsComputedRefactoringsWithErrorMessages: aComputedRefactorings [
	| anAnchorElement newChildren |
	anAnchorElement := self refactoringsViewModel anchorElement ifNil: [ self ].
	newChildren := aComputedRefactorings errorMessages
			collect: [ :eachBlock | eachBlock cull: anAnchorElement ].
	containerElement
		removeChildren;
		addChildren: newChildren;
		background: BrGlamorousColors errorBackgroundColor;
		visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsMessagesElement >> updateAsComputedRefactoringsWithNotificationMessages: aComputedRefactorings [
	| anAnchorElement newChildren |
	anAnchorElement := self refactoringsViewModel anchorElement ifNil: [ self ].
	newChildren := aComputedRefactorings notificationMessages
			collect: [ :eachBlock | eachBlock cull: anAnchorElement ].
	containerElement
		removeChildren;
		addChildren: newChildren;
		background: BrGlamorousColors failureBackgroundColor;
		visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsMessagesElement >> updateAsHiddenMessages [
	containerElement
		removeChildren;
		visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtRefactoringsMessagesElement >> updateElement [
	self refactoringsViewModel
		ifComputedRefactorings: [ :aComputedRefactorings | 
			self updateAsComputedRefactorings: aComputedRefactorings  ]
		ifNotComputed: [ self updateAsHiddenMessages ]
		ifInProgress: [ self updateAsHiddenMessages ]
		ifFailed: [ self updateAsHiddenMessages ]
]
