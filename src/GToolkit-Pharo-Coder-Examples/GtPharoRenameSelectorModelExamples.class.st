Class {
	#name : #GtPharoRenameSelectorModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithOneKeywordMethod [
	<gtExample>
	| aStencil aModel |
	aModel := self renameSelectorModelWithOneKeywordMethod.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.

	^ aStencil
]

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithThreeKeywordsMethod [
	<gtExample>
	| aStencil aModel |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
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
GtPharoRenameSelectorModelExamples >> createEditorWithMethod: aMethod attributesStencil: aStencil [
	| someAttributes anEditor aDocumentId |
	aDocumentId := nil.
	someAttributes := aStencil create.
	anEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude;
			styler: BrRBTextStyler new;
			when: BrTextEditorTextReplacedEvent
				do: [ :anEvent | aDocumentId := anEvent documentId ].
	anEditor text: aMethod sourceCode.

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

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithOneKeywordMethod [
	<gtExample>
	| aMethod anEditor aStencil |
	aMethod := self oneKeywordMethod.
	aStencil := self attributesStencilWithOneKeywordMethod.
	anEditor := self createEditorWithMethod: aMethod attributesStencil: aStencil.
	^ anEditor
]

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithThreeKeywordsMethod [
	<gtExample>
	| aMethod anEditor aStencil |
	aMethod := self threeKeywordsMethod.
	aStencil := self attributesStencilWithThreeKeywordsMethod.
	anEditor := self createEditorWithMethod: aMethod attributesStencil: aStencil.
	^ anEditor
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> oneKeywordMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyOneObject >> #instA:.
	^ aMethod
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithOneKeywordMethod [
	<gtExample>
	| aModel aMethod |
	aMethod := self oneKeywordMethod.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: aMethod ast.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod [
	<gtExample>
	| aModel aMethod |
	aMethod := self threeKeywordsMethod.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: aMethod ast.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapKeywordAndParameterWithNext [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapKeywordAndParameterWithNext: 1.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapKeywordAndParameterWithPrevious [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapKeywordAndParameterWithPrevious: 3.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapParameterWithNext [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapParameterWithNext: 1.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapParameterWithPrevious [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapParameterWithPrevious: 2.
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> threeKeywordsMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyTwoObject >> #sumA:valueB:valueC:.
	^ aMethod
]
