Class {
	#name : #GtRefactoringsToolbarElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'applyButton',
		'progressElement',
		'exceptionElement',
		'finishedElement',
		'containerElement'
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
	self initializeContainer.

	containerElement addChild: applyButton as: GtRefactoringsPreviewAcceptId.
	containerElement addChild: progressElement as: #progress.
	containerElement addChild: exceptionElement as: #exception.
	containerElement addChild: finishedElement as: #finished.

	self addChild: containerElement as: #container.

	exceptionElement
		addAptitude: (BrLayoutResizerAptitude new inherit: [ exceptionElement children ]).

	containerElement
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: progressElement;
				hExactToMatchParent: progressElement;
				hFitContent: progressElement toExact: 100;
				hFitContentLimited: progressElement toExact: 100;
				hMatchParentToMatchParent: exceptionElement;
				hExactToMatchParent: exceptionElement;
				hFitContentToFitContent: exceptionElement;
				hFitContentLimitedToFitContentLimited: exceptionElement).

	self addAptitude: (BrLayoutResizerAptitude new 
				inherit: containerElement).

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
GtRefactoringsToolbarElement >> initializeContainer [
	containerElement := BrHorizontalPane new
			hFitContentLimited;
			vFitContent
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
				c linear horizontal alignLeft.
				c linear vertical alignCenter.
				c horizontal matchParent.
				c vertical exact: 5 ]
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
GtRefactoringsToolbarElement >> updateAsHiddenContainer [
	containerElement visibility: BlVisibility gone
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
GtRefactoringsToolbarElement >> updateAsVisibleContainer [
	containerElement visibility: BlVisibility visible
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
