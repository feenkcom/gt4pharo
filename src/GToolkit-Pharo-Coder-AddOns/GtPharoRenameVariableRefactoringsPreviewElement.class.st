"
I display the preview of refactorings that apply the rename. I am visible only if the name of a {{gtClass:GtPharoRenameVariableModel}} is modified and valid. I am configured by a {{gtClass:GtRefactoringsConfiguration}}. I am the counterpart of {{gtClass:GtPharoRenameSelectorRefactoringsPreviewElement}}.

# Example
{{gtExample:GtPharoRenameVariableElementsExamples>>#previewElementVisibility | codeExpanded=false | previewExpanded | previewHeight=100}}
"
Class {
	#name : #GtPharoRenameVariableRefactoringsPreviewElement,
	#superclass : #BlElement,
	#instVars : [
		'variableModel',
		'previewElement',
		'refactoringsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #configuration }
GtPharoRenameVariableRefactoringsPreviewElement >> configureWith: aRefactoringsConfiguration [
	aRefactoringsConfiguration cancelAction
		ifNotNil: [ :aBlock | previewElement cancelBlock: aBlock ].
	aRefactoringsConfiguration focusAction
		ifNotNil: [ :aBlock | previewElement previewContentDo: aBlock ].
	aRefactoringsConfiguration completionAction
		ifNotNil: [ :aBlock | refactoringsViewModel afterAppliedBlock: aBlock ].
	aRefactoringsConfiguration refactoringsBlock
		ifNotNil: [ :aBlock | refactoringsViewModel refactorings: aBlock ].
	aRefactoringsConfiguration refactoringsViewModelDo
		ifNotNil: [ :aBlock | aBlock value: refactoringsViewModel ].
	aRefactoringsConfiguration showWhenCreated
		ifNotNil: [ :aBoolean | 
			aBoolean
				ifTrue: [ BlTaskAction enqueueElement: self action: [ self showPreview ] ] ]
]

{ #category : #initialization }
GtPharoRenameVariableRefactoringsPreviewElement >> initialize [
	super initialize.

	self layout: BlFrameLayout new.
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	refactoringsViewModel := GtRefactoringsViewModel new.
	previewElement := GtRefactoringsInDropdownPreviewElement new.
	previewElement refactoringsViewModel: refactoringsViewModel.
	previewElement beSize: BrSizeAdjustmentState mini.
	self addChild: previewElement
]

{ #category : #'event handling' }
GtPharoRenameVariableRefactoringsPreviewElement >> onGtPharoRenameVariableNameChanged: anAnnouncement [
	anAnnouncement variableModel = variableModel ifFalse: [ ^ self ].
	self updatePreviewElementVisibility
]

{ #category : #'event handling' }
GtPharoRenameVariableRefactoringsPreviewElement >> onGtPharoRenameVariableRefactoringsPreviewRequested: anAnnouncement [
	anAnnouncement variableModel = variableModel ifFalse: [ ^ self ].
	BlTaskAction enqueueElement: self action: [ self showPreview ]
]

{ #category : #accessing }
GtPharoRenameVariableRefactoringsPreviewElement >> previewElement [
	^ previewElement
]

{ #category : #actions }
GtPharoRenameVariableRefactoringsPreviewElement >> showPreview [
	self visibility: BlVisibility visible.
	previewElement showPreview
]

{ #category : #updating }
GtPharoRenameVariableRefactoringsPreviewElement >> updatePreviewElementVisibility [
	(variableModel isModified and: [ variableModel isValid ])
		ifTrue: [ self visibility: BlVisibility visible ]
		ifFalse: [ self visibility: BlVisibility hidden ]
]

{ #category : #accessing }
GtPharoRenameVariableRefactoringsPreviewElement >> variableModel [
	^ variableModel
]

{ #category : #accessing }
GtPharoRenameVariableRefactoringsPreviewElement >> variableModel: aVariableModel [
	"The model is assigned only once."

	self assert: [ aVariableModel isNotNil ].
	self assert: [ variableModel isNil ].

	variableModel := aVariableModel.
	self updatePreviewElementVisibility.
	variableModel announcer weak
		when: GtPharoRenameVariableNameChanged
			send: #onGtPharoRenameVariableNameChanged:
			to: self;
		when: GtPharoRenameVariableRefactoringsPreviewRequested
			send: #onGtPharoRenameVariableRefactoringsPreviewRequested:
			to: self
]
