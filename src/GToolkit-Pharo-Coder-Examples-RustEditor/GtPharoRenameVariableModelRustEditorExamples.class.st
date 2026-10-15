"
I contain examples that use {{gtClass:BlScripter}} to simulate user interactions with {{gtClass:GtPharoRenameInstanceVariableCoderController}} in a coder with a Rust text editor, see {{gtMethod:GtPharoDummyOneObject>>#instAPlusOne}}. I am the counterpart of {{gtClass:GtPharoRenameSelectorModelRustEditorExamples}}.
"
Class {
	#name : #GtPharoRenameVariableModelRustEditorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-RustEditor-Refactoring - Method New'
}

{ #category : #assertions }
GtPharoRenameVariableModelRustEditorExamples >> assert: aScripter editorMode: isEditable [
	aScripter assert
		label: ('Assert variable editor is in {1} mode' format: {isEditable ifTrue: [ 'editable' ] ifFalse: [ 'label' ]});
		satisfies: [ :anEditor | anEditor viewModel mode isEditable = isEditable ];
		// #'variable-editor';
		/ #editorElement;
		play
]

{ #category : #assertions }
GtPharoRenameVariableModelRustEditorExamples >> assert: aScripter occurrenceLabelsEqual: aString [
	aScripter assert
		label: ('Assert occurrence shows {1}' format: {aString printString});
		satisfies: [ :aLabel | aLabel text asString = aString ];
		// (#'variable-occurrence' asBlocElementId indexed: 1);
		/ #labelElement;
		play
]

{ #category : #assertions }
GtPharoRenameVariableModelRustEditorExamples >> assert: aScripter refactoringsPreviewIsVisible: aBoolean [
	aScripter assert
		label: ('Assert refactorings preview is {1}'
				format: {aBoolean ifTrue: [ 'visible' ] ifFalse: [ 'hidden' ]});
		satisfies: [ :anElement | 
			aBoolean
				ifTrue: [ anElement visibility isVisible ]
				ifFalse: [ anElement visibility isHidden ] ];
		// #'variable-refactorings-preview';
		play
]

{ #category : #utilities }
GtPharoRenameVariableModelRustEditorExamples >> createRustEditorWithMethod: aMethod variableNamed: aVariableName [
	"Create a coder element with a Rust text editor. When the editor is styled, a variable rename controller is installed on the first variable with the given name."

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
													aController := GtPharoRenameInstanceVariableCoderController new
															originalNode: (self variableNodeNamed: aVariableName in: aCoderAst ast);
															documentId: aDocumentId;
															editorElement: aTextEditorElement;
															sourceCoderViewModel: aCoderViewModel;
															install.
													aController variableModel
														ifNotNil: [ :aVariableModel | 
															aRecorder
																observeAnnouncer: aVariableModel announcer
																labeled: 'rename variable model' ] ] ].
								anAstFuture await: aCoderViewModel class commonExecutionConfiguration ].

					aTextEditorElement text: aMethod sourceCode asRopedText.

					aTextEditorElement userData at: #coderViewModel put: aCoderViewModel.
					aTextEditorElement userData at: #timelineRecorder put: aRecorder ] ].

	aCoderElement userData at: #coderViewModel put: aCoderViewModel.
	aCoderElement userData at: #timelineRecorder put: aRecorder.

	^ aCoderElement
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> instAPlusOneMethod [
	<gtExample>
	<return: #CompiledMethod>
	^ GtPharoDummyOneObject >> #instAPlusOne
]

{ #category : #utilities }
GtPharoRenameVariableModelRustEditorExamples >> numberOfRenameRefactoringElementsIn: anEditorElement [
	^ anEditorElement children
		count: [ :eachChild | 
			eachChild id
				ifNotNil: [ :anId | 
					anId asSymbol
						ifNotNil: [ :aSymbol | aSymbol beginsWith: 'variable-' ]
						ifNil: [ false ] ]
				ifNil: [ false ] ]
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustEditorWithInstAPlusOneMethod [
	<gtExample>
	<return: #GtExpandableSourceCoderElement>
	^ self createRustEditorWithMethod: self instAPlusOneMethod variableNamed: 'instA'
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustScripterEditorWithInstAPlusOneMethod [
	<gtExample>
	<return: #BlScripter>
	| aCoderElement aScripter anEditorElement aVariableModel aRecorder |
	aCoderElement := self rustEditorWithInstAPlusOneMethod.
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
							at: #variableModel
							ifPresent: [ :theModel | 
								theModel ifNotNil: [ aVariableModel := theModel ].
								theModel isNotNil ]
							ifAbsent: [ false ] ]
					pulseDuring: 5 seconds;
				play.
			self assert: aVariableModel isNotNil.
			aScripter model: aVariableModel.

			aScripter wait
				waitRustEditorRendered: anEditorElement pulseDuring: 5 seconds;
				play.

			aScripter wait
				label: 'Wait for the editor, one other occurrence, and the refactorings preview';
				forCondition: [ :aSpace | (self numberOfRenameRefactoringElementsIn: anEditorElement) = 3 ]
					pulseDuring: 5 seconds;
				play ].

	aScripter userData at: #editorElement put: anEditorElement.
	self assert: aScripter editorMode: true.
	self assert: aScripter refactoringsPreviewIsVisible: false.
	self assert: aScripter occurrenceLabelsEqual: 'instA'.

	^ aScripter
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustScripterEditorWithInstAPlusOneMethod_enterShowsPreview [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithInstAPlusOneMethod.

	aScripter click
		label: 'Activate the variable editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Type character "_"';
		deselectAll;
		typeText: '_';
		// #'variable-editor';
		play.

	aScripter keyPress
		label: 'Press Enter';
		key: BlKeyboardKey return;
		play.

	self assert: aScripter refactoringsPreviewIsVisible: true.
	self
		assert: (self numberOfRenameRefactoringElementsIn: (aScripter userData at: #editorElement))
		equals: 3.

	^ aScripter
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustScripterEditorWithInstAPlusOneMethod_escapeUninstalls [
	<gtExample>
	<return: #BlScripter>
	| aScripter anEditorElement |
	aScripter := self rustScripterEditorWithInstAPlusOneMethod.
	anEditorElement := aScripter userData at: #editorElement.

	aScripter click
		label: 'Activate the variable editor';
		// #'variable-editor';
		play.

	aScripter keyPress
		label: 'Press Escape';
		key: BlKeyboardKey escape;
		play.

	aScripter wait
		label: 'Wait until all rename elements are removed';
		forCondition: [ :aSpace | (self numberOfRenameRefactoringElementsIn: anEditorElement) = 0 ]
			pulseDuring: 5 seconds;
		play.

	self assert: (anEditorElement userData includesKey: #variableModel) not.
	self assert: (anEditorElement userData includesKey: #variableController) not.

	^ aScripter
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustScripterEditorWithInstAPlusOneMethod_invalidName [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithInstAPlusOneMethod.

	aScripter click
		label: 'Activate the variable editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Type a space that makes the name invalid';
		deselectAll;
		typeText: ' ';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	aScripter editor
		label: 'Type character "_" after the space';
		typeText: '_';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	^ aScripter
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustScripterEditorWithInstAPlusOneMethod_occurrencesFollowTyping [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithInstAPlusOneMethod.

	aScripter click
		label: 'Activate the variable editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Replace the name with "other"';
		selectAll;
		typeText: 'other';
		// #'variable-editor';
		play.

	self assert: aScripter occurrenceLabelsEqual: 'other'.

	aScripter editor
		label: 'Delete previously typed character';
		pressBackspace;
		// #'variable-editor';
		play.

	self assert: aScripter occurrenceLabelsEqual: 'othe'.

	^ aScripter
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustScripterEditorWithInstAPlusOneMethod_refactoringsPreview [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithInstAPlusOneMethod.

	aScripter click
		label: 'Activate the variable editor';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	aScripter editor
		label: 'Type character "_"';
		deselectAll;
		typeText: '_';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: true.

	aScripter editor
		label: 'Delete previously typed character';
		pressBackspace;
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	^ aScripter
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustScripterEditorWithInstAPlusOneMethod_typeAThenB [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithInstAPlusOneMethod.

	aScripter click
		label: 'Activate the variable editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Replace the name with "a"';
		selectAll;
		typeText: 'a';
		assertTextEqualsTo: 'a';
		assertCursorPosition: 1;
		// #'variable-editor';
		play.

	aScripter editor
		typeText: 'b';
		assertTextEqualsTo: 'ab';
		assertCursorPosition: 2;
		// #'variable-editor';
		play.

	^ aScripter
]

{ #category : #examples }
GtPharoRenameVariableModelRustEditorExamples >> rustScripterEditorWithInstAPlusOneMethod_typeAndDeleteAllCharacters [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithInstAPlusOneMethod.

	aScripter click
		label: 'Activate the variable editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Replace the name with "a"';
		selectAll;
		typeText: 'a';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: true.

	aScripter editor
		label: 'Delete the character, the empty name is not valid';
		pressBackspace;
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	^ aScripter
]

{ #category : #utilities }
GtPharoRenameVariableModelRustEditorExamples >> variableNodeNamed: aString in: anAst [
	anAst allNodesDo: [ :each | 
		(each isVariable and: [ each source = aString ]) ifTrue: [ ^ each ] ].
	^ self error: 'Variable ' , aString , ' must exist'
]
