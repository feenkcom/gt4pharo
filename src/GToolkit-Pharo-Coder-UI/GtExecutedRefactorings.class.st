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
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
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
GtExecutedRefactorings >> beApplyingProgress: aFraction [
	state := state applyingProgress: aFraction
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
GtExecutedRefactorings >> bePreviewed [
	"Corresponding refactoring changes are displayed,
	ready to be reviewed by a user, and
	ready to be applyied.
	
	Return true if the resulting state is a preview state."

	<return: #Boolean>
	state := state previewed.
	^ state isPreviewed
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
	"Execution should be triggered using `GtRefactoringsViewModel>>#computeRefactorings`.
	Users can ask about the execution state calling:
	- `GtRefactoringsViewModel>>#ifComputedRefactorings:ifNotComputed:ifInProgress:ifFailed:`,
	- `GtRefactoringsViewModel>>#ifBeforeApplying:ifApplying:ifApplied:ifFailed:`,
	- `GtExecutedRefactorings>>#ifComputedRefactorings:ifNotComputed:ifInProgress:ifFailed:`, and
	- `GtExecutedRefactorings>>#ifBeforeApplying:ifApplying:ifApplied:ifFailed:`."

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

{ #category : #views }
GtExecutedRefactorings >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'State';
			value: state.
		GtPhlowOverviewItem new
			name: 'Refactorings computation';
			value: refactoringsComputation.
		GtPhlowOverviewItem new
			name: 'Executed refactorings';
			value: executedRefactorings;
			childrenObjects: executedRefactorings;
			if: executedRefactorings isNil subduedDescription: 'Not initialized';
			if: executedRefactorings isNotNil
				description: [ '{1} {2}'
						format: {executedRefactorings size.
								'item' asPluralBasedOn: executedRefactorings size} ].
		GtPhlowOverviewItem new
			name: 'Notification messages';
			value: notificationMessages;
			childrenObjects: notificationMessages;
			if: notificationMessages isNil subduedDescription: 'Not initialized';
			if: notificationMessages isNotNil
				description: [ '{1} {2}'
						format: {notificationMessages size.
								'item' asPluralBasedOn: notificationMessages size} ].
		GtPhlowOverviewItem new
			name: 'Error messages';
			value: errorMessages;
			childrenObjects: errorMessages;
			if: errorMessages isNil subduedDescription: 'Not initialized';
			if: executedRefactorings isNotNil & errorMessages isNotNil
				description: [ '{1} {2}'
						format: {errorMessages size.
								'item' asPluralBasedOn: executedRefactorings size} ]}
]

{ #category : #views }
GtExecutedRefactorings >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Overview';
		items: [ self gtOverview ];
		children: #children;
		expandUpTo: 1;
		column: 'Name' text: #name;
		column: 'Description' text: #description;
		send: #value
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
	"Corresponding refactoring changes are displayed,
	ready to be reviewed by a user, and
	ready to be applyied.
	
	Return true if the resulting state is a preview state."

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
GtExecutedRefactorings >> refactoringsDo: aRefactoringsBlock changesDo: aChangesBlock emptyDo: anEmptyBlock errorMessagesDo: anErrorsBlock [
	self errorMessages ifNotEmpty: [ :aCollection | 
		^ anErrorsBlock cull: aCollection  ].
	self executedRefactorings ifEmpty: [ ^ anEmptyBlock value ].

	^ (self executedRefactorings
		allSatisfy: [ :each | each isKindOf: RBRefactoring ])
		ifTrue: [ aRefactoringsBlock cull: self executedRefactorings ]
		ifFalse: [ | change |
			change := RBCompositeRefactoryChange named: 'Changes'.
			self executedRefactorings do: [ :each | change addChange: each ].
			aChangesBlock cull: change ]
]

{ #category : #'api - state' }
GtExecutedRefactorings >> state [
	<return: #GtExecutedRefactoringsState>
	^ state
]
