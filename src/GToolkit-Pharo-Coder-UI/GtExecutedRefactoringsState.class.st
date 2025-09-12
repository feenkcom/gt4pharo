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

{ #category : #visiting }
GtExecutedRefactoringsState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsState: self
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> applyingProgress [
	"Return progress of applied changes.
	Fraction is number between 0 and 1: <0;1>"

	<return: #Number>
	^ 0
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> applyingProgress: aFraction [
	"Set progress of applied changes.
	Fraction is number between 0 and 1: <0;1>"
	^ self
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
GtExecutedRefactoringsState >> ifAppliedDo: aBlock [
	"Evaluate block if refactorings are successfully applied"

	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifApplyingDo: aBlock [
	"Evaluate block if refactorings are in a process of application 
	(of saving changes to the system)"

	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifBeforeApplyingDo: aBlock [
	"Evaluate block if refactorings are not:
	- in a process of application (of saving changes to the system), or
	- applied (successfully or with a failure).
	Block receives an exception: [ :anException | ... ]"

	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifComputationFailedDo: aBlock [
	"Evaluate block if refactorings computation failed.
	Block receives an exception: [ :anException | ... ]"

	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifComputationInProgressDo: aBlock [
	"Evaluate block if refactorings computation is in progress."

	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifFailedStateDo: aBlock [
	"Evaluate block if anything failed (raised an exception).
	Block receives an exception: [ :anException | ... ]"

	
]

{ #category : #'api - state' }
GtExecutedRefactoringsState >> ifNotComputedDo: aBlock [
	"Evaluate block if refactorings were not computed yet."

	
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
