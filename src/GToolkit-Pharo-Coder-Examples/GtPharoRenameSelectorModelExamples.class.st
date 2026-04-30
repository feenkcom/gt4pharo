Class {
	#name : #GtPharoRenameSelectorModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #asserting }
GtPharoRenameSelectorModelExamples >> assert: aScripter onlyOneEditorMode: anElementId [
	| aModel aBasicId anEditorModeIndex |
	self assert: [ anElementId isIndexed ].
	aModel := aScripter model.
	aBasicId := anElementId prefixId.
	anEditorModeIndex := anElementId index.

	aScripter
		substeps: ('Assert only editor at index {1} is in editable mode'
				format: {anEditorModeIndex})
		do: [ :aStep | 
			aModel selectorParts
				withIndexDo: [ :eachPart :eachIndex | 
					aStep assert
						label: ('Assert selector part editor is {1} at index {2}'
								format: {eachIndex = anEditorModeIndex
											ifTrue: [ 'in editable mode' ]
											ifFalse: [ 'in label mode' ].
										eachIndex});
						satisfies: [ :anEditor | 
							eachIndex = anEditorModeIndex
								ifTrue: [ anEditor viewModel mode isEditable ]
								ifFalse: [ anEditor viewModel mode isEditable not ] ];
						// (aBasicId asBlocElementId indexed: eachIndex);
						/ #editorElement;
						play ] ]
]

{ #category : #asserting }
GtPharoRenameSelectorModelExamples >> assert: aScripter refactoringsPreviewIsVisible: aBoolean [
	aScripter assert
		label: ('Assert refactorings preview is {1}'
				format: {aBoolean ifTrue: [ 'visible' ] ifFalse: [ 'hidden' ]});
		satisfies: [ :anElement | 
			aBoolean
				ifTrue: [ anElement visibility isVisible ]
				ifFalse: [ anElement visibility isHidden ] ];
		/ #'selector-refactorings-preview';
		play
]

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> assertThreeKeywordsSelectorForStencil: aStencil [
	| allAttributes |
	allAttributes := aStencil create.
	self assert: allAttributes size equals: 15.
	self
		assert: (allAttributes at: 1) third class
		equals: GtPharoRenameSelectorPartEditorAttribute.
	self
		assert: (allAttributes at: 2) third class
		equals: GtPharoRenameSelectorParameterLabelAttribute.
	self
		assert: (allAttributes at: 3) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 4) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 5) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 6) third class
		equals: GtPharoRenameSelectorPartEditorAttribute.
	self
		assert: (allAttributes at: 7) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 8) third class
		equals: GtPharoRenameSelectorParameterLabelAttribute.
	self
		assert: (allAttributes at: 9) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 10) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 11) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 12) third class
		equals: GtPharoRenameSelectorPartEditorAttribute.
	self
		assert: (allAttributes at: 13) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 14) third class
		equals: GtPharoRenameSelectorParameterLabelAttribute.
	self
		assert: (allAttributes at: 15) third class
		equals: GtPharoRenameSelectorRefactoringsPreviewAttribute
]

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithBinaryMethod [
	<gtExample>
	| aStencil aModel allAttributes |
	aModel := self renameSelectorModelWithBinaryMethod.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.
	
	allAttributes := aStencil create.
	self assert: allAttributes size equals: 2.
	self assert: allAttributes first third class equals: GtPharoRenameSelectorPartEditorAttribute.
	self assert: allAttributes second third class equals: GtPharoRenameSelectorRefactoringsPreviewAttribute.

	^ aStencil
]

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithKeywordMessageNode [
	<gtExample>
	| aStencil aModel allAttributes |
	aModel := self renameSelectorModelWithKeywordMessageNode.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.

	allAttributes := aStencil create.
	self assert: allAttributes size equals: 9.
	self
		assert: (allAttributes at: 1) third class
		equals: GtPharoRenameSelectorPartEditorAttribute.
	self
		assert: (allAttributes at: 2) third class
		equals: GtPharoRenameSelectorParameterLabelAttribute.
	self
		assert: (allAttributes at: 3) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 4) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 5) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 6) third class
		equals: GtPharoRenameSelectorPartEditorAttribute.
	self
		assert: (allAttributes at: 7) third class
		equals: GtPharoRenameSelectorSwapButtonAttribute.
	self
		assert: (allAttributes at: 8) third class
		equals: GtPharoRenameSelectorParameterLabelAttribute.
	self
		assert: (allAttributes at: 9) third class
		equals: GtPharoRenameSelectorRefactoringsPreviewAttribute.

	^ aStencil
]

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithOneKeywordMethod [
	<gtExample>
	| aStencil aModel allAttributes |
	aModel := self renameSelectorModelWithOneKeywordMethod.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.

	allAttributes := aStencil create.
	self assert: allAttributes size equals: 2.
	self
		assert: allAttributes first third class
		equals: GtPharoRenameSelectorPartEditorAttribute.
	self
		assert: allAttributes second third class
		equals: GtPharoRenameSelectorRefactoringsPreviewAttribute.

	^ aStencil
]

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithThreeKeywordsMethod [
	<gtExample>
	| aStencil aModel |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.
	self assertThreeKeywordsSelectorForStencil: aStencil.
	^ aStencil
]

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithThreeKeywordsMethodPatternNode [
	<gtExample>
	| aStencil aModel |
	aModel := self renameSelectorModelWithThreeMessageKeywordsMethodPatternNode.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.
	self assertThreeKeywordsSelectorForStencil: aStencil.

	^ aStencil
]

{ #category : #'examples - attributes' }
GtPharoRenameSelectorModelExamples >> attributesStencilWithUnaryMethod [
	<gtExample>
	| aStencil aModel allAttributes |
	aModel := self renameSelectorModelWithUnaryMethod.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.

	allAttributes := aStencil create.
	self assert: allAttributes size equals: 2.
	self
		assert: allAttributes first third class
		equals: GtPharoRenameSelectorPartEditorAttribute.
	self
		assert: allAttributes second third class
		equals: GtPharoRenameSelectorRefactoringsPreviewAttribute.

	^ aStencil
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> basicRenameSelectorModel [
	<gtExample>
	| aModel |
	aModel := GtPharoRenameSelectorModel new.
	^ aModel
]

{ #category : #'examples - elements' }
GtPharoRenameSelectorModelExamples >> basicSelectorParameterElement [
	<gtExample>
	| anElement |
	anElement := GtPharoRenameSelectorParameterElement new.

	^ anElement
]

{ #category : #'examples - elements' }
GtPharoRenameSelectorModelExamples >> basicSelectorPartElement [
	<gtExample>
	| anElement |
	anElement := GtPharoRenameSelectorPartElement new.

	^ anElement
]

{ #category : #'examples - elements' }
GtPharoRenameSelectorModelExamples >> basicSelectorRefactoringsPreviewElement [
	<gtExample>
	| anElement |
	anElement := GtPharoRenameSelectorRefactoringsPreviewElement new.

	^ anElement
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> binaryMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyOneObject >> #*.
	^ aMethod
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> binaryMethodAst [
	<gtExample>
	^ self parseMethod: self binaryMethod
]

{ #category : #'examples - brick editor' }
GtPharoRenameSelectorModelExamples >> createEditorWithMethod: aMethod [
	| anEditor aDocumentId aController aCoder anAst aCoderViewModel |
	aDocumentId := nil.
	aCoder := GtPharoMethodCoder forMethod: aMethod.
	anAst := aCoder astSync.
	aCoderViewModel := aCoder asCoderViewModel.

	anEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude;
			styler: (GtPharoStyler new coderViewModel: aCoderViewModel);
			when: BrTextEditorTextReplacedEvent
				do: [ :anEvent | aDocumentId := anEvent documentId ].
	anEditor text: aMethod sourceCode.

	aController := GtPharoRenameSelectorCoderController new
			originalNode: anAst;
			editorElement: anEditor;
			documentId: aDocumentId;
			sourceCoderViewModel: aCoderViewModel;
			install.

	^ anEditor
]

{ #category : #'examples - elements' }
GtPharoRenameSelectorModelExamples >> createElementsFromAttributesStencil: aStencil [
	| aContainer aModel allAttributes |
	aModel := aStencil selectorModel.
	allAttributes := aStencil create.

	aContainer := BrHorizontalPane new
			cellSpacing: 5;
			padding: (BlInsets all: 10);
			alignCenterLeft;
			fitContent.

	allAttributes
		withIndexDo: [ :eachAttribute :eachIndex | 
			| someElements |
			someElements := (eachAttribute third doAffect: nil in: nil) asCollection.
			aContainer addChildren: someElements ].

	aContainer userData at: #selectorModel put: aModel.
	^ aContainer
]

{ #category : #'examples - rust editor' }
GtPharoRenameSelectorModelExamples >> createRustEditorWithMethod: aMethod [
	| anEditor aDocumentId aController aCoder anAst aCoderViewModel |
	aDocumentId := nil.
	aCoder := GtPharoMethodCoder forMethod: aMethod.
	anAst := aCoder astSync.
	aCoderViewModel := aCoder asCoderViewModel.

	anEditor := GtTextEditorElement new
			defaultFontName: 'Source Code Pro';
			defaultFontSize: 14;
			defaultForeground: Color black;
			in: [ :theEditor | theEditor privateEditorHandle enableInMemoryCommandsRecorder ];
			when: BrTextEditorModifiedEvent
				do: [ :anEvent | aDocumentId := anEvent documentId ];
			styler: (GtPharoStyler new coderViewModel: aCoderViewModel);
			when: BrTextStyledEvent
				doOnce: [ :anEvent | 
					BlTaskAction
						enqueueElement: anEditor
						action: [ aController := GtPharoRenameSelectorCoderController new
									originalNode: anAst;
									editorElement: anEditor;
									sourceCoderViewModel: aCoderViewModel;
									install ] ];
			matchParent;
			yourself.

	anEditor text: aMethod sourceCode.

	anEditor userData at: #selectorController put: aController.

	^ anEditor
]

{ #category : #'examples - brick editor' }
GtPharoRenameSelectorModelExamples >> editorWithBinaryMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self binaryMethod.
	anEditor := self createEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - brick editor' }
GtPharoRenameSelectorModelExamples >> editorWithOneKeywordMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self oneKeywordMethod.
	anEditor := self createEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - brick editor' }
GtPharoRenameSelectorModelExamples >> editorWithThreeKeywordsMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self threeKeywordsMethod.
	anEditor := self createEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - brick editor' }
GtPharoRenameSelectorModelExamples >> editorWithUnaryMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self unaryMethod.
	anEditor := self createEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - rust editor' }
GtPharoRenameSelectorModelExamples >> ifLibEditorIsMissingDo: aBlock [
	GtTextEditorLibrary uniqueInstance libraryName asFileReference exists
		ifFalse: [ ^ aBlock value ].
	^ nil
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> oneKeywordMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyOneObject >> #instA:.
	^ aMethod
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> oneKeywordMethodAst [
	<gtExample>
	^ self parseMethod: self oneKeywordMethod
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> parseMethod: aMethod [
	<gtExample>
	| anAst |
	anAst := GtPharoIncrementalParser parse: aMethod sourceCode.
	^ anAst
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithBinaryMethod [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self binaryMethod.
	anAst := self binaryMethodAst.
	aModel := GtPharoRenameSelectorModel forAstNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(1).

	self assert: (aModel selectorParts at: 1) currentName equals: '*'.
	self assert: (aModel selectorParts at: 1) currentDisplayName equals: '*'.
	self assert: (aModel selectorParts at: 1) isMustBeKeyword not.

	self assert: (aModel parameters at: 1) currentName equals: 'anObject'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithBinaryMethod_updateToBinary [
	<gtExample>
	| aModel aSelectorPart |
	aModel := self renameSelectorModelWithBinaryMethod.

	aSelectorPart := aModel selectorParts at: 1.
	aSelectorPart updateCurrentName: '**' source: self.
	self assert: aSelectorPart currentName equals: '**'.
	self assert: aSelectorPart currentDisplayName equals: '**'.
	self assert: aSelectorPart isValid.
	self assert: aSelectorPart isModified.

	self assert: aModel isModified.
	self assert: aModel isValid.
	self assert: aModel currentSelector equals: #**.
	self assert: aModel currentParameterPermutations equals: #(1).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithBinaryMethod_updateToEmpty [
	<gtExample>
	| aModel aSelectorPart |
	aModel := self renameSelectorModelWithBinaryMethod.

	aSelectorPart := aModel selectorParts at: 1.
	aSelectorPart updateCurrentName: '' source: self.
	self assert: aSelectorPart currentName equals: ''.
	self assert: aSelectorPart currentDisplayName equals: ''.
	self assert: aSelectorPart isValid not.
	self assert: aSelectorPart isModified.

	self assert: aModel isModified.
	self assert: aModel isValid not.
	self assert: aModel currentSelector equals: #''.
	self assert: aModel currentParameterPermutations equals: #(1).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithBinaryMethod_updateToInvalid [
	<gtExample>
	| aModel aSelectorPart |
	aModel := self renameSelectorModelWithBinaryMethod.

	aSelectorPart := aModel selectorParts at: 1.
	aSelectorPart updateCurrentName: '*a' source: self.
	self assert: aSelectorPart currentName equals: '*a'.
	self assert: aSelectorPart currentDisplayName equals: '*a'.
	self assert: aSelectorPart isValid not.
	self assert: aSelectorPart isModified.

	self assert: aModel isModified.
	self assert: aModel isValid not.
	self assert: aModel currentSelector equals: #'*a'.
	self assert: aModel currentParameterPermutations equals: #(1).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithBinaryMethod_updateToKeyword [
	<gtExample>
	| aModel aSelectorPart |
	aModel := self renameSelectorModelWithBinaryMethod.

	aSelectorPart := aModel selectorParts at: 1.
	aSelectorPart updateCurrentName: 'a' source: self.
	self assert: aSelectorPart currentName equals: 'a:'.
	self assert: aSelectorPart currentDisplayName equals: 'a'.
	self assert: aSelectorPart isValid.
	self assert: aSelectorPart isModified.

	self assert: aModel isModified.
	self assert: aModel isValid.
	self assert: aModel currentSelector equals: #a:.
	self assert: aModel currentParameterPermutations equals: #(1).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithBinaryMethod_updateToKeyword_toBinary [
	<gtExample>
	| aModel aSelectorPart |
	aModel := self renameSelectorModelWithBinaryMethod_updateToKeyword.

	aSelectorPart := aModel selectorParts at: 1.
	aSelectorPart updateCurrentName: '**' source: self.
	self assert: aSelectorPart currentName equals: '**'.
	self assert: aSelectorPart currentDisplayName equals: '**'.
	self assert: aSelectorPart isValid.
	self assert: aSelectorPart isModified.

	self assert: aModel isModified.
	self assert: aModel isValid.
	self assert: aModel currentSelector equals: #**.
	self assert: aModel currentParameterPermutations equals: #(1).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMessageNode [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self threeKeywordsMethod.
	anAst := self threeKeywordsMethodKeywordMessageAst.
	aModel := GtPharoRenameSelectorModel forAstNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: anAst selector.
	self assert: aModel currentSelector equals: anAst selector.
	self assert: aModel currentParameterPermutations equals: (1 to: 2).

	self assert: (aModel selectorParts at: 1) currentName equals: 'sumA:'.
	self assert: (aModel selectorParts at: 1) currentDisplayName equals: 'sumA'.
	self assert: (aModel selectorParts at: 1) isMustBeKeyword.

	self assert: (aModel parameters at: 1) currentName equals: 'valueA'.

	self assert: (aModel selectorParts at: 2) currentName equals: 'b:'.
	self assert: (aModel selectorParts at: 2) currentDisplayName equals: 'b'.
	self assert: (aModel selectorParts at: 2) isMustBeKeyword.

	self assert: (aModel parameters at: 2) currentName equals: 'valueB'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMessageNode_updateToEmpty [
	<gtExample>
	| aModel aPartOne |
	aModel := self renameSelectorModelWithKeywordMessageNode.

	aPartOne := aModel selectorParts at: 1.
	aPartOne updateCurrentName: '' source: self.

	self assert: aPartOne isValid not.
	self assert: aPartOne isModified.
	self assert: aPartOne currentName equals: ''.
	self assert: aPartOne currentDisplayName equals: ''.
	self assert: aPartOne isModified.
	self assert: aPartOne isValid not.

	self assert: aModel isModified.
	self assert: aModel isValid not.
	self assert: aModel currentSelector equals: #'b:'.
	self assert: aModel currentParameterPermutations equals: (1 to: 2).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMessageNode_updateToInvalid [
	<gtExample>
	| aModel aPartOne |
	aModel := self renameSelectorModelWithKeywordMessageNode.

	aPartOne := aModel selectorParts at: 1.
	aPartOne updateCurrentName: '*' source: self.

	self assert: aPartOne isValid not.
	self assert: aPartOne isModified.
	self assert: aPartOne currentName equals: '*'.
	self assert: aPartOne currentDisplayName equals: '*'.
	self assert: aPartOne isModified.
	self assert: aPartOne isValid not.

	self assert: aModel isModified.
	self assert: aModel isValid not.
	self assert: aModel currentSelector equals: #'*b:'.
	self assert: aModel currentParameterPermutations equals: (1 to: 2).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithOneKeywordMethod [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self oneKeywordMethod.
	anAst := self oneKeywordMethodAst.
	aModel := GtPharoRenameSelectorModel forAstNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(1).

	self assert: (aModel selectorParts at: 1) currentName equals: 'instA:'.
	self assert: (aModel selectorParts at: 1) currentDisplayName equals: 'instA'.
	self assert: (aModel selectorParts at: 1) isMustBeKeyword not.

	self assert: (aModel parameters at: 1) currentName equals: 'anObject'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithOneKeywordMethod_updateToBinary [
	<gtExample>
	| aModel aPartOne |
	aModel := self renameSelectorModelWithOneKeywordMethod.

	aPartOne := aModel selectorParts at: 1.
	aPartOne updateCurrentName: '*' source: self.

	self assert: aPartOne currentName equals: '*'.
	self assert: aPartOne currentDisplayName equals: '*'.
	self assert: aPartOne isValid.
	self assert: aPartOne isModified.

	self assert: aModel isModified.
	self assert: aModel isValid.
	self assert: aModel currentSelector equals: #*.
	self assert: aModel currentParameterPermutations equals: #(1).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self threeKeywordsMethod.
	anAst := self threeKeywordsMethodAst.
	aModel := GtPharoRenameSelectorModel forAstNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: (1 to: 3).

	self assert: (aModel selectorParts at: 1) currentName equals: 'sumA:'.
	self assert: (aModel selectorParts at: 1) currentDisplayName equals: 'sumA'.
	self assert: (aModel selectorParts at: 1) isMustBeKeyword.

	self assert: (aModel parameters at: 1) currentName equals: 'valueA'.

	self assert: (aModel selectorParts at: 2) currentName equals: 'valueB:'.
	self assert: (aModel selectorParts at: 2) currentDisplayName equals: 'valueB'.
	self assert: (aModel selectorParts at: 2) isMustBeKeyword.

	self assert: (aModel parameters at: 2) currentName equals: 'valueB'.

	self assert: (aModel selectorParts at: 3) currentName equals: 'valueC:'.
	self assert: (aModel selectorParts at: 3) currentDisplayName equals: 'valueC'.
	self assert: (aModel selectorParts at: 3) isMustBeKeyword.

	self assert: (aModel parameters at: 3) currentName equals: 'valueC'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_swapKeywordAndParameterWithNext [
	<gtExample>
	| aMethod aModel |
	aMethod := self threeKeywordsMethod.
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aModel swapSelectorPartAndParameterWithNext: 1 source: self.

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
	aModel swapSelectorPartAndParameterWithPrevious: 3 source: self.

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
	aModel swapParameterWithNext: 1 source: self.

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
	aModel swapParameterWithPrevious: 2 source: self.

	self assert: aModel isModified.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(2 1 3).

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_updateToEmpty [
	<gtExample>
	| aModel aPartTwo |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.

	aPartTwo := aModel selectorParts at: 2.
	aPartTwo updateCurrentName: '' source: self.

	self assert: aPartTwo currentName equals: ''.
	self assert: aPartTwo currentDisplayName equals: ''.
	self assert: aPartTwo isValid not.
	self assert: aPartTwo isModified.

	self assert: aModel isModified.
	self assert: aModel isValid not.
	self assert: aModel currentSelector equals: #'sumA:valueC:'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod_updateToInvalid [
	<gtExample>
	| aModel aPartTwo |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.

	aPartTwo := aModel selectorParts at: 2.
	aPartTwo updateCurrentName: '**' source: self.

	self assert: aPartTwo currentName equals: '**'.
	self assert: aPartTwo currentDisplayName equals: '**'.
	self assert: aPartTwo isValid not.
	self assert: aPartTwo isModified.

	self assert: aModel isModified.
	self assert: aModel isValid not.
	self assert: aModel currentSelector equals: #'sumA:**valueC:'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeMessageKeywordsMethodPatternNode [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self threeKeywordsMethod.
	anAst := self threeKeywordsMethodPatternAst.
	aModel := GtPharoRenameSelectorModel forAstNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: (1 to: 3).

	self assert: (aModel selectorParts at: 1) currentName equals: 'sumA:'.
	self assert: (aModel parameters at: 1) currentName equals: 'valueA'.
	self assert: (aModel selectorParts at: 2) currentName equals: 'valueB:'.
	self assert: (aModel parameters at: 2) currentName equals: 'valueB'.
	self assert: (aModel selectorParts at: 3) currentName equals: 'valueC:'.
	self assert: (aModel parameters at: 3) currentName equals: 'valueC'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithUnaryMethod [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self unaryMethod.
	anAst := self unaryMethodAst.
	aModel := GtPharoRenameSelectorModel forAstNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #().

	self assert: (aModel selectorParts at: 1) currentName equals: 'instAReceiver'.
	self assert: (aModel selectorParts at: 1) currentDisplayName equals: 'instAReceiver'.
	self assert: (aModel selectorParts at: 1) isMustBeKeyword not.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithUnaryMethod_updateToEmpty [
	<gtExample>
	| aModel aPartOne |
	aModel := self renameSelectorModelWithUnaryMethod.

	aPartOne := aModel selectorParts at: 1.
	aPartOne updateCurrentName: '' source: self.

	self assert: aPartOne currentName equals: ''.
	self assert: aPartOne currentDisplayName equals: ''.
	self assert: aPartOne isValid not.
	self assert: aPartOne isModified.

	self assert: aModel isModified.
	self assert: aModel isValid not.
	self assert: aModel currentSelector equals: #''.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithUnaryMethod_updateToInvalid [
	<gtExample>
	| aModel aPartOne |
	aModel := self renameSelectorModelWithUnaryMethod.

	aPartOne := aModel selectorParts at: 1.
	aPartOne updateCurrentName: '*a' source: self.

	self assert: aPartOne currentName equals: '*a'.
	self assert: aPartOne currentDisplayName equals: '*a'.
	self assert: aPartOne isValid not.
	self assert: aPartOne isModified.

	self assert: aModel isModified.
	self assert: aModel isValid not.
	self assert: aModel currentSelector equals: #'*a'.

	^ aModel
]

{ #category : #'examples - rust editor' }
GtPharoRenameSelectorModelExamples >> rustEditorWithThreeKeywordsMethod [
	<gtExample>
	| aMethod anEditor |
	self ifLibEditorIsMissingDo: [ ^ nil ].
	
	aMethod := self threeKeywordsMethod.
	anEditor := self createRustEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelExamples >> rustScripterEditorWithThreeKeywordsMethod [
	<gtExample>
	<noTest>
	| anElement aScripter aModel |
	self ifLibEditorIsMissingDo: [ ^ nil ].
	anElement := self rustEditorWithThreeKeywordsMethod.
	aScripter := BlScripter new element: anElement.
	aModel := anElement userData at: #selectorModel.
	aScripter := BlScripter new
			model: aModel;
			element: anElement.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod [
	<gtExample>
	<noTest>
	| anElement aScripter aModel |
	self ifLibEditorIsMissingDo: [ ^ nil ].
	anElement := self selectorPartElementsWithFirstThreeKeywordsMethod.
	aModel := anElement userData at: #selectorModel.
	aScripter := BlScripter new
			model: aModel;
			element: anElement.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_downAndUpArrowShortcuts [
	<gtExample>
	<noTest>
	| aScripter |
	self ifLibEditorIsMissingDo: [ ^ nil ].
	aScripter := self rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowDown;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowDown;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowDown;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			6
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowUp;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			8
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowUp;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			8
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowUp;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_refactoringsPreview [
	<gtExample>
	<noTest>
	| aScripter |
	self ifLibEditorIsMissingDo: [ ^ nil ].
	aScripter := self rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	aScripter click
		label: 'Activate first selector part';
		// (#'selector-part' asBlocElementId indexed: 1);
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	aScripter editor
		label: 'Type character "_"';
		deselectAll;
		typeText: '_';
		// (#'selector-part' asBlocElementId indexed: 1);
		play.

	self assert: aScripter refactoringsPreviewIsVisible: true.

	aScripter editor
		label: 'Delete previously typed character';
		pressBackspace;
		// (#'selector-part' asBlocElementId indexed: 1);
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	^ aScripter
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_rightAndLeftArrowShortcuts [
	<gtExample>
	<noTest>
	| aScripter |
	self ifLibEditorIsMissingDo: [ ^ nil ].
	aScripter := self rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowRight;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowRight;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowRight;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			6
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowLeft;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			8
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowLeft;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			8
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowLeft;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_tabShortcuts [
	<gtExample>
	<noTest>
	| aScripter |
	self ifLibEditorIsMissingDo: [ ^ nil ].
	aScripter := self rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey tab;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey tab;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey tab;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	(aScripter keyWithShiftPress: BlKeyboardKey tab)
		label: 'Jump to the previous selector part';
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	(aScripter keyWithShiftPress: BlKeyboardKey tab)
		label: 'Jump to the previous selector part';
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	(aScripter keyWithShiftPress: BlKeyboardKey tab)
		label: 'Jump to the previous selector part';
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_typeAThenB [
	<gtExample>
	<noTest>
	| anElement aScripter aModel aPartOneId |
	self ifLibEditorIsMissingDo: [ ^ nil ].
	anElement := self selectorPartElementsWithFirstThreeKeywordsMethod.
	aModel := anElement userData at: #selectorModel.
	aScripter := BlScripter new
			model: aModel;
			element: anElement.

	aPartOneId := #'selector-part' asBlocElementId indexed: 1.
	self assert: aScripter onlyOneEditorMode: aPartOneId.

	aScripter editor
		typeText: 'a';
		assertTextEqualsTo: 'a';
		assertCursorPosition: 1;
		// aPartOneId;
		play.

	aScripter editor
		typeText: 'b';
		assertTextEqualsTo: 'ab';
		assertCursorPosition: 2;
		// aPartOneId;
		play.

	^ aScripter
]

{ #category : #'examples - brick editor scripter' }
GtPharoRenameSelectorModelExamples >> scripterEditorWithThreeKeywordsMethod [
	<gtExample>
	| anElement aScripter aModel |
	anElement := self editorWithThreeKeywordsMethod.
	aScripter := BlScripter new element: anElement.
	aModel := anElement userData at: #selectorModel.
	aScripter := BlScripter new
			model: aModel;
			element: anElement.
			
	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - brick editor scripter' }
GtPharoRenameSelectorModelExamples >> scripterSelectorPartElementsWithFirstThreeKeywordsMethod [
	<gtExample>
	| anElement aScripter aModel |
	anElement := self selectorPartElementsWithFirstThreeKeywordsMethod.
	aModel := anElement userData at: #selectorModel.
	aScripter := BlScripter new
			model: aModel;
			element: anElement.
			
	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - brick editor scripter' }
GtPharoRenameSelectorModelExamples >> scripterSelectorPartElementsWithFirstThreeKeywordsMethod_downAndUpArrowShortcuts [
	<gtExample>
	| aScripter |
	aScripter := self scripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowDown;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowDown;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowDown;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			6
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowUp;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			8
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowUp;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			8
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowUp;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - brick editor scripter' }
GtPharoRenameSelectorModelExamples >> scripterSelectorPartElementsWithFirstThreeKeywordsMethod_refactoringsPreview [
	<gtExample>
	| aScripter |
	aScripter := self scripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	aScripter click
		label: 'Activate first selector part';
		// (#'selector-part' asBlocElementId indexed: 1);
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	aScripter editor
		label: 'Type character "_"';
		deselectAll;
		typeText: '_';
		// (#'selector-part' asBlocElementId indexed: 1);
		play.

	self assert: aScripter refactoringsPreviewIsVisible: true.

	aScripter editor
		label: 'Delete previously typed character';
		pressBackspace;
		// (#'selector-part' asBlocElementId indexed: 1);
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	^ aScripter
]

{ #category : #'examples - brick editor scripter' }
GtPharoRenameSelectorModelExamples >> scripterSelectorPartElementsWithFirstThreeKeywordsMethod_rightAndLeftArrowShortcuts [
	<gtExample>
	| aScripter |
	aScripter := self scripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowRight;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowRight;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey arrowRight;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			6
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowLeft;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			8
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowLeft;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter
		substeps: 'Jump to the previous selector part'
		do: [ :aStep | 
			8
				timesRepeat: [ aStep keyPress
						label: 'Move cursor to the left';
						key: BlKeyboardKey arrowLeft;
						play ] ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - brick editor scripter' }
GtPharoRenameSelectorModelExamples >> scripterSelectorPartElementsWithFirstThreeKeywordsMethod_tabShortcuts [
	<gtExample>
	| aScripter |
	aScripter := self scripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey tab;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey tab;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	aScripter keyPress
		label: 'Jump to the next selector part';
		key: BlKeyboardKey tab;
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	(aScripter keyWithShiftPress: BlKeyboardKey tab)
		label: 'Jump to the previous selector part';
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 3).

	(aScripter keyWithShiftPress: BlKeyboardKey tab)
		label: 'Jump to the previous selector part';
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 2).

	(aScripter keyWithShiftPress: BlKeyboardKey tab)
		label: 'Jump to the previous selector part';
		play.

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - brick editor scripter' }
GtPharoRenameSelectorModelExamples >> scripterSelectorPartElementsWithFirstThreeKeywordsMethod_typeAThenB [
	<gtExample>
	| anElement aScripter aModel aPartOneId |
	anElement := self selectorPartElementsWithFirstThreeKeywordsMethod.
	aModel := anElement userData at: #selectorModel.
	aScripter := BlScripter new
			model: aModel;
			element: anElement.

	aPartOneId := #'selector-part' asBlocElementId indexed: 1.
	self
		assert: aScripter
		onlyOneEditorMode: aPartOneId.

	aScripter editor
		typeText: 'a';
		assertTextEqualsTo: 'a';
		assertCursorPosition: 1;
		// aPartOneId;
		play.

	aScripter editor
		typeText: 'b';
		assertTextEqualsTo: 'ab';
		assertCursorPosition: 2;
		// aPartOneId;
		play.

	^ aScripter
]

{ #category : #'examples - elements' }
GtPharoRenameSelectorModelExamples >> selectorPartElementWithFirstThreeKeywordsMethod [
	<gtExample>
	| anElement aModel aPartModel |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.
	aPartModel := aModel selectorParts at: 1.
	anElement := self basicSelectorPartElement.
	anElement selectorModel: aModel selectorPartModel: aPartModel.

	^ anElement
]

{ #category : #'examples - elements' }
GtPharoRenameSelectorModelExamples >> selectorPartElementsWithFirstThreeKeywordsMethod [
	<gtExample>
	| aContainer aStencil |
	aStencil := self attributesStencilWithThreeKeywordsMethod.
	aContainer := self createElementsFromAttributesStencil: aStencil.
	^ aContainer
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> threeKeywordsMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyTwoObject >> #sumA:valueB:valueC:.
	^ aMethod
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> threeKeywordsMethodAst [
	<gtExample>
	^ self parseMethod: self threeKeywordsMethod
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> threeKeywordsMethodKeywordMessageAst [
	<gtExample>
	| anAst aKeywordNode |
	anAst := self threeKeywordsMethodAst.
	aKeywordNode := nil.
	anAst
		allNodesOfType: GtPharoKeywordMessageNode
		do: [ :eachNode | eachNode selector = #sumA:b: ifTrue: [ aKeywordNode := eachNode ] ].

	self assert: aKeywordNode isNotNil.

	^ aKeywordNode
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> threeKeywordsMethodPatternAst [
	<gtExample>
	| anAst aKeywordNode |
	anAst := self threeKeywordsMethodAst.
	aKeywordNode := nil.
	anAst
		allNodesOfType: GtPharoMethodPatternNode
		do: [ :eachNode | aKeywordNode := eachNode ].

	self assert: aKeywordNode isNotNil.

	^ aKeywordNode
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> unaryMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyOneObject >> #instAReceiver.
	^ aMethod
]

{ #category : #'examples - method' }
GtPharoRenameSelectorModelExamples >> unaryMethodAst [
	<gtExample>
	^ self parseMethod: self unaryMethod
]
