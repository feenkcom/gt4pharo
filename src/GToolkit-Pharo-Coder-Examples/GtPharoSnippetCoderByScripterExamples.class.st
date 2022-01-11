Class {
	#name : #GtPharoSnippetCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> check: aScripter hasReorderAttributes: anInteger [
	aScripter check
		label: 'Check reorder attributes';
		value: [ :aCoderEditor |
				| count |
				count := 0.
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtExtractMethodReorderParametersAttribute ]
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
	| selectorPart |
	selectorPart := aBoolean ifTrue: [ '_:' ] ifFalse: [ '_' ].
	aScripter check
		label: 'Check rename editor attribute';
		value:
				[ :aCoderEditor | 
					| anInterval |
					aCoderEditor text
						findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
						indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
					anInterval ]
			equals:
				[ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString indexOfSubCollection: selectorPart.
				index to: index + selectorPart size - 1 ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check refactoring changes attribute';
		value:
				[ :aCoderEditor | 
					| anInterval |
					aCoderEditor text
						findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
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
		label: 'Check method name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: selectorPart;
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter check
		label: 'Check method name editor selected text';
		value: [ :aNameEditor | aNameEditor editor selectedText asString ] equals: selectorPart;
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter check
		label: 'Check method name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
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
	self check: aScripter hasReorderAttributes: 4
]

{ #category : #'examples - context menu' }
GtPharoSnippetCoderByScripterExamples >> contextMenuInspect [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ GtPharoSnippetCoder forSource: 'Object new' ].
	self selectTextFor: aScripter from: 0 to: 6 andCheck: 'Object'.
	
	self openAndClickOnContextMenuItemFor: aScripter id: GtSourceCoderDoItAndGoActionId.
	
	aScripter check 
		label: 'Check Triggered Spawn Object Event';
		satisfies: [ :theScripter | theScripter events reversed 
			detectEventOfClass: GtPhlowObjectToSpawn
			ifFound: [ :theEvent |
				theEvent object = Object ]
			ifNone: [ AssertionFailure signal: GtPhlowObjectToSpawn name, ' event was not found' ]  ];
		onScripter;
		play.	

	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosure01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: '[ 42 ] unknownMessage') asCoderUIModel ].
	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosure02checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToBlockClosure01setup.
	
	aScripter check
		onBreadthFirstChildOfClass: GtFixItButton;
		exists;
		play.

	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosureArgument01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: '[ :value | value unknownMessage ]') asCoderUIModel ].		
	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosureArgument02checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToBlockClosureArgument01setup.
	
	aScripter check
		onBreadthFirstChildOfClass: GtFixItButton;
		notExists;
		play.
	
	^ aScripter
]

{ #category : #'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: 'object := Object new.') asCoderUIModel ].		
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

	aScripter check
		label: 'Check variable assignment';
		value: [ :aCoderViewModel | (aCoderViewModel sharedBindings bindingOf: #object) value class ] equals: [ Object ];
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
		onModel.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter type
		text: 'object unknownMessage';
		id: GtSourceCoderEditorId.
		
	aScripter wait forEmptySpaceTaskQueue.
	
	^ aScripter syncContinue
]

{ #category : #accessing }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable04checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToVariable03type.
	
	aScripter check
		onBreadthFirstChildOfClass: GtFixItButton;
		exists.
	
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
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

	aScripter check
		label: 'Check source code modified';
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
	(aScripter keyClick: BlKeyboardKey tab) play.

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

	aScripter check
		label: 'Check source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	self check: aScripter hasReorderAttributes: 4.
	self checkRenameEditor: aScripter keyword: true.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoSnippetCoderByScripterExamples >> forKeywordExtraction_06_reorder_parameters_and_enter_keywords [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordExtraction_05_click_extract_method.
	
	self clickReorderParameter: aScripter.
	self checkRenameEditor: aScripter keyword: true.
	
	(aScripter type: 'substringFrom:') play.
	self hasRefactoringChanges: aScripter.
	
	(aScripter keyClick: BlKeyboardKey tab) play.
	self clickReorderParameter: aScripter.
	self checkRenameEditor: aScripter keyword: true.
	
	(aScripter type: 'to:') play.
	(aScripter keyClick: BlKeyboardKey return) play.
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

	aScripter check
		label: 'Check source code modified';
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
	
	(aScripter keyClick: BlKeyboardKey tab) play.

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

	aScripter := self scripterForBlock: [ GtPharoSnippetCoder forSource: 'a := 1. a + a' ].
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

	aScripter wait forEmptySpaceTaskQueue.
	aScripter check
		label: 'Check rename editor exists';
		exists;
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.
	
	aScripter check
		label: 'Check rename editor attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | 1 to: 1 ];
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
		label: 'Check method name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: 'a';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter
		substep: 'Enter new name'
		do: [ :aStep | 
			(aStep keyClick: BlKeyboardKey delete) play.
			(aStep keyClick: BlKeyboardKey backspace) play.
			(aStep type: 'b') play ].

	aScripter
		substep: 'Apply rename'
		do: [ :aStep | (aStep keyClick: BlKeyboardKey return) play ].

	^ aScripter
]
