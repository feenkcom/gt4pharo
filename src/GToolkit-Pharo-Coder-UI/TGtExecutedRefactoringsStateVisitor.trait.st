Trait {
	#name : #TGtExecutedRefactoringsStateVisitor,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsAboutToApplyState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsAboutToComputeState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsAppliedState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsComputationFailedState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsFailedState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsNotAppliedState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsNotComputedState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsPreviewedState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsRunningState: aState [
	^ self visitExecutedRefactoringsState: aState
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitExecutedRefactoringsState: aState [
	
]

{ #category : #visiting }
TGtExecutedRefactoringsStateVisitor >> visitState: aState [
	^ aState acceptVisitor: self
]
