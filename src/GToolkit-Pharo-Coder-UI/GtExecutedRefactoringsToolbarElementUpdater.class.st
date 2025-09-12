Class {
	#name : #GtExecutedRefactoringsToolbarElementUpdater,
	#superclass : #GtExecutedRefactoringsElementUpdater,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAppyingProgress: aState [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsDisabledApplyButton.
	element updateAsDisplayedProgress.
	element updateProgressFraction: aState applyingProgress.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAsApplicable [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsEnabledApplyButton.
	element updateAsHiddenProgress.
	element updateProgressFraction: 0.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAsApplied [
	element updateAsEnabledApplyButton.
	element updateAsHiddenProgress.
	element updateAsHiddenException.
	element updateAsDisplayedFinishedLabel
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAsNotApplicable [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsDisabledApplyButton.
	element updateAsHiddenProgress.
	element updateProgressFraction: 0.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateWithException: aState [
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
	self updateWithException: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsFailedState: aState [
	self updateWithException: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsNotAppliedState: aState [
	self updateAsApplicable
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
