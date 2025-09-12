Class {
	#name : #GtExecutedRefactoringsToolbarElementUpdater,
	#superclass : #GtExecutedRefactoringsElementUpdater,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAppyingProgress: aState [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsVisibleContainer.
	element updateAsDisabledApplyButton.
	element updateAsDisplayedProgress.
	element updateProgressFraction: aState applyingProgress.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAsApplicable [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsVisibleContainer.
	element updateAsEnabledApplyButton.
	element updateAsHiddenProgress.
	element updateProgressFraction: 0.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAsApplied [
	element updateAsVisibleContainer.
	element updateAsEnabledApplyButton.
	element updateAsHiddenProgress.
	element updateAsHiddenException.
	element updateAsDisplayedFinishedLabel
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAsNotApplicable [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsHiddenContainer.
	element updateAsDisabledApplyButton.
	element updateAsHiddenProgress.
	element updateProgressFraction: 0.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateWithException: aState [
	element updateAsVisibleContainer.
	element updateAsEnabledApplyButton.
	element updateAsHiddenProgress.
	aState ifFailedStateDo: [ :anException | 
		element updateWithException: anException ].
	element updateAsHiddenFinishedLabel.
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsAboutToApplyState: aState [
	self updateAppyingProgress: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsAppliedState: aState [
	self updateAsApplied
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsComputationFailedState: aState [
	"I think I should display this error in another place.
	The preview with input element should display:
	- input element
	- error"

	self updateWithException: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsFailedState: aState [
	self updateWithException: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsNotAppliedState: aState [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	"Changes must be previewed to make it applicable."
	self updateAsNotApplicable.
	true ifTrue: [ ^ self ].
	executedRefactorings
		refactoringsDo: [ self updateAsApplicable ]
		changesDo: [ self updateAsApplicable ]
		emptyDo: [ self updateAsNotApplicable ]
		errorMessagesDo: [ self updateAsNotApplicable ]
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsNotComputedState: aState [
	self updateAsNotApplicable
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsPreviewedState: aState [
	self updateAsApplicable
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsRunningState: aState [
	self updateAppyingProgress: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsState: aState [
	self updateAsNotApplicable
]
