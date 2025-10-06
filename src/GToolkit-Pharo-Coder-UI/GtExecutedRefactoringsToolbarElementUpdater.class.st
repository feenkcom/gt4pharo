Class {
	#name : #GtExecutedRefactoringsToolbarElementUpdater,
	#superclass : #GtExecutedRefactoringsElementUpdater,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateApplyingProgress: aState [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsVisibleContainer.
	element updateAsDisabledPreviewButton.
	element updateAsHiddenPreviewButton.
	element updateAsDisabledApplyButton.
	element updateAsVisibleApplyButton.
	element updateAsDisplayedProgress.
	element updateProgressFraction: aState applyingProgress.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAsApplicable [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsVisibleContainer.
	element updateAsDisabledPreviewButton.
	element updateAsHiddenPreviewButton.
	element updateAsEnabledApplyButton.
	element updateAsVisibleApplyButton.
	element updateAsHiddenProgress.
	element updateProgressFraction: 0.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateAsApplied [
	element updateAsVisibleContainer.
	element updateAsDisabledPreviewButton.
	element updateAsHiddenPreviewButton.
	element updateAsDisabledApplyButton.
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
GtExecutedRefactoringsToolbarElementUpdater >> updateAsPreviewable [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	element updateAsVisibleContainer.
	element updateAsEnabledPreviewButton.
	element updateAsVisiblePreviewButton.
	element updateAsDisabledApplyButton.
	element updateAsHiddenApplyButton.
	element updateAsHiddenProgress.
	element updateProgressFraction: 0.
	element updateAsHiddenException.
	element updateAsHiddenFinishedLabel
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateWithComputationFailedException: aState [
	element updateAsVisibleContainer.
	element updateAsVisiblePreviewButton.
	element updateAsDisabledApplyButton.
	element updateAsHiddenApplyButton.
	element updateAsHiddenProgress.
	aState ifFailedStateDo: [ :anException | 
		element updateWithException: anException ].
	element updateAsHiddenFinishedLabel.
]

{ #category : #private }
GtExecutedRefactoringsToolbarElementUpdater >> updateWithFailedException: aState [
	element updateAsVisibleContainer.
	element updateAsDisabledPreviewButton.
	element updateAsHiddenPreviewButton.
	element updateAsEnabledApplyButton.
	element updateAsVisibleApplyButton.
	element updateAsHiddenProgress.
	aState ifFailedStateDo: [ :anException | 
		element updateWithException: anException ].
	element updateAsHiddenFinishedLabel
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsAboutToApplyState: aState [
	self updateApplyingProgress: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsAppliedState: aState [
	self updateAsApplied
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsComputationFailedState: aState [
	self updateWithComputationFailedException: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsFailedState: aState [
	self updateWithFailedException: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsNotAppliedState: aState [
	self ifRefactoringsElementOutOfSyncDo: [ ^ self ].

	self updateAsPreviewable.
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsNotComputedState: aState [
	self updateAsPreviewable
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsPreviewedState: aState [
	self updateAsApplicable.
	element updateAsFocusedApplyButton
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsRunningState: aState [
	self updateApplyingProgress: aState
]

{ #category : #visiting }
GtExecutedRefactoringsToolbarElementUpdater >> visitExecutedRefactoringsState: aState [
	self updateAsNotApplicable
]
