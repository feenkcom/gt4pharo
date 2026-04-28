Class {
	#name : #GtPharoRenameSelectorModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #'examples - scripter' }
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

{ #category : #'examples - scripter' }
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

{ #category : #'examples - demo' }
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
					aController := GtPharoRenameSelectorCoderController new
							originalNode: anAst;
							editorElement: anEditor;
							sourceCoderViewModel: aCoderViewModel;
							install ];
			matchParent;
			yourself.

	anEditor text: aMethod sourceCode.

	anEditor userData at: #selectorController put: aController.

	^ anEditor
]

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithBinaryMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self binaryMethod.
	anEditor := self createEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithOneKeywordMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self oneKeywordMethod.
	anEditor := self createEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithThreeKeywordsMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self threeKeywordsMethod.
	anEditor := self createEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - demo' }
GtPharoRenameSelectorModelExamples >> editorWithUnaryMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self unaryMethod.
	anEditor := self createEditorWithMethod: aMethod.
	^ anEditor
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
	aModel := GtPharoRenameSelectorModel forAstMethodNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(1).

	self assert: (aModel selectorParts at: 1) currentName equals: '*'.
	self assert: (aModel parameters at: 1) currentName equals: 'anObject'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithOneKeywordMethod [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self oneKeywordMethod.
	anAst := self oneKeywordMethodAst.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #(1).

	self assert: (aModel selectorParts at: 1) currentName equals: 'instA:'.
	self assert: (aModel parameters at: 1) currentName equals: 'anObject'.

	^ aModel
]

{ #category : #'examples - model' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithThreeKeywordsMethod [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self threeKeywordsMethod.
	anAst := self threeKeywordsMethodAst.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: anAst.

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
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithUnaryMethod [
	<gtExample>
	| aModel aMethod anAst |
	aMethod := self unaryMethod.
	anAst := self unaryMethodAst.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: anAst.

	self assert: aModel isModified not.
	self assert: aModel originalSelector equals: aMethod selector.
	self assert: aModel currentSelector equals: aMethod selector.
	self assert: aModel currentParameterPermutations equals: #().

	self assert: (aModel selectorParts at: 1) currentName equals: 'instAReceiver'.

	^ aModel
]

{ #category : #'examples - rust editor' }
GtPharoRenameSelectorModelExamples >> rustEditorWithThreeKeywordsMethod [
	<gtExample>
	<noTest>
	| aMethod anEditor |
	aMethod := self threeKeywordsMethod.
	anEditor := self createRustEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - scripter' }
GtPharoRenameSelectorModelExamples >> scripterSelectorPartElementsWithFirstThreeKeywordsMethod [
	<gtExample>
	| anElement aScripter aModel |
	anElement := self selectorPartElementsWithFirstThreeKeywordsMethod.
	aModel := anElement userData at: #selectorModel.
	aScripter := BlScripter new
			model: aModel;
			element: anElement.

	^ aScripter
]

{ #category : #'examples - scripter' }
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

{ #category : #'examples - scripter' }
GtPharoRenameSelectorModelExamples >> scripterSelectorPartElementsWithFirstThreeKeywordsMethod_tabShortcuts [
	<gtExample>
	| aScripter |
	aScripter := self scripterSelectorPartElementsWithFirstThreeKeywordsMethod.

	aScripter click
		label: 'Activate first selector part';
		// (#'selector-part' asBlocElementId indexed: 1);
		play.

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

{ #category : #examples }
GtPharoRenameSelectorModelExamples >> selectorPartElementsWithFirstThreeKeywordsMethod [
	<gtExample>
	| anElement aModel aContainer anIndex |
	aModel := self renameSelectorModelWithThreeKeywordsMethod.

	aContainer := BrHorizontalPane new
			cellSpacing: 10;
			padding: (BlInsets all: 10);
			alignCenterLeft;
			fitContent.

	anIndex := 1.
	aModel
		selectorPartsAndParametersDo: [ :eachPart :eachParameter |
			anElement := self basicSelectorPartElement.
			anElement selectorModel: aModel selectorPartModel: eachPart.
			aContainer
				addChild: anElement
				as: (#'selector-part' asBlocElementId indexed: anIndex).

			eachParameter ifNotNil: [
				anElement := self basicSelectorParameterElement.
				anElement parameterModel: eachParameter.
				aContainer
					addChild: anElement
					as: (#'selector-parameter' asBlocElementId indexed: anIndex) ].

			anIndex := anIndex + 1 ].

	anElement := self basicSelectorRefactoringsPreviewElement.
	anElement selectorModel: aModel.
	aContainer addChild: anElement as: #'selector-refactorings-preview'.

	aContainer userData at: #selectorModel put: aModel.

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
