Class {
	#name : 'GtPharoSnippetCoderByScripterExamples',
	#superclass : 'Object',
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : 'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : 'examples - context menu' }
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
		onScripter.	

	^ aScripter
]

{ #category : 'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosure01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: '[ 42 ] unknownMessage') asCoderViewModel ].		
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : 'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosure02checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToBlockClosure01setup.
	
	aScripter check
		onBreadthFirstChildOfClass: GtFixItButton;
		exists.
	
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : 'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosureArgument01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: '[ :value | value unknownMessage ]') asCoderViewModel ].		
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : 'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToBlockClosureArgument02checkFixitAction [
	<gtExample>
	| aScripter |
	
	aScripter := self fixitMessageSendToBlockClosureArgument01setup.
	
	aScripter check
		onBreadthFirstChildOfClass: GtFixItButton;
		notExists.
	
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : 'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable01setup [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ (GtPharoSnippetCoder forSource: 'object := Object new.') asCoderViewModel ].		
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : 'examples - fixit method' }
GtPharoSnippetCoderByScripterExamples >> fixitMessageSendToVariable02execute [
	<gtExample>
	| aScripter |
	aScripter := self fixitMessageSendToVariable01setup.
	
	aScripter click
		id: GtSourceCoderDoItActionId.
	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check variable assignment';
		value: [ :aCoderViewModel | (aCoderViewModel sharedBindings bindingOf: #object) value class ] equals: [ Object ];
		onModel.
	
	^ aScripter syncContinue
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
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
