Class {
	#name : #GtRefactoringsInputElementUpdater,
	#superclass : #GtExecutedRefactoringsElementUpdater,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #private }
GtRefactoringsInputElementUpdater >> updateAsEditable [
	element updateAsEditableInputEditor
]

{ #category : #private }
GtRefactoringsInputElementUpdater >> updateAsPreviewed [
	element updateAsEditableInputEditor
]

{ #category : #private }
GtRefactoringsInputElementUpdater >> updateAsReadOnly [
	element updateAsReadOnlyInputEditor
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsAboutToApplyState: aState [
	self updateAsReadOnly
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsAboutToComputeState: aState [
	self updateAsReadOnly
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsAppliedState: aState [
	self updateAsReadOnly
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsComputationFailedState: aState [
	self updateAsEditable
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsFailedState: aState [
	self updateAsReadOnly
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsNotAppliedState: aState [
	self updateAsEditable
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsNotComputedState: aState [
	self updateAsEditable
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsPreviewedState: aState [
	self updateAsPreviewed
]

{ #category : #visiting }
GtRefactoringsInputElementUpdater >> visitExecutedRefactoringsRunningState: aState [
	self updateAsReadOnly
]
