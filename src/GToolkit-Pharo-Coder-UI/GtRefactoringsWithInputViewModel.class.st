Class {
	#name : #GtRefactoringsWithInputViewModel,
	#superclass : #GtRefactoringsViewModel,
	#instVars : [
		'initialText',
		'inputLabel',
		'inputFilter',
		'isEditorFocused',
		'currentText',
		'refactoringsWithInputComputation'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Core'
}

{ #category : #'api - converting' }
GtRefactoringsWithInputViewModel >> asPreviewElement [
	^ GtRefactoringsPreviewWithInputElement new refactoringsViewModel: self
]

{ #category : #'api - testing' }
GtRefactoringsWithInputViewModel >> canEditInput [
	"Return true if existing executed refactorings can be replaced due to input changes."

	<return: #Boolean>
	^ self canExecutedRefactoringsBeReplaced
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> currentText [
	"Return a current text that is used as input to compute
	refactorings with input."

	^ currentText ifNil: [ self initialText ]
]

{ #category : #views }
GtRefactoringsWithInputViewModel >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Input label';
					value: inputLabel.
				GtPhlowOverviewItem new
					name: 'Initial text';
					value: initialText.
				GtPhlowOverviewItem new
					name: 'Current text';
					value: self currentText.
				GtPhlowOverviewItem new
					name: 'Input filter';
					value: inputFilter.
				GtPhlowOverviewItem new
					name: 'Is input editor focused';
					boolean: isEditorFocused.
				GtPhlowOverviewItem new
					name: 'Refactorings with input computation';
					value: refactoringsWithInputComputation}
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> initialText [
	"Return an initial text that is used as a suggested input to compute
	refactoringss with input."

	<return: #String>
	^ initialText
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> initialText: aString [
	"Set an initial text that is used as a suggested input to compute
	refactoringss with input."

	initialText := aString
]

{ #category : #initialization }
GtRefactoringsWithInputViewModel >> initialize [
	super initialize.

	refactoringsWithInputComputation := [ :anInput | #() ].
	
	isPreviewButtonFocused := false.
	isEditorFocused := false.
	inputLabel := 'Input:'.
	initialText := ''.
	currentText := nil.
	inputFilter := BrTextEditorNoLineBreakInputFilter new
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> inputFilter [
	<return: #BrTextEditorInputFilter>
	^ inputFilter
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> inputFilter: anObject [
	inputFilter := anObject
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> inputLabel [
	"Return a short string that explains what input text is expected"

	<return: #String>
	^ inputLabel
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> inputLabel: aString [
	"Set a short string that explains what input text is expected"

	inputLabel := aString
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> isEditorFocused [
	<return: #Boolean>
	^ isEditorFocused
]

{ #category : #accessing }
GtRefactoringsWithInputViewModel >> isEditorFocused: anObject [
	isEditorFocused := anObject
]

{ #category : #'api - refactorings' }
GtRefactoringsWithInputViewModel >> refactoringWithInput: aBlock [
	"Set a block that returns a refactoring instance.
	The block must have one argument that is an input value, e.g., class name."
	
	self
		assert: [ aBlock numArgs = 1 ]
		description: [ 'Block must have one argument: {1}' format: {aBlock} ].

	refactoringsWithInputComputation := [ :anInput | Array with: (aBlock value: anInput) ]
]

{ #category : #'api - refactorings' }
GtRefactoringsWithInputViewModel >> refactoringsForInput: anInput [
	"Set new refactorings computation based on a given user input value.
	Return true if the new refactorings is (about to be) previewed."

	<return: #Boolean>
	| aBlockWithInput |
	currentText := anInput asString.
	aBlockWithInput := self refactoringsWithInputComputation.
	^ self refactorings: [ aBlockWithInput value: anInput ]
]

{ #category : #'api - refactorings' }
GtRefactoringsWithInputViewModel >> refactoringsWithInput: aBlock [
	"Set a block that returns a collection of refactoring instances.
	The block must have one argument that is an input value, e.g., class name."

	refactoringsWithInputComputation := aBlock
]

{ #category : #'api - refactorings' }
GtRefactoringsWithInputViewModel >> refactoringsWithInputComputation [
	<return: #BlockClosure of: #Collection of: #RBRefactoring>
	^ refactoringsWithInputComputation
]
