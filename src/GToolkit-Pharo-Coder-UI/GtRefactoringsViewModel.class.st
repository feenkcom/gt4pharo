Class {
	#name : #GtRefactoringsViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtOptions',
	#classTraits : 'TGtAnnouncer classTrait + TGtOptions classTrait',
	#instVars : [
		'beforeApplyBlock',
		'cancelBlock',
		'isPreviewButtonFocused',
		'refactoringTitle',
		'targetName',
		'menuModel',
		'anchorElement',
		'executedRefactorings',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> aboutToApplyRefactorings: anExecutedRefactorings [
	"Return true if refactorings may be applied."

	<return: #Boolean>
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ false ].

	anExecutedRefactorings canBeApplied ifFalse: [ ^ false ].
	anExecutedRefactorings beAboutToApply.

	self notifyAboutToApplyRefactorings.

	^ true
]

{ #category : #accessing }
GtRefactoringsViewModel >> anchorElement [
	<return: #BlElement or: nil>
	^ anchorElement
]

{ #category : #accessing }
GtRefactoringsViewModel >> anchorElement: anElement [
	"Set an anchor element from where a refactoring is displayed"

	anchorElement := anElement
]

{ #category : #announcer }
GtRefactoringsViewModel >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> appliedRefactorings: anExecutedRefactorings [
	GtJustContextStackSignal emit.
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ self ].

	anExecutedRefactorings beApplied.

	self notifyAppliedRefactorings
]

{ #category : #accessing }
GtRefactoringsViewModel >> beforeApplyBlock [
	<return: #BlockClosure>
	^ beforeApplyBlock
]

{ #category : #accessing }
GtRefactoringsViewModel >> beforeApplyBlock: anObject [
	beforeApplyBlock := anObject
]

{ #category : #'api - testing' }
GtRefactoringsViewModel >> canExecutedRefactoringsBeReplaced [
	"Return true if existing executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ self executedRefactorings canBeReplaced
]

{ #category : #accessing }
GtRefactoringsViewModel >> cancelBlock [
	<return: #BlockClosure>
	^ cancelBlock
]

{ #category : #accessing }
GtRefactoringsViewModel >> cancelBlock: anObject [
	cancelBlock := anObject
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> executedRefactorings [
	"Return a object that can compute a collection of refactoring objects"

	<return: #GtExecutedRefactorings>
	^ executedRefactorings
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> failedRefactorings: anExecutedRefactorings exception: anError [
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ self ].

	anExecutedRefactorings beFailed: anError.
	
	self notifyFailedRefactorings
]

{ #category : #'api - testing' }
GtRefactoringsViewModel >> hasPreviewedExecutedRefactorings [
	"Return true if existing executed refactorings is previewed"

	<return: #Boolean>
	^ self executedRefactorings isPreviewed
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> ifComputedRefactorings: aComputedBlock ifNotComputed: aNotComputedBlock ifInProgress: aProgressBlock ifFailed: aFailedBlock [
	^ self executedRefactorings
		ifComputedRefactorings: aComputedBlock
		ifNotComputed: aNotComputedBlock
		ifInProgress: aProgressBlock
		ifFailed: aFailedBlock
]

{ #category : #initialization }
GtRefactoringsViewModel >> initialize [
	super initialize.

	announcer := Announcer new.
	executedRefactorings := GtExecutedRefactorings new.
	
	refactoringTitle := nil.
	targetName := nil.
	isPreviewButtonFocused := true.
	beforeApplyBlock := [  ].
	cancelBlock := [  ]
]

{ #category : #accessing }
GtRefactoringsViewModel >> isPreviewButtonFocused [
	<return: #Boolean>
	^ isPreviewButtonFocused
]

{ #category : #accessing }
GtRefactoringsViewModel >> isPreviewButtonFocused: anObject [
	isPreviewButtonFocused := anObject
]

{ #category : #accessing }
GtRefactoringsViewModel >> menuModel [
	<return: #BrMenu or: nil>
	^ menuModel
]

{ #category : #accessing }
GtRefactoringsViewModel >> menuModel: aBrMenu [
	"Set a menu model where a refactorings element is displayed"

	menuModel := aBrMenu
]

{ #category : #accessing }
GtRefactoringsViewModel >> menuModelDo: aBlock [
	menuModel ifNotNil: aBlock
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> notifyAboutToApplyRefactorings [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsAboutToApply new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> notifyAppliedRefactorings [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsApplied new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> notifyComputedRefactorings: anExecutedRefactorings [
	| anAnnouncement |
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ self ].
	
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsComputed new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> notifyComputingRefactoringsFailed: anException [
	| anAnnouncement |
	
	self executedRefactorings beComputingFailed: anException.
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsComputationFailed new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> notifyExecutedRefactoringsChanged [
	<return: #Boolean>
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsChanged new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement.
	^ anAnnouncement isPreviewed
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> notifyFailedRefactorings [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsFailed new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> refactoring: aBlock [
	"Set a block that returns a collection of refactorings.
	The block must not have arguments.
	Return true if the new refactorings is (about to be) previewed."

	<return: #Boolean>
	executedRefactorings := GtExecutedRefactorings new refactoring: aBlock.

	^ self notifyExecutedRefactoringsChanged
]

{ #category : #accessing }
GtRefactoringsViewModel >> refactoringTitle [
	<return: #String or: nil>
	^ refactoringTitle
]

{ #category : #accessing }
GtRefactoringsViewModel >> refactoringTitle: aString [
	"Set the refactoring title, e.g., Convert to sibling"

	refactoringTitle := aString
]

{ #category : #accessing }
GtRefactoringsViewModel >> refactoringTitleDo: aBlock [
	refactoringTitle ifNotNil: aBlock
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> refactorings: aBlock [
	"Set a block that returns a collection of refactorings.
	Block must have no arguments.
	Return true if the new refactorings is (about to be) previewed."

	<return: #Boolean>
	executedRefactorings := GtExecutedRefactorings new refactorings: aBlock.

	^ self notifyExecutedRefactoringsChanged
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetName [
	<return: #String or: nil>
	^ targetName
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetName: aString [
	"Set the refactoring target name, e.g., class name"

	targetName := aString
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetNameDo: aBlock [
	targetName ifNotNil: aBlock
]
