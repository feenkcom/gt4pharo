Class {
	#name : #GtPharoRenameSelectorRefactoringsPreviewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrSizeAdjustable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrSizeAdjustable classTrait',
	#instVars : [
		'selectorModel',
		'previewElement',
		'refactoringsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'api - size adjustable' }
GtPharoRenameSelectorRefactoringsPreviewElement >> beSize: aBrSizeAdjustmentState [
	previewElement beSize: aBrSizeAdjustmentState
]

{ #category : #initialization }
GtPharoRenameSelectorRefactoringsPreviewElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtPharoRenameSelectorRefactoringsPreviewElement >> initialize [
	"GtRefactoringChangesAttribute"

	super initialize.
	self initializePreviewElement.
	self initializeElementStyling.

	self addChild: previewElement.

	self fitContent.
	self beMiniSize
]

{ #category : #initialization }
GtPharoRenameSelectorRefactoringsPreviewElement >> initializeElementStyling [
]

{ #category : #initialization }
GtPharoRenameSelectorRefactoringsPreviewElement >> initializePreviewElement [
	previewElement := GtRefactoringsInDropdownPreviewElement new.
	refactoringsViewModel := GtRefactoringsViewModel new.
	previewElement refactoringsViewModel: refactoringsViewModel
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorRefactoringsPreviewElement >> onGtPharoRenameSelectorModificationChanged: anAnnouncement [
	anAnnouncement selectorModel = selectorModel ifFalse: [ ^ self ].
	BlTaskAction
		enqueueElement: self
		action: [ self updatePreviewElementVisibility ]
]

{ #category : #'private - hooks' }
GtPharoRenameSelectorRefactoringsPreviewElement >> onSelectorModelChanged [
	self updateElement
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsPreviewElement >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsPreviewElement >> selectorModel: aSelectorModel [
	"We assumet that it is initialized just once.
	If it changes in the future, we adopt this code."

	self assert: [ aSelectorModel isNotNil ].
	self assert: [ selectorModel isNil ].

	selectorModel := aSelectorModel.
	
	self onSelectorModelChanged.
	self subscribeToSelectorModel.
]

{ #category : #'private - hooks' }
GtPharoRenameSelectorRefactoringsPreviewElement >> subscribeToSelectorModel [
	selectorModel announcer weak
		when: GtPharoRenameSelectorModificationChanged
		send: #onGtPharoRenameSelectorModificationChanged:
		to: self
]

{ #category : #'private - updating' }
GtPharoRenameSelectorRefactoringsPreviewElement >> updateElement [
	self updatePreviewElementVisibility
]

{ #category : #'private - updating' }
GtPharoRenameSelectorRefactoringsPreviewElement >> updatePreviewElementVisibility [
	selectorModel isModified
		ifTrue: [ self visibility: BlVisibility visible ]
		ifFalse: [ self visibility: BlVisibility hidden ]
]
