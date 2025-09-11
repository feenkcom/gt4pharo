Class {
	#name : #GtRefactoringsToolbarElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'applyButton',
		'progressElement'
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

	self addChild: applyButton as: GtRefactoringsPreviewAcceptId.
	self addChild: progressElement as: #progress.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: progressElement;
				hExactToMatchParent: progressElement;
				hFitContent: progressElement toExact: 100;
				hFitContentLimited: progressElement toExact: 100).

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsToolbarElement >> initializeApplyButton [
	applyButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude new;
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			beFocusable;
			label: 'Save';
			action: [ self onApplyButtonClick ];
			disable;
			yourself
]

{ #category : #initialization }
GtRefactoringsToolbarElement >> initializeProgressElement [
	progressElement := BrProgress new
			visibility: BlVisibility gone;
			aptitude: BrGlamorousProgressBarAptitude;
			fraction: 0;
			margin: (BlInsets left: 5);
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

	BlTaskAction
		enqueueElement: self
		action: [ self
				updateRefactorings: anAnnouncement executedRefactorings
				progressFraction: anAnnouncement fraction ]
]

{ #category : #'private - event handling' }
GtRefactoringsToolbarElement >> onGtRefactoringsViewModelExecutedRefactoringsStateAnnouncement: anAnnouncement [
	anAnnouncement refactoringsViewModel == self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self updateDisplayedRefactorings ]
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
GtRefactoringsToolbarElement >> updateAsDisplayedRefactorings [
	progressElement visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsEnabledApplyButton [
	applyButton enable
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateAsHiddenProgress [
	progressElement visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateDisplayedRefactorings [
	self refactoringsViewModel
		ifComputedRefactorings: [ :anExecutedRefactorings | 
			anExecutedRefactorings
				ifBeforeApplying: [ 
					anExecutedRefactorings
						refactoringsDo: [ :aCollection | 
							self updateAsEnabledApplyButton ]
						changesDo: [ :aChanges | 
							self updateAsEnabledApplyButton ]
						emptyDo: [ 
							self updateAsDisabledApplyButton ].
					self updateAsHiddenProgress ]
				ifApplying: [ 
					self updateAsDisabledApplyButton.
					self updateAsHiddenProgress ]
				ifApplied: [ 
					self updateAsDisabledApplyButton.
					self updateAsHiddenProgress ]
				ifFailed: [ 
					self updateAsEnabledApplyButton.
					self updateAsHiddenProgress ] ]
		ifNotComputed: [ 
			self updateAsDisabledApplyButton.
			self updateAsHiddenProgress ]
		ifInProgress: [ 
			self updateAsDisabledApplyButton.
			self updateAsHiddenProgress ]
		ifFailed: [ :anException | 
			self updateAsDisabledApplyButton.
			self updateAsHiddenProgress ]
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateElement [
	self updateDisplayedRefactorings
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateRefactorings: anExecutedRefactorings progressFraction: aFraction [
	self refactoringsViewModel executedRefactorings == anExecutedRefactorings
		ifFalse: [ ^ self ].

	self updateAsDisplayedRefactorings.
	progressElement fraction: aFraction
]
