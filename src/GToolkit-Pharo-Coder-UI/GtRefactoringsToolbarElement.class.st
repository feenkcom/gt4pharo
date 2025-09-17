Class {
	#name : #GtRefactoringsToolbarElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'applyButton',
		'progressElement',
		'exceptionElement',
		'finishedElement',
		'containerElement',
		'previewButtonElement'
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

	self initializePreviewButton.
	self initializeApplyButton.
	self initializeProgressElement.
	self initializeExceptionElement.
	self initializeFinishedElement.
	self initializeContainer.

	containerElement addChild: previewButtonElement as: #refactoringPreviewButton.
	containerElement addChild: applyButton as: GtRefactoringsPreviewAcceptId.
	containerElement addChild: exceptionElement as: #refactoringException.
	containerElement addChild: finishedElement as: #refactoringFinished.

	self addChild: containerElement as: #refactoringToolbarContainer.

	exceptionElement
		addAptitude: (BrLayoutResizerAptitude new inherit: [ exceptionElement children ]).

	containerElement
		margin: (BlInsets top: 5);
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
			visibility: BlVisibility gone;
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
GtRefactoringsToolbarElement >> initializePreviewButton [
	previewButtonElement := BrButton new
			fitContent;
			beFocusable;
			margin: (BlInsets right: 5);
			aptitude: BrGlamorousButtonWithIconAptitude new;
			id: GtRefactoringsPreviewAcceptId;
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			label: 'Preview changes';
			disable;
			action: [ self onPreviewButtonClick ]
]

{ #category : #initialization }
GtRefactoringsToolbarElement >> initializeProgressElement [
	progressElement := BrProgress new
			id: #refactoringProgress;
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

{ #category : #'private - event handling' }
GtRefactoringsToolbarElement >> onPreviewButtonClick [
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	
	self refactoringsViewModel notifySubmitExecutedRefactoringsRequested
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
GtRefactoringsToolbarElement >> updateAsDisabledPreviewButton [
	previewButtonElement disable
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsDisplayedFinishedLabel [
	finishedElement visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsDisplayedProgress [
	progressElement hasParent ifTrue: [ ^ self ].
	containerElement addChild: progressElement after: applyButton.
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsEnabledApplyButton [
	applyButton enable
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsEnabledPreviewButton [
	previewButtonElement enable
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsFocusedApplyButton [
	applyButton requestFocus
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsHiddenApplyButton [
	applyButton visibility: BlVisibility gone
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
GtRefactoringsToolbarElement >> updateAsHiddenPreviewButton [
	previewButtonElement visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsHiddenProgress [
	"The progress element is removed (instead of a visibility gone),
	because it has a repeated animation task that would continue running in a background."

	progressElement removeFromParent
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsVisibleApplyButton [
	applyButton visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsVisibleContainer [
	containerElement visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsVisiblePreviewButton [
	previewButtonElement visibility: BlVisibility visible
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
