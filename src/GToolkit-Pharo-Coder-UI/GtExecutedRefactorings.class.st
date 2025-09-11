Class {
	#name : #GtExecutedRefactorings,
	#superclass : #Object,
	#instVars : [
		'refactoringsComputation',
		'executedRefactorings',
		'errorMessages',
		'notificationMessages',
		'state'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - state' }
GtExecutedRefactorings >> beAboutToApply [
	state := GtExecutedRefactoringsState aboutToApply
]

{ #category : #'api - state' }
GtExecutedRefactorings >> beApplied [
	state := GtExecutedRefactoringsState applied
]

{ #category : #'api - state' }
GtExecutedRefactorings >> beComputingFailed: anException [
	state := GtExecutedRefactoringsState computingFailed: anException
]

{ #category : #'api - state' }
GtExecutedRefactorings >> beFailed: anException [
	state := GtExecutedRefactoringsState failed: anException
]

{ #category : #'api - state' }
GtExecutedRefactorings >> beRunning: aPromise [
	state := state running: aPromise
]

{ #category : #'api - state' }
GtExecutedRefactorings >> canBeApplied [
	<return: #Boolean>
	^ state canBeApplied
]

{ #category : #'api - state' }
GtExecutedRefactorings >> canBeReplaced [
	"Return true if this executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ state canBeReplaced
]

{ #category : #'api - compute' }
GtExecutedRefactorings >> errorMessages [
	errorMessages ifNil: [ self executeRefactorings ].
	^ errorMessages
]

{ #category : #private }
GtExecutedRefactorings >> executeRefactorings [
	state := GtExecutedRefactoringsState aboutToCompute.
	errorMessages := OrderedCollection new.
	notificationMessages := OrderedCollection new.
	executedRefactorings := self refactorings.
	executedRefactorings
		do: [ :each | 
			(each isKindOf: RBRefactoring)
				ifTrue: [ each model
						name: ([ each gtDescription asString ]
								on: Error
								do: [ :ex | ex return: each printString ]) ].
			[ [ each primitiveExecute ]
				on: GtRefactoringNotification
				do: [ :ex | 
					notificationMessages add: ex messageBlock.
					ex pass ] ]
				on: RBRefactoringError
				do: [ :ex | 
					errorMessages add: ex messageBlock.
					ex return ] ].
	state := GtExecutedRefactoringsState notApplied.
]

{ #category : #'api - compute' }
GtExecutedRefactorings >> executedRefactorings [
	executedRefactorings ifNil: [ self executeRefactorings ].
	^ executedRefactorings
]

{ #category : #'api - state' }
GtExecutedRefactorings >> ifBeforeApplying: aBeforeApplyingBlock ifApplying: anApplyingBlock ifApplied: anAppliedBlock ifFailed: aFailedBlock [
	state ifBeforeApplyingDo: [ ^ aBeforeApplyingBlock value ].
	state ifApplyingDo: [ ^ anApplyingBlock value ].
	state ifAppliedDo: [ ^ anAppliedBlock value ].
	state ifFailedStateDo: [ :anException | ^ aFailedBlock cull: anException ].
	
	self error: 'Must not reach this point'
]

{ #category : #'api - state' }
GtExecutedRefactorings >> ifComputedRefactorings: aComputedBlock ifNotComputed: aNotComputedBlock ifInProgress: aProgressBlock ifFailed: aFailedBlock [
	state ifNotComputedDo: [ ^ aNotComputedBlock value ].
	state ifComputationInProgressDo: [ ^ aProgressBlock value ].
	state ifComputationFailedDo: [ :anException | ^ aFailedBlock cull: anException ].

	^ aComputedBlock cull: self
]

{ #category : #'api - state' }
GtExecutedRefactorings >> ifFailedStateDo: aBlock [
	"Block receives an exception: [ :anException | ... ]"
	state ifFailedStateDo: aBlock
]

{ #category : #initialization }
GtExecutedRefactorings >> initialize [
	super initialize.
	refactoringsComputation := [ #() ].
	state := GtExecutedRefactoringsState notComputed
]

{ #category : #'api - state' }
GtExecutedRefactorings >> isPreviewed [
	"Return true if existing executed refactorings is previewed"

	<return: #Boolean>
	^ state isPreviewed
]

{ #category : #'api - compute' }
GtExecutedRefactorings >> notificationMessages [
	notificationMessages ifNil: [ self executeRefactorings ].
	^ notificationMessages
]

{ #category : #'api - accessing' }
GtExecutedRefactorings >> refactoring: aBlock [
	"Set a block that returns a collection of refactorings.
	The block must not have arguments."

	self assert: [ aBlock isNotNil ].
	self refactorings: [ Array with: aBlock value ]
]

{ #category : #'api - accessing' }
GtExecutedRefactorings >> refactorings [
	<return: #Collection of: #RBRefactoring>
	^ refactoringsComputation value
]

{ #category : #'api - accessing' }
GtExecutedRefactorings >> refactorings: aBlock [
	"Set a block that returns a collection of refactorings.
	Block must not have arguments."

	self assert: [ aBlock isNotNil ].
	refactoringsComputation := aBlock
]

{ #category : #'api - accessing' }
GtExecutedRefactorings >> refactoringsComputation [
	<return: #BlockClosure of: #Collection of: #RBRefactoring>
	^ refactoringsComputation
]

{ #category : #'api - compute' }
GtExecutedRefactorings >> refactoringsDo: aRefactoringsBlock changesDo: aChangesBlock emptyDo: anEmptyBlock [
	self executedRefactorings ifEmpty: [ ^ anEmptyBlock value ].

	^ (self executedRefactorings
		allSatisfy: [ :each | each isKindOf: RBRefactoring ])
		ifTrue: [ aRefactoringsBlock value: self executedRefactorings ]
		ifFalse: [ | change |
			change := RBCompositeRefactoryChange named: 'Changes'.
			self executedRefactorings do: [ :each | change addChange: each ].
			change ]
]
