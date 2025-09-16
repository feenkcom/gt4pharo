Class {
	#name : #GtRefactoringsJustPreviewElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'refactoringsElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'private - updating' }
GtRefactoringsJustPreviewElement >> computeExecutedRefactorings [
	<return: #GtExecutedRefactorings>
	^ self refactoringsViewModel computeRefactoringsFrom: self
]

{ #category : #initialization }
GtRefactoringsJustPreviewElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsJustPreviewElement >> initialize [
	super initialize.

	self initializeRefactoringsElement.

	self addChild: refactoringsElement as: #preview.

	self addAptitude: (BrLayoutResizerAptitude new inherit: refactoringsElement).

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsJustPreviewElement >> initializeRefactoringsElement [
	refactoringsElement := GtRefactoringsElement new
			fitContentLimited;
			padding: (BlInsets all: 0);
			changesElementDo: [ :anElement | anElement padding: (BlInsets all: 0) ];
			visibility: BlVisibility gone;
			withAsyncFutureDo: [ :anElementFuture | 
				anElementFuture
					whenPending: [ :anElement | self onFuturePending ];
					whenError: [ :anElement :anError | self onFutureError: anError ];
					whenSuccess: [ :anElement :anExecutedRefactorings | self onFutureSuccess: anExecutedRefactorings ] ]
]

{ #category : #'private - event handling' }
GtRefactoringsJustPreviewElement >> onApplyChangesRequest: anExecutedRefactorings [
	| aViewModel aTopElement aPromise |
	aViewModel := self refactoringsViewModel.
	aViewModel executedRefactorings == anExecutedRefactorings ifFalse: [ ^ self ].

	aTopElement := self topMostParent.

	(aViewModel aboutToApplyRefactorings: anExecutedRefactorings)
		ifFalse: [ ^ self ].

	aPromise := (refactoringsElement
			applyRefactoringWithProgress: [ :aFraction | 
				aViewModel 
					notifyRefactorings: anExecutedRefactorings 
					applyingProgress: aFraction ])
			then: [ :ignore | 
				anExecutedRefactorings beApplied.
				aViewModel appliedRefactorings: anExecutedRefactorings ]
			otherwise: [ :anError | 
				| anErrorCopy |
				anErrorCopy := GtSystemUtility freeze: anError.
				anExecutedRefactorings beFailed: anErrorCopy.
				aViewModel failedRefactorings: anExecutedRefactorings exception: anErrorCopy ].

	anExecutedRefactorings beRunning: aPromise.
	aTopElement enqueueTask: (BlPromiseTask new promise: aPromise)
]

{ #category : #'private - event handling' }
GtRefactoringsJustPreviewElement >> onFutureError: anError [
	| aCopyError |
	self hasRefactoringsViewModel ifFalse: [ ^ self ].

	aCopyError := GtSystemUtility freeze: anError.
	self refactoringsViewModel notifyComputingRefactoringsFailed: aCopyError
]

{ #category : #'private - event handling' }
GtRefactoringsJustPreviewElement >> onFuturePending [
]

{ #category : #'private - event handling' }
GtRefactoringsJustPreviewElement >> onFutureSuccess: anExecutedRefactorings [
	self refactoringsViewModel executedRefactorings == anExecutedRefactorings
		ifFalse: [ ^ self ].

	self updateDisplayedRefactorings
]

{ #category : #'private - event handling' }
GtRefactoringsJustPreviewElement >> onGtRefactoringsViewModelApplyChangesRequested: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self onApplyChangesRequest: anAnnouncement executedRefactorings  ]
]

{ #category : #'private - event handling' }
GtRefactoringsJustPreviewElement >> onGtRefactoringsViewModelExecutedRefactoringsChanged: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self updateElement ]
]

{ #category : #'private - event handling' }
GtRefactoringsJustPreviewElement >> onGtRefactoringsViewModelExecutedRefactoringsComputationFailed: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction 
		enqueueElement: self 
		action: [ self updateDisplayedRefactorings ]
]

{ #category : #'private - event handling' }
GtRefactoringsJustPreviewElement >> onGtRefactoringsViewModelExecutedRefactoringsComputed: anAnnouncement [
	anAnnouncement source == self ifTrue: [ ^ self ].
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction 
		enqueueElement: self 
		action: [ self updateDisplayedRefactorings ]
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsJustPreviewElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsJustPreviewElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.

	self refactoringsViewModel weak
		when: GtRefactoringsViewModelExecutedRefactoringsChanged
			send: #onGtRefactoringsViewModelExecutedRefactoringsChanged:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsComputed
			send: #onGtRefactoringsViewModelExecutedRefactoringsComputed:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsComputationFailed
			send: #onGtRefactoringsViewModelExecutedRefactoringsComputationFailed:
			to: self;
		when: GtRefactoringsViewModelApplyChangesRequested
			send: #onGtRefactoringsViewModelApplyChangesRequested:
			to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsJustPreviewElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.

	self refactoringsViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtRefactoringsJustPreviewElement >> updateAsDisplayedProgress [
	refactoringsElement visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsJustPreviewElement >> updateAsHiddenRefactorings [
	refactoringsElement visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtRefactoringsJustPreviewElement >> updateComputedRefactorings [
	self refactoringsViewModel
		ifComputedRefactorings: [ :anExecutedRefactorings | ^ self ]
		ifNotComputed: [  ]
		ifInProgress: [ ^ self ]
		ifFailed: [  ].

	refactoringsElement asyncFuture future: [ self computeExecutedRefactorings ]
]

{ #category : #'private - updating' }
GtRefactoringsJustPreviewElement >> updateDisplayedRefactorings [
	self refactoringsViewModel
		ifComputedRefactorings: [ :anExecutedRefactorings | 
			anExecutedRefactorings
				refactoringsDo: [ :aCollection | 
					self updateAsDisplayedProgress.
					refactoringsElement refactorings: aCollection.
					self refactoringsViewModel previewedRefactorings: anExecutedRefactorings ]
				changesDo: [ :aChanges | 
					self updateAsDisplayedProgress.
					refactoringsElement changes: aChanges.
					self refactoringsViewModel previewedRefactorings: anExecutedRefactorings ]
				emptyDo: [ self updateAsHiddenRefactorings ]
				errorMessagesDo: [ self updateAsHiddenRefactorings ] ]
		ifNotComputed: [ self updateAsHiddenRefactorings ]
		ifInProgress: [ self updateAsHiddenRefactorings ]
		ifFailed: [ :anException | self updateAsHiddenRefactorings ]
]

{ #category : #'private - updating' }
GtRefactoringsJustPreviewElement >> updateElement [
	self updateComputedRefactorings.
	self updateDisplayedRefactorings.
]
