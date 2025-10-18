Class {
	#name : #GtRefactoringsWithInputWidgetViewModel,
	#superclass : #GtRefactoringsViewModel,
	#instVars : [
		'refactoringsWithInputComputation',
		'refactoringsWithConfirmationComputation',
		'inputElementStencil'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Core'
}

{ #category : #'api - converting' }
GtRefactoringsWithInputWidgetViewModel >> asPreviewElement [
	^ GtRefactoringsPreviewWithInputWidgetElement new refactoringsViewModel: self
]

{ #category : #initialization }
GtRefactoringsWithInputWidgetViewModel >> defaultExecutedRefactorings [
	^ super defaultExecutedRefactorings
		beDisabled;
		yourself
]

{ #category : #views }
GtRefactoringsWithInputWidgetViewModel >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Refactorings with confirmation computation';
					value: refactoringsWithConfirmationComputation.
				GtPhlowOverviewItem new
					name: 'Input element stencil builder';
					value: inputElementStencil}
]

{ #category : #initialization }
GtRefactoringsWithInputWidgetViewModel >> initialize [
	super initialize.

	refactoringsWithConfirmationComputation := [ #() ].
	inputElementStencil := GtRefactoringsInputWidgetStencilBuilder new
]

{ #category : #accessing }
GtRefactoringsWithInputWidgetViewModel >> inputElement [
	<return: #BlElement or: nil>
	^ inputElementStencil
		refactoringsViewModel: self;
		build
]

{ #category : #accessing }
GtRefactoringsWithInputWidgetViewModel >> inputElement: aStencilBuilder [
	"Input element stencil builder creates elements.
	It can also return `nil` instead of a BlElement instance.
	The stencil builder can be a block with one argument [ :aRefactoringsViewModel | ]."

	inputElementStencil = aStencilBuilder ifTrue: [ ^ self ].

	inputElementStencil := aStencilBuilder
			asStencilBuilder: GtRefactoringsInputWidgetStencilBuilder.
	self notifyInputElementChanged
]

{ #category : #accessing }
GtRefactoringsWithInputWidgetViewModel >> inputElementStencil [
	<return: #GtRefactoringsInputWidgetStencilBuilder>
	^ inputElementStencil
]

{ #category : #'api - refactorings' }
GtRefactoringsWithInputWidgetViewModel >> inputReady [
	"Set new refactorings computation.
	Return true if the new refactorings is (about to be) previewed."

	<return: #Boolean>
	| aComputedBlock |
	aComputedBlock := self refactoringsWithConfirmationComputation.
	^ self refactorings: aComputedBlock
]

{ #category : #'private - notifying' }
GtRefactoringsWithInputWidgetViewModel >> notifyInputElementChanged [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelInputElementChanged new
			refactoringsViewModel: self;
			inputElementStencil: self inputElementStencil.

	self announce: anAnnouncement
]

{ #category : #'api - refactorings' }
GtRefactoringsWithInputWidgetViewModel >> refactoringWithConfirmation: aBlock [
	"Set a block that returns a refactoring instance.
	The block must have zero arguments."

	self
		assert: [ aBlock numArgs = 0 ]
		description: [ 'Block must have zero arguments: {1}' format: {aBlock} ].
	
	refactoringsWithConfirmationComputation := [ Array with: aBlock value ]
]

{ #category : #'api - refactorings' }
GtRefactoringsWithInputWidgetViewModel >> refactoringsWithConfirmation: aBlock [
	"Set a block that returns a collection of refactoring instances.
	The block must have zero arguments."
	
	self
		assert: [ aBlock numArgs = 0 ]
		description: [ 'Block must have zero arguments: {1}' format: {aBlock} ].
	
	refactoringsWithConfirmationComputation := aBlock
]

{ #category : #'api - refactorings' }
GtRefactoringsWithInputWidgetViewModel >> refactoringsWithConfirmationComputation [
	<return: #BlockClosure of: #Collection of: #RBRefactoring>
	^ refactoringsWithConfirmationComputation
]
