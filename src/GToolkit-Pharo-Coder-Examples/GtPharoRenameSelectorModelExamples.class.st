Class {
	#name : #GtPharoRenameSelectorModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithBinaryMethod [
	<gtExample>
	| aStencil aModel |
	aModel := self renameSelectorModelWithBinaryMethod.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.

	^ aStencil
]

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

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithUnaryMethod [
	<gtExample>
	| aStencil aModel |
	aModel := self renameSelectorModelWithUnaryMethod.
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

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> binaryMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyOneObject >> #*.
	^ aMethod
]

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> createEditorWithMethod: aMethod attributesStencil: aStencil [
	| someAttributes anEditor aDocumentId aController |
	aDocumentId := nil.
	someAttributes := aStencil create.
	anEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude;
			styler: BrRBTextStyler new;
			when: BrTextEditorTextReplacedEvent
				do: [ :anEvent | aDocumentId := anEvent documentId ].
	anEditor text: aMethod sourceCode.

	aController := GtPharoRenameSelectorCoderController new
			originalNode: aMethod ast;
			editorElement: anEditor;
			sourceCoderViewModel: (GtPharoMethodCoder forMethod: aMethod) asCoderViewModel;
			install.

	anEditor userData at: #selectorModel put: aStencil selectorModel.
	anEditor userData at: #selectorController put: aController.

	^ anEditor
]

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithBinaryMethod [
	<gtExample>
	| aMethod anEditor aStencil |
	aMethod := self binaryMethod.
	aStencil := self attributesStencilWithBinaryMethod.
	anEditor := self createEditorWithMethod: aMethod attributesStencil: aStencil.
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

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithUnaryMethod [
	<gtExample>
	| aMethod anEditor aStencil |
	aMethod := self unaryMethod.
	aStencil := self attributesStencilWithUnaryMethod.
	anEditor := self createEditorWithMethod: aMethod attributesStencil: aStencil.
	^ anEditor
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> oneKeywordMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyOneObject >> #instA:.
	^ aMethod
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithBinaryMethod [
	<gtExample>
	| aModel aMethod |
	aMethod := self binaryMethod.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: aMethod ast.
	
	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(1).
	
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithOneKeywordMethod [
	<gtExample>
	| aModel aMethod |
	aMethod := self oneKeywordMethod.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: aMethod ast.
	
	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(1).
	
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod [
	<gtExample>
	| aModel aMethod |
	aMethod := self threeKeywordsMethod.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: aMethod ast.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: (1 to: 3).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapKeywordAndParameterWithNext [
	<gtExample>
	| aMethod aModel |
	aMethod := self threeKeywordsMethod.
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapKeywordAndParameterWithNext: 1.

	self assert: aModel isModified.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: #valueB:sumA:valueC:.
	self assert: aModel currentParameterPermutations equals: #(2 1 3).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapKeywordAndParameterWithPrevious [
	<gtExample>
	| aMethod aModel |
	aMethod := self threeKeywordsMethod.
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapKeywordAndParameterWithPrevious: 3.

	self assert: aModel isModified.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: #sumA:valueC:valueB:.
	self assert: aModel currentParameterPermutations equals: #(1 3 2).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapParameterWithNext [
	<gtExample>
	| aMethod aModel |
	aMethod := self threeKeywordsMethod.
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapParameterWithNext: 1.
	
	self assert: aModel isModified.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(2 1 3).
	
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapParameterWithPrevious [
	<gtExample>
	| aMethod aModel |
	aMethod := self threeKeywordsMethod.
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapParameterWithPrevious: 2.
	
	self assert: aModel isModified.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(2 1 3).
	
	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithUnaryMethod [
	<gtExample>
	| aModel aMethod |
	aMethod := self unaryMethod.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: aMethod ast.
	
	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #().
	
	^ aModel
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> threeKeywordsMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyTwoObject >> #sumA:valueB:valueC:.
	^ aMethod
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> unaryMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyOneObject >> #instAReceiver.
	^ aMethod
]
