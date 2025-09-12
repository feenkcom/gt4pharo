Class {
	#name : #GtRefactoringsToolbarElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'applyButton',
		'progressElement',
		'exceptionElement',
		'finishedElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsToolbarElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #initialization }
GtRefactoringsToolbarElement >> initialize [
	super initialize.

	self initializeApplyButton.
	self initializeProgressElement.
	self initializeExceptionElement.
	self initializeFinishedElement.

	self addChild: applyButton as: GtRefactoringsPreviewAcceptId.
	self addChild: progressElement as: #progress.
	self addChild: exceptionElement as: #exception.
	self addChild: finishedElement as: #finished.

	exceptionElement
		addAptitude: (BrLayoutResizerAptitude new inherit: [ exceptionElement children ]).

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: progressElement;
				hExactToMatchParent: progressElement;
				hFitContent: progressElement toExact: 100;
				hFitContentLimited: progressElement toExact: 100;
				hMatchParentToMatchParent: exceptionElement;
				hExactToMatchParent: exceptionElement;
				hFitContentToFitContent: exceptionElement;
				hFitContentLimitedToFitContentLimited: exceptionElement).

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsToolbarElement >> initializeApplyButton [
	applyButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude new;
			icon: BrGlamorousVectorIcons accept;
			margin: (BlInsets right: 5);
			beSmallSize;
			beFocusable;
			label: 'Save';
			action: [ self onApplyButtonClick ];
			disable;
			yourself
]

{ #category : #initialization }
GtRefactoringsToolbarElement >> initializeExceptionElement [
	exceptionElement := BrFrame new
			visibility: BlVisibility gone;
			hFitContentLimited;
			vFitContent
]

{ #category : #initialization }
GtRefactoringsToolbarElement >> initializeFinishedElement [
	finishedElement := BrLabel new
			visibility: BlVisibility gone;
			fitContent;
			beSmallSize;
			aptitude: BrGlamorousLabelAptitude;
			text: 'Changes applied'
]

{ #category : #initialization }
GtRefactoringsToolbarElement >> initializeProgressElement [
	progressElement := BrProgress new
			visibility: BlVisibility gone;
			aptitude: BrGlamorousProgressBarAptitude;
			fraction: 0;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ]
]

{ #category : #'private - event handling' }
GtRefactoringsToolbarElement >> onApplyButtonClick [
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	
	self refactoringsViewModel notifyApplyChangesRequested
]

{ #category : #'private - event handling' }
GtRefactoringsToolbarElement >> onGtRefactoringsViewModelExecutedRefactoringsChanged: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self updateElement ]
]

{ #category : #'private - event handling' }
GtRefactoringsToolbarElement >> onGtRefactoringsViewModelExecutedRefactoringsProgressChanged: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].
	anAnnouncement executedRefactorings
		== self refactoringsViewModel executedRefactorings ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateElement ]
]

{ #category : #'private - event handling' }
GtRefactoringsToolbarElement >> onGtRefactoringsViewModelExecutedRefactoringsStateAnnouncement: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self updateElement ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsToolbarElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement.
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsToolbarElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.

	self refactoringsViewModel weak
		when: GtRefactoringsViewModelExecutedRefactoringsChanged
			send: #onGtRefactoringsViewModelExecutedRefactoringsChanged:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement
			send: #onGtRefactoringsViewModelExecutedRefactoringsStateAnnouncement:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsProgressChanged
			send: #onGtRefactoringsViewModelExecutedRefactoringsProgressChanged:
			to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsToolbarElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.

	self refactoringsViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsDisabledApplyButton [
	applyButton disable
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsDisplayedFinishedLabel [
	finishedElement visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsDisplayedProgress [
	progressElement visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsEnabledApplyButton [
	applyButton enable
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsHiddenException [
	exceptionElement visibility: BlVisibility gone.
	exceptionElement removeChildren.
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsHiddenFinishedLabel [
	finishedElement visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsHiddenProgress [
	progressElement visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateElement [
	GtExecutedRefactoringsToolbarElementUpdater new
		forRefactoringsElement: self;
		update
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateProgressFraction: aFraction [
	progressElement fraction: aFraction
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateWithException: anException [
	exceptionElement visibility: BlVisibility visible.
	exceptionElement removeChildren.
	exceptionElement addChild: (anException asDebuggableElement)
]
