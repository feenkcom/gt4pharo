Class {
	#name : #GtPharoSnippetCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> check: aScripter hasReorderAttributes: anInteger [
	<gtExample>
	aScripter check
		label: 'Check reorder attributes';
		value: [ :aCoderEditor |
				| count |
				count := 0.
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtReorderParametersAttribute ]
					indicesDo: [ :aStart :anEnd | count := count + 1. ].
				count ]
			equals: [ :aCoderEditor | anInteger ];
		id: GtSourceCoderEditorId;
		play
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> checkExtractedSource: aScripter [
	| text variables possibleSelectors |
	variables := #(string start end).
	possibleSelectors := #(#_:_: #substringFrom:_: #substringFrom:to:).

	aScripter check
		label: 'Check text';
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
										and: [ messageSend arguments allSatisfy: [ :each | variables includes: each variableName ] ] ] ] ];
		id: GtSourceCoderEditorId;
		play.
	^ text
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> checkRenameEditor: aScripter keyword: aBoolean [
	<gtExample>
	| selectorPart |
	selectorPart := aBoolean ifTrue: [ '_:' ] ifFalse: [ '_' ].
	aScripter check
		label: 'Check rename editor attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval ifNil: [ anInterval := aStart to: anEnd ] ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString indexOfSubCollection: selectorPart.
				index to: index + selectorPart size - 1 ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check method name editor selected text';
		value: [ :focus | focus focusOwner class ] equals: GtRenameEditor;
		onFocusProcessor;
		play.

	aScripter check
		label: 'Check method name editor source code';
		value: [ :focus | focus focusOwner text asString ] equals: '_';
		onFocusProcessor;
		play.

	aScripter check
		label: 'Check method name editor selected text';
		value: [ :focus | focus focusOwner editor selectedText asString ] equals: '_';
		onFocusProcessor;
		play
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> clickReorderParameter: aScripter [
	| text |
	text := self checkExtractedSource: aScripter.
	
	aScripter click
		label: 'Open context menu';
		id: #'reorder-parameter-button';
		play.
	
	aScripter check
		label: 'Check selected text';
		elementSatisfies:
				[ :aSourceEditor | 
					| string |
					string := aSourceEditor text asString.
					text ~= string ];
		id: GtSourceCoderEditorId;
		play.

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

	aScripter assert
		label: 'Assert Triggered Spawn Object Event';
		satisfies: [ :theScripter | 
			theScripter events reversed
				detectEventOfClass: GtPhlowObjectToSpawn
				ifFound: [ :theEvent | theEvent object = Object ]
				ifNone: [ AssertionFailure
						signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
		onScripter;
		play.

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
	
	aScripter assert
		onBreadthFirstChildOfClass: GtFixItButton;
		exists;
		play.

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
	
	aScripter assert
		onBreadthFirstChildOfClass: GtFixItButton;
		exists;
		play.
	
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

	aScripter click
		id: GtSourceCoderDoItActionId;
		play.

	aScripter assert
		label: 'Assert variable assignment';
		value: [ :aCoderViewModel | (aCoderViewModel sharedBindings bindingOf: #object) value class ]
			equals: [ Object ];
		onModel;
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable03type [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToVariable02execute.
	
	aScripter do
		label: 'Focus the editor and move cursor at the end';
		action: [ :aCoderViewModel |
			aCoderViewModel
				focused: true;
				moveCursorAtEnd  ];
		onModel;
		play.
	
	aScripter type
		text: 'object unknownMessage';
		id: GtSourceCoderEditorId;
		play.
	
	^ aScripter
]

{ #category : #accessing }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable04checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToVariable03type.
	
	aScripter assert
		onBreadthFirstChildOfClass: GtFixItButton;
		exists;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_01_setup [
	<gtExample>
	| aScripter |
	
	aScripter := self scripterForBlock: [ GtPharoSnippetCoder forSource: 'OrderedCollection new addAll: (1 to: 100); yourself' ].
	aScripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_02_select [
	<gtExample>
	| aScripter |
	
	aScripter := self forClassExtraction_01_setup.
	aScripter do
		label: 'Select part of the method to extract';
		action: [ :aSourceEditor |  aSourceEditor selecter from: 0 to: aSourceEditor text size; select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_03_context_menu [
	<gtExample>
	| aScripter |
	
	aScripter := self forClassExtraction_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	aScripter mouseMoveOver
		label: 'Hover extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forClassExtraction_04_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forClassExtraction_03_context_menu.
	aScripter click
		label: 'Click extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

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

	^ aScripter
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
	(aScripter click)
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordExtraction_01_setup.
	aScripter do
		label: 'Select part of the method to extract';
		action:
				[ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString lastIndexOf: $.) + 1.
					(aSourceEditor selecter)
						from: index to: aSourceEditor text size;
						select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_03_context_menu [
	<gtExample>
	| aScripter |
	
	aScripter := self forKeywordExtraction_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_04_hover_extract_method [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordExtraction_03_context_menu.
	aScripter mouseMoveOver
		label: 'Hover extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_05_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_04_hover_extract_method.
	aScripter click
		label: 'Click extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	aScripter keyPress
		key: BlKeyboardKey tab;
		play.	"tab to selector"

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

	aScripter keyPress
		key: BlKeyboardKey tab;
		play.	"tab to selector"

	self checkRenameEditor: aScripter keyword: true.

	(aScripter type: 'substringFrom:') play.
	self hasRefactoringChanges: aScripter.

	self clickReorderParameter: aScripter.

	aScripter keyPress
		key: BlKeyboardKey tab;
		play.	"tab to selector"

	(aScripter keyPress: BlKeyboardKey tab) play.
	self checkRenameEditor: aScripter keyword: true.

	(aScripter type: 'to:') play.
	(aScripter keyPress: BlKeyboardKey return) play.
	self clickReorderParameter: aScripter.
	self clickReorderParameter: aScripter.

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

	aScripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forUnaryExtraction_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_01_setup.
	aScripter do
		label: 'Select part of the method to extract';
		action:
				[ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString lastIndexOf: $.) + 1.
					(aSourceEditor selecter)
						from: index to: aSourceEditor text size;
						select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forUnaryExtraction_03_context_menu [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	aScripter mouseMoveOver
		label: 'Hover extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forUnaryExtraction_04_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_03_context_menu.
	aScripter click
		label: 'Click extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

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

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> hasRefactoringChanges: aScripter [
	(aScripter check)
		label: 'Check refactoring changes attribute';
		value:
				[ :aCoderEditor | 
					| anInterval |
					aCoderEditor text
						findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
						indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
					anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId
]

{ #category : #'examples - context menu' }
GtPharoSnippetCoderByScripterExamples >> renameLocalVariable [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder forSource: 'a := 1. a + a' ].
	aScripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	aScripter do
		label: 'Move cursor to variable';
		action: [ :aSourceEditor | aSourceEditor editor moveCursorTo: 0 ];
		id: GtSourceCoderEditorId;
		play.

	aScripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert rename editor exists';
		exists;
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter assert
		label: 'Assert rename editor attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 1 to: 1 ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert method name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: 'a';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

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
		// BrAnchoredElement;
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
		// BrAnchoredElement;
		// BlTextElement;
		value: [ :editor | editor text asString ]
		equals: [ 'Undeclared temp: OdoredCollection' ] ].

	^ aScripter
]
