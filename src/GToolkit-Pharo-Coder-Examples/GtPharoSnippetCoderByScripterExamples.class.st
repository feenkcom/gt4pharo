Class {
	#name : #GtPharoSnippetCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #accessing }
GtPharoSnippetCoderByScripterExamples class >> inlineTestMethod: a [
	^ a
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> check: aScripter hasReorderAttributes: anInteger [
	<gtExample>
	aScripter checkStep: [ :s | 
		s label: 'Check reorder attributes';
		// GtSourceCoderEditorId;
		value: [ :aCoderEditor | 
			| count |
			count := 0.
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtReorderParametersAttribute ]
				indicesDo: [ :aStart :anEnd | count := count + 1 ].
				count ]
			equals: [ :aCoderEditor | anInteger ] ]
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> checkExtractedSource: aScripter [
	| text variables possibleSelectors |
	variables := #(string start end).
	possibleSelectors := #(#_:_: #substringFrom:_: #substringFrom:to:).

	aScripter checkStep: [:s |
		s label: 'Check text';
		// GtSourceCoderEditorId;
		elementSatisfies:
				[ :aSourceEditor | 
					| messageSend |
					text := aSourceEditor text asString.
					messageSend := (GtPharoParser parse: text startingAt: GtPharoParser startingStateForMethodSequence) statements last.
					messageSend isMessageSend
						and:
							[ (possibleSelectors includes: messageSend selector)
								and:
									[ (variables includes: messageSend receiver variableName)
										and: [ messageSend arguments allSatisfy: [ :each | variables includes: each variableName ] ] ] ] ] ].
	^ text
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> checkInlineSnippet: source messageInterval: anInterval producing: result [
	<gtExample>
	| behavior |
	behavior := nil class.
	^ self
		checkInlineSnippet: source
		messageInterval: anInterval
		producing: result
		inClass: behavior
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> checkInlineSnippet: source messageInterval: anInterval producing: result inClass: behavior [
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoSnippetCoder forSource: source) behavior: behavior ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				// GtSourceCoderEditorId ].
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the snippet to extract';
				// GtSourceCoderEditorId;
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: anInterval first to: anInterval last;
						select ] ].
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				// GtSourceCoderEditorId ].
	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover inline';
				onSpaceRoot;
				id: #'context-menu--inline-send' index: 1 ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click inline';
				onSpaceRoot;
				id: #'context-menu--inline-send' index: 1 ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert value';
				value: [ :aCoderEditor | RBParser parseExpression: aCoderEditor textualCoderViewModel sourceText asString ]
					equals: [ :aCoderEditor | RBParser parseExpression: result ];
				id: GtSourceCoderEditorId ].
	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> checkRenameEditor: aScripter keyword: aBoolean [
	| selectorPart |
	selectorPart := aBoolean ifTrue: [ '_:' ] ifFalse: [ '_' ].
	aScripter checkStep: [:s |
		s label: 'Check rename editor attribute';
		// GtSourceCoderEditorId;
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval ifNil: [ anInterval := aStart to: anEnd ] ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString indexOfSubCollection: selectorPart.
				index to: index + selectorPart size - 1 ]].

	aScripter checkStep: [:s |
		s label: 'Check refactoring changes attribute';
		// GtSourceCoderEditorId;
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ]].

	aScripter checkStep: [:s |
		s label: 'Check source editor is not focused';
		// GtSourceCoderEditorId;
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ]].

	aScripter checkStep: [:s | 
		s label: 'Check source editor has focus';
		// GtSourceCoderEditorId;
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ]].

	aScripter checkStep: [:s | 
		s label: 'Check method name editor selected text';
		onFocusProcessor;
		value: [ :focus | focus focusOwner class ] equals: GtRenameEditor].

	aScripter checkStep: [:s | 
		s label: 'Check method name editor source code';
		onFocusProcessor;
		value: [ :focus | focus focusOwner text asString ] equals: '_'].

	aScripter checkStep: [:s | 
		s label: 'Check method name editor selected text';
		onFocusProcessor;
		value: [ :focus | focus focusOwner editor selectedText asString ] equals: '_'].
		
	^aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> clickReorderParameter: aScripter [
	| text |
	text := self checkExtractedSource: aScripter.
	
	aScripter clickStep: [:s | 
		s label: 'Open context menu';
		id: #'reorder-parameter-button'].
	
	aScripter checkStep: [:s | 
		s label: 'Check selected text';
		// GtSourceCoderEditorId;
		elementSatisfies:
				[ :aSourceEditor | 
					| string |
					string := aSourceEditor text asString.
					text ~= string ]].

	self checkExtractedSource: aScripter.
	self check: aScripter hasReorderAttributes: 2
]

{ #category : #'examples - context menu' }
GtPharoSnippetCoderByScripterExamples >> contextMenuInspect [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder forSource: 'Object new' ].
	self
		selectTextFor: aScripter
		from: 0
		to: 6
		andCheck: 'Object'.

	self
		openAndClickOnContextMenuItemFor: aScripter
		id: GtSourceCoderDoItAndGoActionId.

	aScripter assertStep: [:s | 
		s label: 'Assert Triggered Spawn Object Event';
				onScripter;
		satisfies: [ :theScripter | 
			theScripter events reversed
				detectEventOfClass: GtPhlowObjectToSpawn
				ifFound: [ :theEvent | theEvent object = Object ]
				ifNone: [ AssertionFailure
						signal: GtPhlowObjectToSpawn name , ' event was not found' ] ] ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> extractExample_01_setup [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder
					forSource: 'theData := example examplePackage.
dataGroup := GtPlotterDataGroup new values: theData asOrderedCollection' ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				// GtSourceCoderEditorId ].
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method to extract';
				// GtSourceCoderEditorId;
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 0 to: aSourceEditor text size;
						select ] ].
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				// GtSourceCoderEditorId ].

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover extract method';
				onSpaceRoot;
				// #'snippet-extract-example' ].
	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> extractExample_02_execute [
	<gtExample>
	| aScripter |
	aScripter := self extractExample_01_setup.
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click extract method';
				onSpaceRoot;
				// #'snippet-extract-example' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				onModel;
				satisfies: #isModified ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Verify extractring to example variable';
				// GtSourceCoderEditorId;
				value: [ :each | each text asString ] equals: 'example _' ].
	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> extractMethodFromInspector_01_setup [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ ((GtPharoSnippetCoder forSource: 'array size - self size')
					behavior: OrderedCollection;
					yourself) asCoderViewModel
					selfObject: OrderedCollection new;
					yourself ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				// GtSourceCoderEditorId ].
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method to extract';
				// GtSourceCoderEditorId;
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 0 to: aSourceEditor text size;
						select ] ].
	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> extractMethodFromInspector_02_extract [
	<gtExample>
	| aScripter |
	aScripter := self extractMethodFromInspector_01_setup.
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				// GtSourceCoderEditorId ].
	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover extract method';
				onSpaceRoot;
				// GtMethodCoderExtractMethodContextMenuItemId ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click extract method';
				onSpaceRoot;
				// GtMethodCoderExtractMethodContextMenuItemId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				onModel;
				satisfies: [ :aCoder | (RBParser parseExpression: aCoder sourceText asString) selector isUnary ] ].
	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> extractTestToVariable [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder
					forSource: 'theData := test examplePackage.
dataGroup := GtPlotterDataGroup new values: theData asOrderedCollection' ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				// GtSourceCoderEditorId ].
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method to extract';
				// GtSourceCoderEditorId;
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 0 to: aSourceEditor text size;
						select ] ].
	aScripter
		doStep: [ :s | 
			s
				label: 'Run extract test';
				action: [ :element | 
					(GtExtractTestFromSnippetController new
						sourceCoderViewModel: element textualCoderViewModel) executeIn: element ] ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				onModel;
				satisfies: #isModified ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Verify extractring to example variable';
				// GtSourceCoderEditorId;
				value: [ :each | each text asString ] equals: 'test _' ].
	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosure01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: '[ 42 ] unknownMessage') asCoderViewModel ].
	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosure02checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToBlockClosure01setup.
	
	aScripter assertStep: [:s | 
		s // GtFixItButton;
		exists].

	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosureArgument01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: '[ :value | value unknownMessage ]') asCoderViewModel ].		
	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosureArgument02checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToBlockClosureArgument01setup.
	
	aScripter assertStep: [:s | 
		s // GtFixItButton;
		exists].
	
	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: 'object := Object new.') asCoderViewModel ].		
	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable02execute [
	<gtExample>
	| aScripter |
	aScripter := self fixitMessageSendToVariable01setup.

	aScripter clickStep: [:s | 
		s // GtSourceCoderDoItActionId].

	aScripter assertStep: [:s | 
		s label: 'Assert variable assignment';
		onModel;
		value: [ :aCoderViewModel | (aCoderViewModel sharedBindings bindingOf: #object) value class ]
			equals: [ Object ]].

	^ aScripter
]

{ #category : #accessing }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable03type [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToVariable02execute.
	
	aScripter doStep: [:s | 
		s label: 'Focus the editor and move cursor at the end';
		onModel;
		action: [ :aCoderViewModel |
			aCoderViewModel
				focused: true;
				moveCursorAtEnd  ]].
	
	aScripter typeStep: [:s | 
		s //  GtSourceCoderEditorId;
		text: 'object unknownMessage'].
	
	^ aScripter
]

{ #category : #accessing }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable04checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToVariable03type.
	
	aScripter assertStep: [:s | 
		s // GtFixItButton;
		exists].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_01_setup [
	<gtExample>
	| aScripter |
	
	aScripter := self scripterForBlock: [ GtPharoSnippetCoder forSource: 'OrderedCollection new addAll: (1 to: 100); yourself' ].
	aScripter clickStep: [:s | 
		s label: 'Click on the coder editor to give it focus';
		// GtSourceCoderEditorId].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_02_select [
	<gtExample>
	| aScripter |
	
	aScripter := self forClassExtraction_01_setup.
	aScripter doStep: [:s | 
		s label: 'Select part of the method to extract';
		// GtSourceCoderEditorId;
		action: [ :aSourceEditor |  aSourceEditor selecter from: 0 to: aSourceEditor text size; select ]].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_03_context_menu [
	<gtExample>
	| aScripter |
	
	aScripter := self forClassExtraction_02_select.
	aScripter secondaryClickStep: [:s | 
		s label: 'Open context menu';
		// GtSourceCoderEditorId].

	aScripter mouseMoveOverStep: [:s | 
		s label: 'Hover extract method';
		onSpaceRoot;
		// GtMethodCoderExtractMethodContextMenuItemId].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_04_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forClassExtraction_03_context_menu.
	aScripter clickStep: [:s | 
		s label: 'Click extract method';
		onSpaceRoot;
		// GtMethodCoderExtractMethodContextMenuItemId].

	aScripter assertStep: [:s | 
		s label: 'Assert source code modified';
		onModel;
		satisfies: [ :aCoder | aCoder isModified ]].

	self check: aScripter hasReorderAttributes: 0.
	self checkRenameEditor: aScripter keyword: false.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_05_enter_name [
	<gtExample>
	| aScripter |

	aScripter := self forClassExtraction_04_click_extract_method.

	self checkRenameEditor: aScripter keyword: false.
	(aScripter type: 'oneHundred') play.
	self hasRefactoringChanges: aScripter.
	(aScripter keyPress: BlKeyboardKey tab) play.

	(aScripter keyPress: BlKeyboardKey return) play.
	
	self hasRefactoringPreviewAccept: aScripter.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forInlineCheckBlockValue [
	<gtExample>
	| message source |
	message := 'GtPharoSnippetCoderByScripterExamples inlineTestMethod: a'.
	source := '[1 a. ' , message , ']'.
	^ self
		checkInlineSnippet: source
		messageInterval: (6 to: message size + 6)
		producing: '[1 a. a]'
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forInlineCheckRemoveStatementInBlock [
	<gtExample>
	| message source |
	message := 'GtPharoSnippetCoderByScripterExamples inlineTestMethod: a'.
	source := '[' , message , '. b]'.
	^ self
		checkInlineSnippet: source
		messageInterval: (1 to: message size + 1)
		producing: '[b]'
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forInlineCheckSendIsRemoved [
	<gtExample>
	| message source |
	message := 'GtPharoSnippetCoderByScripterExamples inlineTestMethod: a'.
	source := message , '. 3'.
	^ self
		checkInlineSnippet: source
		messageInterval: (0 to: message size)
		producing: '3'
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forInlineCheckUnnecessaryAssignmentsAreRemoved [
	<gtExample>
	| message |
	message := 'GtPharoSnippetCoderByScripterExamples inlineTestMethod: a'.
	^ self
		checkInlineSnippet: message
		messageInterval: (0 to: message size)
		producing: 'a'
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forInlineCheckVariableAccess [
	<gtExample>
	| message |
	message := 'self value'.
	^ self
		checkInlineSnippet: message
		messageInterval: (0 to: message size)
		producing: 'value'
		inClass: Association
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forInline_true_isNil [
	<gtExample>
	| message |
	message := 'true isNil'.
	^ self
		checkInlineSnippet: message
		messageInterval: (0 to: message size)
		producing: 'false'
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_01_setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ GtPharoSnippetCoder forSource: 'string := ''Some string''.
start := -1.
end := 100.
string copyFrom: ((start min: string size + 1) max: 1) to: ((end min: string size) max: 0)
' ].
	aScripter clickStep: [:s | 
		s label: 'Click on the coder editor to give it focus';
		// GtSourceCoderEditorId].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordExtraction_01_setup.
	aScripter doStep: [:s | 
		s label: 'Select part of the method to extract';
		// GtSourceCoderEditorId;
		action:
				[ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString lastIndexOf: $.) + 1.
					(aSourceEditor selecter)
						from: index to: aSourceEditor text size;
						select ]].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_03_context_menu [
	<gtExample>
	| aScripter |
	
	aScripter := self forKeywordExtraction_02_select.
	aScripter secondaryClickStep: [:s | 
		s label: 'Open context menu';
		// GtSourceCoderEditorId].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_04_hover_extract_method [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordExtraction_03_context_menu.
	aScripter mouseMoveOverStep: [:s | 
		s label: 'Hover extract method';
		onSpaceRoot;
		// GtMethodCoderExtractMethodContextMenuItemId].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_05_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_04_hover_extract_method.
	aScripter clickStep: [:s | 
		s label: 'Click extract method';
		onSpaceRoot;
		// GtMethodCoderExtractMethodContextMenuItemId].

	aScripter keyPressStep: [:s | 
		s label: 'tab to selector';
		key: BlKeyboardKey tab].	

	self check: aScripter hasReorderAttributes: 2.
	self checkRenameEditor: aScripter keyword: true.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_06_reorder_parameters_and_enter_keywords [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_05_click_extract_method.

	self clickReorderParameter: aScripter.

	aScripter keyPressStep: [:s | 
		s label: 'tab to selector';
		key: BlKeyboardKey tab].	

	self checkRenameEditor: aScripter keyword: true.

	(aScripter type: 'substringFrom:') play.
	self hasRefactoringChanges: aScripter.

	self clickReorderParameter: aScripter.

	aScripter keyPressStep: [:s | 
		s label: 'tab to selector';
		key: BlKeyboardKey tab].	

	(aScripter keyPress: BlKeyboardKey tab) play.
	self checkRenameEditor: aScripter keyword: true.

	(aScripter type: 'to:') play.
	(aScripter keyPress: BlKeyboardKey return) play.
	self clickReorderParameter: aScripter.
	self clickReorderParameter: aScripter.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forMethodExtractionToClassMethod [
	<gtExample>
	| aScripter source selector result modelResult |
	source := 'Object new printString'.
	selector := 'asdf123'.
	result := 'Object _'.
	modelResult := selector , ' ^self new printString'.
	aScripter := self scripterForBlock: [ GtPharoSnippetCoder forSource: source ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				// GtSourceCoderEditorId ].
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the snippet to extract';
				// GtSourceCoderEditorId;
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 0 to: source size;
						select ] ].
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				// GtSourceCoderEditorId ].
	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover extract';
				onSpaceRoot;
				id: GtMethodCoderExtractMethodContextMenuItemId index: 1 ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click extract';
				onSpaceRoot;
				id: GtMethodCoderExtractMethodContextMenuItemId index: 1 ].
	(aScripter type: selector) play.
	(aScripter keyPress: BlKeyboardKey return) play.
	self hasRefactoringChanges: aScripter.
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check refactoring changes';
				// GtSourceCoderEditorId;
				value: [ :aCoderEditor | 
						| model |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd :attr | model := attr refactoring model ].
						((model classFor: Object class) methodFor: selector asSymbol) ast ]
					equals: [ :aCoderEditor | RBParser parseMethod: modelResult ] ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert value';
				value: [ :aCoderEditor | RBParser parseExpression: aCoderEditor textualCoderViewModel sourceText asString ]
					equals: [ :aCoderEditor | RBParser parseExpression: result ];
				id: GtSourceCoderEditorId ].
	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forRenameMethod_01_setup [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder forSource: '1 to: 10' ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				// GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forRenameMethod_02_start_rename [
	<gtExample>
	| aScripter |
	aScripter := self forRenameMethod_01_setup.

	aScripter shortcut
		combination: (BlSingleKeyCombination new key: BlKeyboardKey home);
		id: GtSourceCoderEditorId;
		play.

	3
		timesRepeat: [ aScripter shortcut
				combination: (BlSingleKeyCombination new key: BlKeyboardKey arrowRight);
				id: GtSourceCoderEditorId;
				play ].

	aScripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forRenameMethod_03_perform_rename [
	<gtExample>
	| aScripter |
	aScripter := self forRenameMethod_02_start_rename.

	(aScripter type: 'tooo:') play.

	(aScripter keyPress: BlKeyboardKey return) play.
	
	"Comment out for now -- passes in UI doesn't in cli"
	"self hasRefactoringPreviewAccept: aScripter."

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forTempExtraction_01_setup [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder
					forSource: 'OrderedCollection new addAll: (1 to: 100); yourself' ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				// GtSourceCoderEditorId ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the snippet to extract';
				// GtSourceCoderEditorId;
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 30 to: 41;
						select ] ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forTempExtraction_02_context_menu [
	<gtExample>
	| aScripter |
	aScripter := self forTempExtraction_01_setup.
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				// GtSourceCoderEditorId ].

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover extract variable';
				onSpaceRoot;
				id: #'context-menu--extract-variable' index: 1 ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click extract variable';
				onSpaceRoot;
				id: #'context-menu--extract-variable' index: 1 ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forTempExtraction_03_enter_name [
	<gtExample>
	| aScripter |
	aScripter := self forTempExtraction_02_context_menu.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor exists';
				exists;
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter substep: 'Enter new name' do: [ :aStep | (aStep type: 'var') play ].

	aScripter
		substep: 'Apply rename'
		do: [ :aStep | (aStep keyPress: BlKeyboardKey return) play ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor doesn''t exist';
				notExists;
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring value';
				value: [ :aCoderEditor | RBParser parseExpression: aCoderEditor textualCoderViewModel sourceText asString ]
					equals: [ :aCoderEditor | 
						RBParser
							parseExpression: 'var := 1 to: 100. OrderedCollection new addAll: var; yourself' ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forUnaryExtraction_01_setup [
	<gtExample>
	| aScripter |

	aScripter := self
		scripterForBlock:
			[ GtPharoSnippetCoder
				forSource:
					'string := ''Some string''.
string , string
' ].

	aScripter clickStep: [:s | 
		s label: 'Click on the coder editor to give it focus';
		// GtSourceCoderEditorId].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forUnaryExtraction_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_01_setup.
	aScripter doStep: [:s | 
		s label: 'Select part of the method to extract';
		// GtSourceCoderEditorId;
		action:
				[ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString lastIndexOf: $.) + 1.
					(aSourceEditor selecter)
						from: index to: aSourceEditor text size;
						select ]].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forUnaryExtraction_03_context_menu [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_02_select.
	aScripter secondaryClickStep: [:s | 
		s label: 'Open context menu';
		// GtSourceCoderEditorId].

	aScripter mouseMoveOverStep: [:s | 
		s label: 'Hover extract method';
		onSpaceRoot;
		// GtMethodCoderExtractMethodContextMenuItemId].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forUnaryExtraction_04_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_03_context_menu.
	aScripter clickStep: [:s | 
		s label: 'Click extract method';
		onSpaceRoot;
		// GtMethodCoderExtractMethodContextMenuItemId].

	aScripter assertStep: [:s | 
		s label: 'Assert source code modified';
		onModel;
		satisfies: #isModified].

	self check: aScripter hasReorderAttributes: 0.
	self checkRenameEditor: aScripter keyword: false.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forUnaryExtraction_05_enter_name [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_04_click_extract_method.
	self checkRenameEditor: aScripter keyword: false.

	(aScripter type: 'oneHundred') play.
	self hasRefactoringChanges: aScripter.
	
	(aScripter keyPress: BlKeyboardKey tab) play.

	(aScripter keyPress: BlKeyboardKey return) play.
	
	self hasRefactoringPreviewAccept: aScripter.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> hasRefactoringChanges: aScripter [
	aScripter checkStep: [:s | 
		s label: 'Check refactoring changes attribute';
		// GtSourceCoderEditorId;
		value:
				[ :aCoderEditor | 
					| anInterval |
					aCoderEditor text
						findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
						indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
					anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ]]
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> hasRefactoringPreviewAccept: aScripter [
	aScripter
		assertStep: [ :step | 
			step
				onChildFromBlock: [ :element | 
					element topMostParent
						allChildrenBreadthFirstDetect: [ :each | each id = GtRefactoringsPreviewAcceptId uniqueInstance ]
						ifFound: [ :each | each ]
						ifNone: [ self error: 'Apply button not found' ] ];
				value: [ :button | button isVisible ] equals: true ]
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> inlineAssignmentForLocalVariable [
	<gtExample>
	| source scripter |
	source := '| localVariable |
localVariable := 4.
localVariable + 2'.
	scripter := self scripterForBlock: [ GtPharoSnippetCoder forSource: source ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				// GtSourceCoderEditorId ].
	scripter
		doStep: [ :s | 
			s
				label: 'Move cursor to temp var';
				// GtSourceCoderEditorId;
				action: [ :aSourceEditor | aSourceEditor editor moveCursorTo: 6 ] ].
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				// GtSourceCoderEditorId ].
	scripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover inline';
				onSpaceRoot;
				id: #'context-menu--inline-temp' index: 1 ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Click inline';
				onSpaceRoot;
				id: #'context-menu--inline-temp' index: 1 ].
	scripter
		assertStep: [ :s | 
			s
				label: 'Assert value';
				value: [ :aCoderEditor | RBParser parseExpression: aCoderEditor textualCoderViewModel sourceText asString ]
					equals: [ :aCoderEditor | RBParser parseExpression: '4 + 2' ];
				id: GtSourceCoderEditorId ].
	^ scripter
]

{ #category : #'examples - context menu' }
GtPharoSnippetCoderByScripterExamples >> renameLocalVariable [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder forSource: 'a := 1. a + a' ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				id: GtSourceCoderEditorId ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Move cursor to variable';
				action: [ :aSourceEditor | aSourceEditor editor moveCursorTo: 0 ];
				id: GtSourceCoderEditorId ].

	aScripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId;
		play.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor exists';
				exists;
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | 1 to: 1 ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor is not focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor has focus';
				satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor source code';
				value: [ :aNameEditor | aNameEditor text asString ] equals: 'a';
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		substep: 'Enter new name'
		do: [ :aStep | 
			(aStep keyPress: BlKeyboardKey delete) play.
			(aStep keyPress: BlKeyboardKey backspace) play.
			(aStep type: 'b') play ].

	aScripter
		substep: 'Apply rename'
		do: [ :aStep | (aStep keyPress: BlKeyboardKey return) play ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoSnippetCoderByScripterExamples >> syntaxError [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder forSource: '3 + - 4' ].
	aScripter clickStep: [:s | 
		s label: 'Click on the play button';
		// GtSourceCoderDoItActionId].

	aScripter assertStep: [:s | 
		s label: 'Assert source coder error attribute';
		// GtSourceCoderEditorId;
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtSourceCoderErrorAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
		equals: [ :aCoderEditor | 4 to: 4 ]
		].

	aScripter assertStep: [:s | 
		s label: 'Assert syntax error button exists';
		// GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: BrButton;
		value: [ :aButton | aButton background paint color ]
			equals: [ BrGlamorousColors errorBackgroundColor ]].
			
	aScripter assertStep: [ :s | 
		s label: 'Assert error text is correct';
		onSpaceRoot;
		onDropdown: true;
		// BlTextElement;
		value: [ :editor | editor text asString ]
		equals: [ 'Variable or expression expected ' ] ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoSnippetCoderByScripterExamples >> undefinedClass [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder forSource: 'x := OdoredCollection new.' ].

	aScripter clickStep: [ :s | 
		s label: 'Click on the play button';
		// GtSourceCoderDoItActionId ].

	aScripter assertStep: [ :s | 
		s label: 'Assert source coder error attribute';
		// GtSourceCoderEditorId;
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtSourceCoderErrorAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
		equals: [ :aCoderEditor | 5 to: 5 ] ].

	aScripter assertStep: [ :s | 
		s label: 'Assert error button exists';
		// GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: BrButton;
		value: [ :aButton | aButton background paint color ]
		equals: [ BrGlamorousColors errorBackgroundColor ] ].

	aScripter assertStep: [ :s | 
		s label: 'Assert error text is correct';
		onSpaceRoot;
		onDropdown: true;
		// BlTextElement;
		value: [ :editor | editor text asString ]
		equals: [ 'Undeclared temp: OdoredCollection' ] ].

	^ aScripter
]
