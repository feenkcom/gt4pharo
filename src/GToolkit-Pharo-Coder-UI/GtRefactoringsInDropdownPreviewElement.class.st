Class {
	#name : #GtRefactoringsInDropdownPreviewElement,
	#superclass : #GtRefactoringsBasicElement,
	#traits : 'TBrSizeAdjustable',
	#classTraits : 'TBrSizeAdjustable classTrait',
	#instVars : [
		'previewButton',
		'cancelButton',
		'previewStencilBuilder',
		'previewContentDo',
		'cancelBlock'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Core'
}

{ #category : #'api - size adjustable' }
GtRefactoringsInDropdownPreviewElement >> beSize: aBrSizeAdjustmentState [
	aBrSizeAdjustmentState isNone
		ifTrue: [ 
			previewButton states removeState: aBrSizeAdjustmentState.
			cancelButton states removeState: aBrSizeAdjustmentState ]
		ifFalse: [ 
			previewButton states addState: aBrSizeAdjustmentState.
			cancelButton states addState: aBrSizeAdjustmentState ]
]

{ #category : #'api - initialization' }
GtRefactoringsInDropdownPreviewElement >> cancelBlock: aBlock [
	"Set a block that is evaluated on cancel button click.
	The block can have two arguments: [ :aRefactoringViewModel :anElement | ]."

	cancelBlock := aBlock
]

{ #category : #initialization }
GtRefactoringsInDropdownPreviewElement >> createPreviewElementInExplicitMenu: anExplicitMenu [
	| aPreviewElement |
	self hasRefactoringsViewModel ifFalse: [ ^ nil ].

	self refactoringsViewModel menuModel: anExplicitMenu.
	self refactoringsViewModel anchorElement: self.
	aPreviewElement := previewStencilBuilder
			refactoringsViewModel: self refactoringsViewModel;
			asElement.

	previewContentDo value: aPreviewElement.

	^ aPreviewElement
]

{ #category : #initialization }
GtRefactoringsInDropdownPreviewElement >> createPreviewHandleElement [
	| aButton |
	aButton := BrButton new
			visibility: BlVisibility hidden;
			aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2;
			icon: BrGlamorousVectorIcons empty.

	previewButton states
		stateLike: BrSizeAdjustmentState normal
		ifFound: [ :aState | aButton beSize: aState ]
		ifNone: [  ].

	^ aButton
]

{ #category : #initialization }
GtRefactoringsInDropdownPreviewElement >> defaultLayout [
	^ BlLinearLayout horizontal
		cellSpacing: GtRefactoringsConstants spaceBetweenComposedElements
]

{ #category : #'focus requesting' }
GtRefactoringsInDropdownPreviewElement >> focusTarget [
	^ previewButton
]

{ #category : #initialization }
GtRefactoringsInDropdownPreviewElement >> initialize [
	super initialize.
	
	cancelBlock := nil.
	previewStencilBuilder := GtRefactoringsInDropdownPreviewStencilBuilder new.
	previewContentDo := [ :aPreviewElement | ].
	
	self
		padding: (BlInsets
				left: GtRefactoringsConstants spaceBetweenComposedElements negated
				right: GtRefactoringsConstants spaceBetweenComposedElements negated).
	self fitContent.

	self initializePreviewButton.
	self initializeCancelButton.

	self addChild: previewButton.
	self addChild: cancelButton
]

{ #category : #initialization }
GtRefactoringsInDropdownPreviewElement >> initializeCancelButton [
	cancelButton := BrButton new
			beFocusable;
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons cancel;
			label: 'Cancel';
			action: [ :aButton :aButtonModel :anEvent | self onCancelClickEvent: anEvent ]
]

{ #category : #initialization }
GtRefactoringsInDropdownPreviewElement >> initializePreviewButton [
	previewButton := BrButton new
			beFocusable;
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons downwards;
			label: 'Preview';
			addAptitude: (BrGlamorousWithExplicitDropdownAptitude new
					withGainFocusOnShow;
					handle: [ self createPreviewHandleElement ]
						content: [ :anExplicitMenu | self createPreviewElementInExplicitMenu: anExplicitMenu ])
]

{ #category : #'private - event handling' }
GtRefactoringsInDropdownPreviewElement >> onCancelClickEvent: anEvent [ 
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	
	cancelBlock ifNotNil: [ :aBlock | 
		aBlock cull: self refactoringsViewModel cull: cancelButton ]
]

{ #category : #'private - event handling' }
GtRefactoringsInDropdownPreviewElement >> onGtRefactoringsViewModelExecutedRefactoringsApplied: anAnnouncement [
	anAnnouncement refactoringsViewModel = self refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self dispatchEvent: GtRefactoringsAppliedEvent new ]
]

{ #category : #'api - initialization' }
GtRefactoringsInDropdownPreviewElement >> previewContent: aBlockOrStencilBuilder [
	"Set a stencil builder that creates a preview element 
	that is displayd in a preview dropdown.
	The block must have one argument: [ :aRefactoringsViewModel | ... ]."

	previewStencilBuilder := aBlockOrStencilBuilder
			asStencilBuilder: GtRefactoringsInDropdownPreviewStencilBuilder
]

{ #category : #'api - initialization' }
GtRefactoringsInDropdownPreviewElement >> previewContentDo: aBlock [
	"Configure a preview element that is displayed in the preview dropdown,
	e.g., set a width.
	The block must have one argument."

	self assert: [ aBlock isNotNil ].
	self assert: [ aBlock numArgs = 1 ].

	previewContentDo := aBlock
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInDropdownPreviewElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.

	self refactoringsViewModel weak
		when: GtRefactoringsViewModelExecutedRefactoringsApplied
		send: #onGtRefactoringsViewModelExecutedRefactoringsApplied:
		to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInDropdownPreviewElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.

	self refactoringsViewModel unsubscribe: self
]
