Class {
	#name : #GtPharoRenameSelectorModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencil [
	<gtExample>
	| aStencil aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.

	^ aStencil
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> basicRenameSelectorModel [
	<gtExample>
	| aModel |
	aModel := GtPharoRenameSelectorModel new.
	^ aModel
]

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithKeywordMethod [
	<gtExample>
	| aMethod anEditor aDocumentId someAttributes aStencil |
	aMethod := self keywordMethod.
	aStencil := self attributesStencil.
	someAttributes := aStencil create.
	anEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude;
			styler: BrRBTextStyler new;
			when: BrTextEditorTextReplacedEvent
				do: [ :anEvent | aDocumentId := anEvent documentId ].
	anEditor := anEditor text: aMethod sourceCode.

	someAttributes
		do: [ :eachCol | 
			anEditor
				addAttribute: (eachCol at: 3)
				overRange: (BrTextCharacterRange
						start: (eachCol at: 1)
						end: (eachCol at: 2)
						documentId: aDocumentId) ].

	anEditor userData at: #electorModel put: aStencil selectorModel.

	^ anEditor
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> keywordMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyTwoObject >> #sumA:valueB:valueC:.
	^ aMethod
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod [
	<gtExample>
	| aModel aMethod |
	aMethod := self keywordMethod.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: aMethod ast.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod_swapKeywordAndParameterWithNext [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aModel swapKeywordAndParameterWithNext: 1.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod_swapKeywordAndParameterWithPrevious [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aModel swapKeywordAndParameterWithPrevious: 3.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod_swapParameterWithNext [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aModel swapParameterWithNext: 1.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod_swapParameterWithPrevious [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aModel swapParameterWithPrevious: 2.
	^ aModel
]
