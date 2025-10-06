Class {
	#name : #GtRefactoringsWithConfirmationViewModel,
	#superclass : #GtRefactoringsViewModel,
	#instVars : [
		'confirmationLabel',
		'refactoringsWithConfirmationComputation'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Core'
}

{ #category : #'api - refactorings' }
GtRefactoringsWithConfirmationViewModel >> confirmRefactorings [
	"Set new refactorings computation.
	Return true if the new refactorings is (about to be) previewed."

	<return: #Boolean>
	| aConfirmedBlock |
	aConfirmedBlock := self refactoringsWithConfirmationComputation.
	^ self refactorings: aConfirmedBlock
]

{ #category : #accessing }
GtRefactoringsWithConfirmationViewModel >> confirmationLabel [
	<return: #String>
	^ confirmationLabel
]

{ #category : #accessing }
GtRefactoringsWithConfirmationViewModel >> confirmationLabel: aString [
	confirmationLabel := aString
]

{ #category : #views }
GtRefactoringsWithConfirmationViewModel >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Confirmation label';
					value: confirmationLabel.
				GtPhlowOverviewItem new
					name: 'Refactorings with input computation';
					value: refactoringsWithConfirmationComputation}
]

{ #category : #initialization }
GtRefactoringsWithConfirmationViewModel >> initialize [
	super initialize.

	refactoringsWithConfirmationComputation := [ #() ].

	isPreviewButtonFocused := true.
	confirmationLabel := 'Confirm'
]

{ #category : #'api - refactorings' }
GtRefactoringsWithConfirmationViewModel >> refactoringWithConfirmation: aBlock [
	"Set a block that returns a refactoring instance.
	The block must have zero arguments."

	self
		assert: [ aBlock numArgs = 0 ]
		description: [ 'Block must have zero arguments: {1}' format: {aBlock} ].

	refactoringsWithConfirmationComputation := [ Array with: aBlock value ]
]

{ #category : #'api - refactorings' }
GtRefactoringsWithConfirmationViewModel >> refactoringsWithConfirmation: aBlock [
	"Set a block that returns a collection of refactoring instances.
	The block must have zero arguments."
	
	self
		assert: [ aBlock numArgs = 0 ]
		description: [ 'Block must have zero arguments: {1}' format: {aBlock} ].

	refactoringsWithConfirmationComputation := aBlock
]

{ #category : #'api - refactorings' }
GtRefactoringsWithConfirmationViewModel >> refactoringsWithConfirmationComputation [
	<return: #BlockClosure of: #Collection of: #RBRefactoring>
	^ refactoringsWithConfirmationComputation
]
