Class {
	#name : #GtRefactoringsInputElementUpdater,
	#superclass : #GtExecutedRefactoringsElementUpdater,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #private }
GtRefactoringsInputElementUpdater >> updateAsEditableWithException: anException [
	element updateAsDisplayedToolbarContainer.
	element updateAsWithException: anException.
	element updateAsEnabledPreviewButton.
	element updateAsEditableInputEditor
]

{ #category : #private }
GtRefactoringsInputElementUpdater >> updateAsEditableWithoutExceptions [
	element updateAsDisplayedToolbarContainer.
	element updateAsWithoutExceptions.
	element updateAsEnabledPreviewButton.
	element updateAsEditableInputEditor
]

{ #category : #private }
GtRefactoringsInputElementUpdater >> updateAsPreviewedWithoutExceptions [
	element updateAsHiddenToolbarContainer.
	element updateAsWithoutExceptions.
	element updateAsDisabledPreviewButton.
	element updateAsEditableInputEditor
]

{ #category : #private }
GtRefactoringsInputElementUpdater >> updateAsReadOnlyWithoutExceptions [
	element updateAsHiddenToolbarContainer.
	element updateAsWithoutExceptions.
	element updateAsDisabledPreviewButton.
	element updateAsReadOnlyInputEditor
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsAboutToApplyState: aState [
	self updateAsReadOnlyWithoutExceptions
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsAboutToComputeState: aState [
	self updateAsReadOnlyWithoutExceptions
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsAppliedState: aState [
	self updateAsReadOnlyWithoutExceptions
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsComputationFailedState: aState [
	self updateAsEditableWithException: aState exception
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsFailedState: aState [
	self updateAsReadOnlyWithoutExceptions
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsNotAppliedState: aState [
	self updateAsEditableWithoutExceptions
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsNotComputedState: aState [
	self updateAsEditableWithoutExceptions
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsPreviewedState: aState [
	self updateAsPreviewedWithoutExceptions
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsRunningState: aState [
	self updateAsReadOnlyWithoutExceptions
]
