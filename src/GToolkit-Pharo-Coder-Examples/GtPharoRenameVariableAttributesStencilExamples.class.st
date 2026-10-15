Class {
	#name : #GtPharoRenameVariableAttributesStencilExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenameVariableAttributesStencilExamples >> attributesCreateElements [
	<gtExample>
	<return: #GtPharoRenameVariableAttributesStencil>
	| aStencil allAttributes anEditorElement |
	aStencil := self attributesForThreeOccurrences.
	allAttributes := aStencil create.
	anEditorElement := BrEditor new.

	self
		assert: ((allAttributes at: 1) third doAffect: nil in: anEditorElement) first class
		equals: GtPharoRenameVariableEditorElement.
	self
		assert: ((allAttributes at: 2) third doAffect: nil in: anEditorElement) first class
		equals: GtPharoRenameVariableOccurrenceElement.
	self
		assert: ((allAttributes at: 3) third doAffect: nil in: anEditorElement) first class
		equals: GtPharoRenameVariableOccurrenceElement.
	self
		assert: ((allAttributes at: 4) third doAffect: nil in: anEditorElement) first class
		equals: GtPharoRenameVariableRefactoringsPreviewElement.
	^ aStencil
]

{ #category : #examples }
GtPharoRenameVariableAttributesStencilExamples >> attributesForSingleOccurrence [
	<gtExample>
	<return: #GtPharoRenameVariableAttributesStencil>
	| aModel aStencil allAttributes |
	aModel := GtPharoRenameVariableModel originalName: 'x' intervals: {3 to: 3}.
	aStencil := GtPharoRenameVariableAttributesStencil new variableModel: aModel.
	allAttributes := aStencil create.
	self assert: allAttributes size equals: 2.
	self assert: allAttributes first third shouldReplace.
	self assert: allAttributes second third shouldAppend.
	^ aStencil
]

{ #category : #examples }
GtPharoRenameVariableAttributesStencilExamples >> attributesForThreeOccurrences [
	<gtExample>
	<return: #GtPharoRenameVariableAttributesStencil>
	| aModel aStencil allAttributes |
	aModel := GtPharoRenameVariableModelExamples new modelWithThreeOccurrences.
	aStencil := GtPharoRenameVariableAttributesStencil new variableModel: aModel.
	allAttributes := aStencil create.

	self assert: allAttributes size equals: 4.
	allAttributes do: [ :each | 
		self assert: each third class equals: BrTextAdornmentDynamicAttribute.
		self assert: each third isOverwritableByStyler not ].

	self assert: (allAttributes at: 1) first equals: 5.
	self assert: (allAttributes at: 1) second equals: 9.
	self assert: (allAttributes at: 1) third shouldReplace.
	self assert: (allAttributes at: 2) first equals: 20.
	self assert: (allAttributes at: 2) second equals: 24.
	self assert: (allAttributes at: 2) third shouldReplace.
	self assert: (allAttributes at: 3) first equals: 30.
	self assert: (allAttributes at: 3) second equals: 34.
	self assert: (allAttributes at: 3) third shouldReplace.
	self assert: (allAttributes at: 4) first equals: 9.
	self assert: (allAttributes at: 4) second equals: 9.
	self assert: (allAttributes at: 4) third shouldAppend.
	^ aStencil
]
