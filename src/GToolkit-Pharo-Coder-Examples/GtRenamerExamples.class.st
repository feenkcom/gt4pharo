Class {
	#name : #GtRenamerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #accessing }
GtRenamerExamples >> applyRename [
	<gtExample>
	| scripter |
	scripter := self startRename.
	scripter
		keyPressStep: [ :s | 
			s
				label: 'Delete char';
				key: BlKeyboardKey backspace ].

	scripter
		keyPressStep: [ :s | 
			s
				label: 'Apply rename';
				key: BlKeyboardKey return ].

	self
		assert: scripter element editor text asString
				= (self methodText copyReplaceAll: 'anInteger' with: 'aInteger').
	^ scripter
]

{ #category : #accessing }
GtRenamerExamples >> cancelRename [
	<gtExample>
	| scripter |
	scripter := self startRename.
	scripter
		keyPressStep: [ :s | 
			s
				label: 'Delete char';
				key: BlKeyboardKey backspace ].

	scripter
		keyPressStep: [ :s | 
			s
				label: 'Cancel rename';
				key: BlKeyboardKey escape ].

	self assert: scripter element editor text asString = self methodText.
	^ scripter
]

{ #category : #examples }
GtRenamerExamples >> methodText [
	^ 'double: anInteger
	^ anInteger + anInteger'
]

{ #category : #examples }
GtRenamerExamples >> scripter [
	<gtExample>
	
	^ BlScripter new
]

{ #category : #examples }
GtRenamerExamples >> smalltalkRenamer [
	<gtExample>
	| text styler editorElement completionStrategy completionController |

	text := self methodText asRopedText.

	styler := BrRBTextStyler new.
	styler classOrMetaClass: GtPharoCompletionStrategy.

	editorElement := GtSourceCoderEditorElement new
		textualCoderViewModel: (GtPharoMethodCoderViewModel new coder: GtPharoMethodCoder new);
		styler: styler;
		text: text;
		fitContent.

	editorElement editor
		addEditorShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination primaryR;
				action: [ :aShortcutEvent | GtRenameAction pharoRenameLocalsOn: aShortcutEvent currentTarget ]).

	completionStrategy := GtPharoCompletionStrategy newForMethod.
	completionStrategy classOrMetaClass: GtPharoCompletionStrategy.
	completionController := GtCompletionController
		on: editorElement
		strategy: completionStrategy.

	completionController install.

	^ editorElement
]

{ #category : #accessing }
GtRenamerExamples >> smalltalkRenamerScripter [
	<gtExample>
	| scripter |
	scripter := self scripter.
	scripter element: self smalltalkRenamer.
	^ scripter pulse
]

{ #category : #accessing }
GtRenamerExamples >> startRename [
	<gtExample>
	| scripter |
	scripter := self smalltalkRenamerScripter.

	scripter requestFocus
		onSelf;
		play.

	scripter
		substep: 'Move cursor'
		do: [ :aStep | 10 timesRepeat: [ (aStep keyPress: BlKeyboardKey arrowRight) play ] ].

	scripter shortcut
		label: 'Start rename';
		combination: BlKeyCombination primaryR;
		play.

	^ scripter
]
