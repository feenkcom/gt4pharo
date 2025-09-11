Class {
	#name : #GtRefactoringsPreviewOldElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'refactoringsElement',
		'toolbarElement',
		'acceptButton',
		'messagesElement',
		'scalablePreviewElement',
		'scrollablePreviewElement',
		'running',
		'progressElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'private - updating' }
GtRefactoringsPreviewOldElement >> buildRefactoringsPreview [
]

{ #category : #'private - updating' }
GtRefactoringsPreviewOldElement >> computeExecutedRefactorings [
	| aRefactorings refactoringsOrChanges |
	aRefactorings := self refactoringsViewModel executedRefactorings.
	refactoringsOrChanges := aRefactorings executedRefactorings.
	^ aRefactorings
]

{ #category : #initialization }
GtRefactoringsPreviewOldElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsPreviewOldElement >> initialize [
	super initialize.

	running := false.

	self initializeRefactoringsElement.
	self initializeMessagesElement.
	self initializeToolbarElement.
	self initializeAcceptButton.
	self initializeProgressElement.

	scalablePreviewElement := refactoringsElement asScalableElement
			width: self previewWidth;
			fitWidth;
			constraintsDo: [ :c | c vertical fitContentLimited ].
	scrollablePreviewElement := scalablePreviewElement asScrollableElement
			constraintsDo: [ :c | c vertical fitContentLimited ].

	toolbarElement addChild: acceptButton.
	toolbarElement addChild: progressElement as: #progress.

	self addChild: scrollablePreviewElement as: #preview.
	self addChild: messagesElement as: #errors.
	self addChild: toolbarElement as: #toolbar.


	toolbarElement
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: progressElement;
				hExactToMatchParent: progressElement;
				hFitContent: progressElement toExact: 100;
				hFitContentLimited: progressElement toExact: 100).
	self
		addAptitude: (BrLayoutResizerAptitude new
				inherit: scrollablePreviewElement;
				hInherit: messagesElement;
				hInherit: toolbarElement).

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsPreviewOldElement >> initializeAcceptButton [
	acceptButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude new;
			id: GtRefactoringsPreviewAcceptId;
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			beFocusable;
			label: 'Save';
			action: [ self onAcceptButtonClick ];
			disable;
			yourself
]

{ #category : #initialization }
GtRefactoringsPreviewOldElement >> initializeMessagesElement [
	messagesElement := BrVerticalPane new
			fitContentLimited;
			visibility: BlVisibility gone;
			background: BrGlamorousColors errorBackgroundColor
]

{ #category : #initialization }
GtRefactoringsPreviewOldElement >> initializeProgressElement [
	progressElement := BrProgress new
			visibility: BlVisibility gone;
			aptitude: BrGlamorousProgressBarAptitude;
			fraction: 0;
			margin: (BlInsets
					top: 5
					left: 10
					bottom: 15
					right: 10);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ]
]

{ #category : #initialization }
GtRefactoringsPreviewOldElement >> initializeRefactoringsElement [
	refactoringsElement := GtRefactoringsElement new
			fitContentLimited;
			withAsyncFutureDo: [ :anElementFuture | 
				anElementFuture
					whenPending: [ :anElement | self onFuturePending ];
					whenError: [ :anElement :anError | self onFutureError: anError ];
					whenSuccess: [ :anElement :anExecutedRefactorings | self onFutureSuccess: anExecutedRefactorings ] ]
]

{ #category : #initialization }
GtRefactoringsPreviewOldElement >> initializeToolbarElement [
	toolbarElement := BrHorizontalPane new fitContentLimited
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onAcceptButtonClick [
	| executedRefactorings promise topElement |
	running ifTrue: [ ^ self ].

	executedRefactorings := self refactoringsViewModel executedRefactorings.
	running := true.
	acceptButton disable.

	refactoringsElement changesSize > 1
		ifTrue: [ progressElement visibility: BlVisibility visible.
			progressElement fraction: 0 ].

	topElement := self topMostParent.

	(self refactoringsViewModel aboutToApplyRefactorings: executedRefactorings)
		ifFalse: [ acceptButton enable.
			^ self ].

	self
		fireEvent: (GtRefactoringsAboutToApplyEvent new refactorings: executedRefactorings).

	promise := (refactoringsElement
			applyRefactoringWithProgress: [ :fraction | 
				BlTaskAction
					enqueueElement: progressElement
					action: [ progressElement fraction: fraction ] ])
			then: [ :ignore | 
				GtJustContextStackSignal emit.
				running := false.
				executedRefactorings beApplied.
				self refactoringsViewModel appliedRefactorings: executedRefactorings ]
			otherwise: [ :anError | 
				| anErrorCopy |
				running := false.
				anErrorCopy := GtSystemUtility freeze: anError.
				executedRefactorings beFailed: anErrorCopy.
				self refactoringsViewModel
					failedRefactorings: executedRefactorings
					exception: anErrorCopy ].

	executedRefactorings beRunning: promise.
	topElement enqueueTask: (BlPromiseTask new promise: promise)
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onFutureError: anError [ 
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onFuturePending [
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onFutureSuccess: anExecutedRefactorings [
	anExecutedRefactorings errorMessages
		ifEmpty: [ self onFutureSuccessWithoutErrorMessages: anExecutedRefactorings ]
		ifNotEmpty: [ self onFutureSuccessWithErrorMessages: anExecutedRefactorings ]
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onFutureSuccessWithErrorMessages: anExecutedRefactorings [
	| anAnchorElement |
	scrollablePreviewElement visibility: BlVisibility gone.
	toolbarElement visibility: BlVisibility gone.
	messagesElement removeChildren.
	messagesElement background: BrGlamorousColors errorBackgroundColor.
	messagesElement visibility: BlVisibility visible.
	
	anAnchorElement := self refactoringsViewModel anchorElement ifNil: [ self ].

	anExecutedRefactorings errorMessages
		do: [ :eachMessage | 
			| anElement |
			anElement := eachMessage cull: anAnchorElement.
			anElement padding: (BlInsets all: 5).
			messagesElement addChild: anElement ]
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onFutureSuccessWithoutErrorMessages: anExecutedRefactorings [
	| anAnchorElement |
	messagesElement visibility: BlVisibility gone.
	scrollablePreviewElement visibility: BlVisibility visible.
	toolbarElement visibility: BlVisibility visible.
	acceptButton enable; requestFocus.
	messagesElement removeChildren.

	anExecutedRefactorings
		refactoringsDo: [ :aCollection | refactoringsElement refactorings: aCollection ]
		changesDo: [ :aChanges | refactoringsElement changes: aChanges ]
		emptyDo: [  ].

	anExecutedRefactorings notificationMessages ifEmpty: [ ^ self ].

	anAnchorElement := self refactoringsViewModel anchorElement ifNil: [ self ].
	messagesElement background: BlBackground transparent.
	messagesElement visibility: BlVisibility visible.
	anExecutedRefactorings notificationMessages
		do: [ :eachMessage | 
			| anElement |
			anElement := eachMessage cull: anAnchorElement.
			anElement
				padding: (BlInsets
						top: 10
						left: 10
						bottom: 0
						right: 10).
			messagesElement addChild: anElement ]
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onGtRefactoringsViewModelExecutedRefactoringsApplied: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self updateOnExecutedRefactoringsApplied: anAnnouncement executedRefactorings ]
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onGtRefactoringsViewModelExecutedRefactoringsChanged: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self updateElement ]
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> onGtRefactoringsViewModelExecutedRefactoringsFailed: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self updateOnExecutedRefactoringsFailed: anAnnouncement executedRefactorings ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewOldElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement
]

{ #category : #initialization }
GtRefactoringsPreviewOldElement >> previewWidth [
	^ self isAttachedToSceneGraph
		ifTrue: [ (self topMostParent extent / 2.0) x ]
		ifFalse: [ 500 ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewOldElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.

	self refactoringsViewModel weak
		when: GtRefactoringsViewModelExecutedRefactoringsChanged
			send: #onGtRefactoringsViewModelExecutedRefactoringsChanged:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsApplied
			send: #onGtRefactoringsViewModelExecutedRefactoringsApplied:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsFailed
			send: #onGtRefactoringsViewModelExecutedRefactoringsFailed:
			to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsPreviewOldElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.

	self refactoringsViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtRefactoringsPreviewOldElement >> updateElement [
	refactoringsElement asyncFuture future: [ self computeExecutedRefactorings ]
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> updateOnExecutedRefactoringsApplied: anExecutedRefactorings [
	GtJustContextStackSignal emit.
	self refactoringsViewModel executedRefactorings == anExecutedRefactorings
		ifFalse: [ ^ self ].

	progressElement fraction: 0.
	progressElement visibility: BlVisibility gone.

	toolbarElement visibility: BlVisibility gone.
	acceptButton enable.

	messagesElement
		removeChildren;
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Refactorings applied');
		background: BlBackground transparent;
		visibility: BlVisibility visible.

	self fireEvent: BrDropdownHideWish new
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewOldElement >> updateOnExecutedRefactoringsFailed: anExecutedRefactorings [
	self refactoringsViewModel executedRefactorings == anExecutedRefactorings
		ifFalse: [ ^ self ].

	anExecutedRefactorings
		ifFailedStateDo: [ :anException | 
			messagesElement
				removeChildren;
				addChild: anException asDebuggableElement fitContentLimited;
				visibility: BlVisibility visible;
				background: BrGlamorousColors errorBackgroundColor.

			progressElement fraction: 0.
			progressElement visibility: BlVisibility gone ]
]
