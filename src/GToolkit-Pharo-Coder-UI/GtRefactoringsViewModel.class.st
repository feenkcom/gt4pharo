Class {
	#name : #GtRefactoringsViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtOptions',
	#classTraits : 'TGtAnnouncer classTrait + TGtOptions classTrait',
	#instVars : [
		'beforeApplyBlock',
		'isPreviewButtonFocused',
		'refactoringTitle',
		'targetName',
		'menuModel',
		'anchorElement',
		'executedRefactorings',
		'announcer',
		'afterAppliedBlock'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Core'
}

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> aboutToApplyRefactorings: anExecutedRefactorings [
	"Return true if refactorings may be applied."

	<return: #Boolean>
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ false ].

	anExecutedRefactorings canBeApplied ifFalse: [ ^ false ].
	anExecutedRefactorings beAboutToApply.

	self privateNotifyAboutToApplyRefactorings.
	
	self beforeApplyBlock value.
	
	^ true
]

{ #category : #accessing }
GtRefactoringsViewModel >> afterAppliedBlock [
	"Return a block that is evaluated after refactorings are successfully applied.
	The block must understands the #value message.
	Note: the block is currently evaluated in a UI process. See:
		- `GtRefactoringsJustPreviewElement>>#onApplyChangesRequest:`, and
		- `GtRefactoringsViewModel>>#appliedRefactorings:`"

	<return: #BlockClosure>
	^ afterAppliedBlock
]

{ #category : #accessing }
GtRefactoringsViewModel >> afterAppliedBlock: aBlock [
	"Set a block that is evaluated after refactorings are successfully applied.
	The block must understands the #value message.
	Note: the block is currently evaluated in a UI process. See:
		- `GtRefactoringsJustPreviewElement>>#onApplyChangesRequest:`, and
		- `GtRefactoringsViewModel>>#appliedRefactorings:`"

	afterAppliedBlock := aBlock
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
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ self ].

	anExecutedRefactorings beApplied.

	self privateNotifyAppliedRefactorings.
	
	self afterAppliedBlock value
]

{ #category : #'api - converting' }
GtRefactoringsViewModel >> asPreviewElement [
	^ GtRefactoringsPreviewElement new refactoringsViewModel: self
]

{ #category : #accessing }
GtRefactoringsViewModel >> beforeApplyBlock [
	"Return a block that is evaluated before refactorings are applied.
	The block must understands the #value message.
	Note: the block is currently evaluated in a UI process. See:
		- `GtRefactoringsJustPreviewElement>>#onApplyChangesRequest:`, and
		- `GtRefactoringsViewModel>>#aboutToApplyRefactorings:`"

	<return: #BlockClosure>
	^ beforeApplyBlock
]

{ #category : #accessing }
GtRefactoringsViewModel >> beforeApplyBlock: aBlock [
	"Set a block that is evaluated before refactorings are applied.
	The block must understands the #value message.
	Note: the block is currently evaluated in a UI process. See:
		- `GtRefactoringsJustPreviewElement>>#onApplyChangesRequest:`, and
		- `GtRefactoringsViewModel>>#aboutToApplyRefactorings:`"

	beforeApplyBlock := aBlock
]

{ #category : #'api - testing' }
GtRefactoringsViewModel >> canExecutedRefactoringsBeReplaced [
	"Return true if existing executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ self executedRefactorings canBeReplaced
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> computeRefactoringsFrom: aSource [
	"Computation of refactorings should be triggered using this method.
	Users can ask about the execution state calling:
	- `GtRefactoringsViewModel>>#ifComputedRefactorings:ifNotComputed:ifInProgress:ifFailed:ifDisabled:`,
	- `GtRefactoringsViewModel>>#ifBeforeApplying:ifApplying:ifApplied:ifFailed:ifDisabled:`,
	- `GtExecutedRefactorings>>#ifComputedRefactorings:ifNotComputed:ifInProgress:ifFailed:ifDisabled:`, and
	- `GtExecutedRefactorings>>#ifBeforeApplying:ifApplying:ifApplied:ifFailed:ifDisabled:`."

	| anExecutedRefactorings |
	anExecutedRefactorings := self executedRefactorings.

	anExecutedRefactorings
		ifComputedRefactorings: [  ]
		ifNotComputed: [ 
			anExecutedRefactorings executedRefactorings.
			self
				privateNotifyComputedRefactorings: anExecutedRefactorings
				source: aSource ]
		ifInProgress: [  ]
		ifFailed: [  ]
		ifDisabled: [  ].

	^ anExecutedRefactorings
]

{ #category : #initialization }
GtRefactoringsViewModel >> defaultExecutedRefactorings [
	^ GtExecutedRefactorings new
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
	
	self privateNotifyFailedRefactorings
]

{ #category : #views }
GtRefactoringsViewModel >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Refactorings title';
			value: refactoringTitle.
		GtPhlowOverviewItem new
			name: 'Target name';
			value: targetName.
		GtPhlowOverviewItem new
			name: 'Executed refactorings';
			value: executedRefactorings;
			childrenItems: (executedRefactorings ifNotNil: #gtOverview).
		GtPhlowOverviewItem new
			name: 'Is preview button focused';
			boolean: isPreviewButtonFocused.
		GtPhlowOverviewItem new
			name: 'Before apply block';
			value: beforeApplyBlock.
		GtPhlowOverviewItem new
			name: 'After applied block';
			value: afterAppliedBlock.
		GtPhlowOverviewItem new
			name: 'Context menu model';
			value: menuModel.
		GtPhlowOverviewItem new
			name: 'Anchor element';
			value: anchorElement.
		GtPhlowOverviewItem new
			name: 'Announcer';
			value: announcer}
]

{ #category : #views }
GtRefactoringsViewModel >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Overview';
		priority: 10;
		items: [ self gtOverview ];
		children: #children;
		expandUpTo: 1;
		column: 'Name' text: #name;
		column: 'Description' text: #description;
		send: #value
]

{ #category : #'api - testing' }
GtRefactoringsViewModel >> hasPreviewedExecutedRefactorings [
	"Return true if existing executed refactorings is previewed"

	<return: #Boolean>
	^ self executedRefactorings isPreviewed
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> ifBeforeApplying: aBeforeApplyingBlock ifApplying: anApplyingBlock ifApplied: anAppliedBlock ifFailed: aFailedBlock ifDisabled: aDisabledBlock [
	^ self executedRefactorings
		ifBeforeApplying: aBeforeApplyingBlock
		ifApplying: anApplyingBlock
		ifApplied: anAppliedBlock
		ifFailed: aFailedBlock
		ifDisabled: aDisabledBlock
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> ifComputedRefactorings: aComputedBlock ifNotComputed: aNotComputedBlock ifInProgress: aProgressBlock ifFailed: aFailedBlock ifDisabled: aDisabledBlock [
	^ self executedRefactorings
		ifComputedRefactorings: aComputedBlock
		ifNotComputed: aNotComputedBlock
		ifInProgress: aProgressBlock
		ifFailed: aFailedBlock
		ifDisabled: aDisabledBlock
]

{ #category : #initialization }
GtRefactoringsViewModel >> initialize [
	super initialize.

	announcer := Announcer new.
	executedRefactorings := self defaultExecutedRefactorings.

	refactoringTitle := nil.
	targetName := nil.
	isPreviewButtonFocused := true.
	beforeApplyBlock := [  ].
	afterAppliedBlock := [  ]
]

{ #category : #accessing }
GtRefactoringsViewModel >> isPreviewButtonFocused [
	<return: #Boolean>
	^ isPreviewButtonFocused
]

{ #category : #accessing }
GtRefactoringsViewModel >> isPreviewButtonFocused: aBoolean [
	self assert: [ aBoolean isBoolean ].
	isPreviewButtonFocused = aBoolean ifTrue: [ ^ self ].

	isPreviewButtonFocused := aBoolean.
	
	self privateNotifyPreviewButtonFocusedChanged
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
GtRefactoringsViewModel >> notifyApplyChangesRequested [
	"I notify that executed refactoring changes can be applied.
	In other words, a user agreed to apply the refactoring changes."

	self executedRefactorings
		ifComputedRefactorings: [ :anExecutedRefactorings | 
			anExecutedRefactorings
				ifBeforeApplying: [ self privateNotifyApplyChangesRequested ]
				ifApplying: [  ]
				ifApplied: [  ]
				ifFailed: [ self privateNotifyApplyChangesRequested ]
				ifDisabled: [  ] ]
		ifNotComputed: [  ]
		ifInProgress: [  ]
		ifFailed: [  ]
		ifDisabled: [  ]
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
GtRefactoringsViewModel >> notifyRefactorings: anExecutedRefactorings applyingProgress: aFraction [
	| anAnnouncement |
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ self ].

	anExecutedRefactorings beApplyingProgress: aFraction.
	
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsProgressChanged new
			refactoringsViewModel: self;
			executedRefactorings: anExecutedRefactorings;
			fraction: aFraction.
	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> notifySubmitExecutedRefactoringsRequested [
	"I notify that {{gtMethod:GtRefactoringsViewModel >> refactorings:}} should be updated.
	I am used:
	- to confirm that refactorings can be computed (and then previewed), see {{gtMethod:GtRefactoringsWithInputViewModel >> refactoringsForInput:}},
	- to update refactorings based on a user input, see {{gtMethod:GtRefactoringsWithConfirmationViewModel>>#confirmRefactorings}}."

	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelSubmitExecutedRefactoringsRequested new
			refactoringsViewModel: self.
	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> previewedRefactorings: anExecutedRefactorings [
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ self ].
	anExecutedRefactorings isPreviewed ifTrue: [ ^ self ].
	
	anExecutedRefactorings bePreviewed ifFalse: [ ^ self ].

	self privateNotifyPreviewedRefactorings
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyAboutToApplyRefactorings [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsAboutToApply new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyAppliedRefactorings [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsApplied new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyApplyChangesRequested [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelApplyChangesRequested new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyComputedRefactorings: anExecutedRefactorings source: aSource [
	| anAnnouncement |
	self executedRefactorings == anExecutedRefactorings ifFalse: [ ^ self ].
	
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsComputed new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings;
			source: aSource.
	self announce: anAnnouncement
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyExecutedRefactoringsChanged [
	<return: #Boolean>
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsChanged new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement.
	^ anAnnouncement isPreviewed
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyFailedRefactorings [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsFailed new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyPreviewButtonFocusedChanged [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelPreviewButtonFocusedChanged new
			refactoringsViewModel: self;
			isFocused: self isPreviewButtonFocused.
	self announce: anAnnouncement
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyPreviewedRefactorings [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelExecutedRefactoringsPreviewed new
			refactoringsViewModel: self;
			executedRefactorings: self executedRefactorings.
	self announce: anAnnouncement
]

{ #category : #'private - notifying' }
GtRefactoringsViewModel >> privateNotifyTargetNameChanged [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelTargetNameChanged new
			refactoringsViewModel: self;
			targetName: self targetName.
	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsViewModel >> refactoring: aBlock [
	"Set a block that returns a collection of refactorings.
	The block must not have arguments.
	Return true if the new refactorings is (about to be) previewed."

	<return: #Boolean>
	executedRefactorings := GtExecutedRefactorings new refactoring: aBlock.

	^ self privateNotifyExecutedRefactoringsChanged
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

	^ self privateNotifyExecutedRefactoringsChanged
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetName [
	<return: #String or: nil>
	^ targetName
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetName: aString [
	"Set the refactoring target name, e.g., class name"

	targetName = aString ifTrue: [ ^ self ].
	
	targetName := aString.
	
	self privateNotifyTargetNameChanged
]

{ #category : #accessing }
GtRefactoringsViewModel >> targetNameDo: aBlock [
	targetName ifNotNil: aBlock
]

{ #category : #'announcer - subscription' }
GtRefactoringsViewModel >> whenRefactoringsAppliedSend: aSelector to: aReceiver [
	^ self weak
		when: GtRefactoringsViewModelExecutedRefactoringsApplied
		send: aSelector
		to: aReceiver
]
