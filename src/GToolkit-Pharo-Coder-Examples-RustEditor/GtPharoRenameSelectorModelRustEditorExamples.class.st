Class {
	#name : #GtPharoRenameSelectorModelRustEditorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-RustEditor-Refactoring - Method New'
}

{ #category : #asserting }
GtPharoRenameSelectorModelRustEditorExamples >> assert: aScripter onlyOneEditorMode: anElementId [
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
GtPharoRenameSelectorModelRustEditorExamples >> assert: aScripter refactoringsPreviewIsVisible: aBoolean [
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

{ #category : #support }
GtPharoRenameSelectorModelRustEditorExamples >> createRustEditorWithMethod2: aMethod [
	| aCoderElement aTextEditorElement aDocumentId aController aCoder aCoderViewModel aRecorder |
	aDocumentId := nil.
	aCoder := GtPharoMethodCoder forMethod: aMethod.
	aCoderViewModel := aCoder asCoderViewModel.
	aRecorder := GtTextEditorTimelineRecorder new.
	aRecorder
		addSignalClass: GtTextEditorSignal;
		observeAnnouncer: aCoderViewModel announcer labeled: 'coder view model'.

	aRecorder
		runDuring: [ aCoderElement := GtExpandableSourceCoderElement new
					expandedElementStencil: GtExpandedCoderElementWithRustTextEditorStencil new;
					textualCoderViewModel: aCoderViewModel;
					expand.

			BlTaskAction
				enqueueElement: aCoderElement
				action: [ aTextEditorElement := (aCoderElement query // GtTextEditorElement) anyOne.
					self
						assert: [ aTextEditorElement isNotNil ]
						description: [ 'Text editor element must exist.' ].
					aTextEditorElement privateEditorHandle enableInMemoryCommandsRecorder.
					aTextEditorElement
						when: BrTextEditorModifiedEvent
							do: [ :anEvent | aDocumentId := anEvent documentId ];
						styler: (GtPharoStyler new coderViewModel: aCoderViewModel);
						when: BrTextStyledEvent
							doOnce: [ :anEvent | 
								| anAstFuture |
								anAstFuture := aCoderViewModel coderAstFuture
										map: [ :aCoderAst | 
											BlTaskAction
												enqueueElement: anEvent currentTarget
												action: [ anEvent currentTarget
														assert: [ aDocumentId isNotNil ]
														description: [ 'Document ID must be non-nil.' ].
													aController := GtPharoRenameSelectorCoderController new
															originalNode: aCoderAst ast;
															documentId: aDocumentId;
															editorElement: aTextEditorElement;
															sourceCoderViewModel: aCoderViewModel;
															install.
													aController selectorModel
														ifNotNil: [ :aSelectorModel | 
															aRecorder
																observeAnnouncer: aSelectorModel announcer
																labeled: 'rename selector model' ] ] ].
								anAstFuture await: aCoderViewModel class commonExecutionConfiguration ].

					aTextEditorElement text: aMethod sourceCode asRopedText.

					aTextEditorElement userData at: #coderViewModel put: aCoderViewModel.
					aTextEditorElement userData at: #timelineRecorder put: aRecorder ] ].

	aCoderElement userData at: #coderViewModel put: aCoderViewModel.
	aCoderElement userData at: #timelineRecorder put: aRecorder.

	^ aCoderElement
]

{ #category : #support }
GtPharoRenameSelectorModelRustEditorExamples >> createRustEditorWithMethod: aMethod [
	| anEditor aDocumentId aController aCoder anAst aCoderViewModel aRecorder |
	aDocumentId := nil.
	aCoder := GtPharoMethodCoder forMethod: aMethod.
	anAst := aCoder astSync.
	aCoderViewModel := aCoder asCoderViewModel.
	aRecorder := GtTextEditorTimelineRecorder new.
	aRecorder
		addSignalClass: GtTextEditorSignal;
		observeAnnouncer: aCoderViewModel announcer
		labeled: 'coder view model'.

	aRecorder runDuring: [
		
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
							enqueueElement: anEvent currentTarget
							action: [ anEvent currentTarget
									assert: [ aDocumentId isNotNil ]
									description: [ 'Document ID must be non-nil.' ].
								aController := GtPharoRenameSelectorCoderController new
										originalNode: anAst;
										documentId: aDocumentId;
										editorElement: anEditor;
										sourceCoderViewModel: aCoderViewModel;
										install.
								aController selectorModel ifNotNil: [ :aSelectorModel |
									aRecorder
										observeAnnouncer: aSelectorModel announcer labeled: 'rename selector model' ] ] ];
				matchParent;
				yourself.
	
		anEditor text: aMethod sourceCode asRopedText.
		
	].
	
	anEditor userData at: #coderViewModel put: aCoderViewModel.
	anEditor userData at: #timelineRecorder put: aRecorder.

	^ anEditor
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelRustEditorExamples >> numberOfRenameRefactoringElementsIn: anEditorElement [
	^ anEditorElement children
		count: [ :eachChild | 
			eachChild id
				ifNotNil: [ :anId | 
					anId asSymbol
						ifNotNil: [ :aSymbol | 
							#('selector-' 'move-')
								anySatisfy: [ :eachPrefix | aSymbol beginsWith: eachPrefix ] ]
						ifNil: [ false ] ]
				ifNil: [ false ] ]
]

{ #category : #'examples - rust editor' }
GtPharoRenameSelectorModelRustEditorExamples >> rustEditorWithThreeKeywordsMethod [
	<gtExample>
	| aMethod anEditor |
	aMethod := self threeKeywordsMethod.
	anEditor := self createRustEditorWithMethod: aMethod.
	^ anEditor
]

{ #category : #'examples - rust editor' }
GtPharoRenameSelectorModelRustEditorExamples >> rustEditorWithThreeKeywordsMethod2 [
	<gtExample>
	| aMethod aCoderElement |

	aMethod := self threeKeywordsMethod.
	aCoderElement := self createRustEditorWithMethod2: aMethod.
	^ aCoderElement
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelRustEditorExamples >> rustScripterEditorWithThreeKeywordsMethod [
	<gtExample>
	| anElement aScripter aSelectorModel aCoderViewModel aRecorder |
	anElement := self rustEditorWithThreeKeywordsMethod.
	aCoderViewModel := anElement userData at: #coderViewModel.
	aRecorder := anElement userData at: #timelineRecorder.
	aScripter := BlScripter new.
	aScripter userData at: #timelineRecorder put: aRecorder.

	aRecorder runDuring: [ aScripter element: anElement.

		aScripter wait
			forCondition: [ :aSpace :theScripter | 
					anElement userData
						at: #selectorModel
						ifPresent: [ :theModel | 
							theModel ifNotNil: [ aSelectorModel := theModel ].
							theModel isNotNil ]
						ifAbsent: [ false ] ]
				pulseDuring: 5 seconds;
			play.
		self assert: aSelectorModel isNotNil.
		aScripter model: aSelectorModel.
	
		aScripter wait
			waitRustEditorRendered: anElement pulseDuring: 5 seconds;
			play.
	
		aScripter wait
			forCondition: [ :aSpace | (self numberOfRenameRefactoringElementsIn: anElement) = 15 ]
				pulseDuring: 5 seconds;
			play.
			
	].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelRustEditorExamples >> rustScripterEditorWithThreeKeywordsMethod2 [
	<gtExample>
	| aCoderElement aScripter anEditorElement aSelectorModel aCoderViewModel aRecorder |
	aCoderElement := self rustEditorWithThreeKeywordsMethod2.
	aCoderViewModel := aCoderElement userData at: #coderViewModel.
	aRecorder := aCoderElement userData at: #timelineRecorder.
	aScripter := BlScripter new.
	aScripter userData at: #timelineRecorder put: aRecorder.

	aRecorder
		runDuring: [ aScripter element: aCoderElement.
			anEditorElement := (aScripter element query // GtTextEditorElement) anyOne.
			self
				assert: anEditorElement isNotNil
				description: [ 'Text editor element must exist' ].

			aScripter wait
				forCondition: [ :aSpace :theScripter | 
						anEditorElement userData
							at: #selectorModel
							ifPresent: [ :theModel | 
								theModel ifNotNil: [ aSelectorModel := theModel ].
								theModel isNotNil ]
							ifAbsent: [ false ] ]
					pulseDuring: 5 seconds;
				play.
			self assert: aSelectorModel isNotNil.
			aScripter model: aSelectorModel.

			aScripter wait
				waitRustEditorRendered: anEditorElement pulseDuring: 5 seconds;
				play.

			aScripter wait
				label: 'Assert there are 15 ';
				forCondition: [ :aSpace | (self numberOfRenameRefactoringElementsIn: anEditorElement) = 15 ]
					pulseDuring: 5 seconds;
				play ].

	self
		assert: aScripter
		onlyOneEditorMode: (#'selector-part' asBlocElementId indexed: 1).

	^ aScripter
]

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelRustEditorExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod [
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

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelRustEditorExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_downAndUpArrowShortcuts [
	<gtExample>
	| aScripter |
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
GtPharoRenameSelectorModelRustEditorExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_refactoringsPreview [
	<gtExample>
	| aScripter |
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
GtPharoRenameSelectorModelRustEditorExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_rightAndLeftArrowShortcuts [
	<gtExample>
	| aScripter |
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
GtPharoRenameSelectorModelRustEditorExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_tabShortcuts [
	<gtExample>
	| aScripter |
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
GtPharoRenameSelectorModelRustEditorExamples >> rustScripterSelectorPartElementsWithFirstThreeKeywordsMethod_typeAThenB [
	<gtExample>
	| anElement aScripter aModel aPartOneId |
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

{ #category : #'examples - rust editor scripter' }
GtPharoRenameSelectorModelRustEditorExamples >> selectorPartElementsWithFirstThreeKeywordsMethod [
	<gtExample>
	^ GtPharoRenameSelectorModelExamples new
		selectorPartElementsWithFirstThreeKeywordsMethod
]

{ #category : #'examples - rust editor' }
GtPharoRenameSelectorModelRustEditorExamples >> threeKeywordsMethod [
	<gtExample>
	^ GtPharoRenameSelectorModelExamples new threeKeywordsMethod
]
