Class {
	#name : #GtExecutedRefactoringsState,
	#superclass : #Object,
	#classVars : [
		'AboutToApply',
		'AboutToCompute',
		'Applied',
		'NotApplied',
		'NotComputed',
		'Previewed'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> aboutToApply [
	^ AboutToApply ifNil: [ AboutToApply := GtExecutedRefactoringsAboutToApplyState new ]
]

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> aboutToCompute [
	^ AboutToCompute ifNil: [ AboutToCompute := GtExecutedRefactoringsAboutToComputeState new ]
]

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> applied [
	^ Applied ifNil: [ Applied := GtExecutedRefactoringsAppliedState new ]
]

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> computingFailed: anException [
	^ GtExecutedRefactoringsComputationFailedState new exception: anException
]

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> failed: anException [
	^ GtExecutedRefactoringsFailedState new exception: anException
]

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> notApplied [
	^ NotApplied ifNil: [ NotApplied := GtExecutedRefactoringsNotAppliedState new ]
]

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> notComputed [
	^ NotComputed ifNil: [ NotComputed := GtExecutedRefactoringsNotComputedState new ]
]

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> previewed [
	^ Previewed ifNil: [ Previewed := GtExecutedRefactoringsPreviewedState new ]
]

{ #category : #'api - accessing' }
GtExecutedRefactoringsState class >> running: aPromise [
	^ GtExecutedRefactoringsRunningState new promise: aPromise
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> canBeApplied [
	<return: #Boolean>
	^ false
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> canBeReplaced [
	"Return true if corresponding executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ false
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifComputationFailedDo: aBlock [
	"Block receives an exception: [ :anException | ... ]"

	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifComputationInProgressDo: aBlock [
	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifFailedStateDo: aBlock [
	"Block receives an exception: [ :anException | ... ]"

	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifNotComputedDo: aBlock [
	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> isPreviewed [
	"Return true if corresponding executed refactorings is previewed"

	<return: #Boolean>
	^ false
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> running: aPromise [
	^ self
]
