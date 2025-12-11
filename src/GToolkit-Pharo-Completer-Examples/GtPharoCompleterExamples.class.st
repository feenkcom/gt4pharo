Class {
	#name : #GtPharoCompleterExamples,
	#superclass : #GtCompleterControllerExamples,
	#category : #'GToolkit-Pharo-Completer-Examples'
}

{ #category : #smalltalk }
GtPharoCompleterExamples >> binaryCompletion [
	<gtExample>
	| text strategy |
	text := 'foo ^3 <'.
	strategy := self smalltalkStrategy.
	self
		assert:
			(strategy
				completionActionStreamFor: text asRopedText
				at: text size
				requested: true) isNotEmpty wait.
	^ strategy
]

{ #category : #'private-source' }
GtPharoCompleterExamples >> checkCompletionsIn: aString areSameAs: selectors [
	| items |
	items := (self completionStreamFor: aString) toArray wait.
	self assert: items size equals: selectors size.
	self
		assert: (items allSatisfy: [ :each | selectors includes: each label asString asSymbol ]).
	^ items
]

{ #category : #'private-source' }
GtPharoCompleterExamples >> checkCompletionsIn: aString areSupersetOf: selectors [
	| items itemsSelectors |
	items := (self completionStreamFor: aString) toArray wait.
	itemsSelectors := items collect: [ :each | each label asString asSymbol ].
	self assert: itemsSelectors size >= selectors size.
	self assert: (selectors allSatisfy: [ :each | itemsSelectors includes: each ]).
	^ items
]

{ #category : #'private-source' }
GtPharoCompleterExamples >> checkCompletionsIn: aString contains: completionString [
	| stream |
	stream := self completionStreamFor: aString.
	self
		assert: ((stream asyncSimilarCopy take: 30) toArray wait
				anySatisfy: [ :each | each label = completionString ]).
	^ stream
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> clickingSelectedCompletionItemTriggersCompletion [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.
	(aScripter keyPress: BlKeyboardKey return) play.
	(aScripter keyPress: BlKeyboardKey tab) play.
	self enterText: 'is' in: aScripter.
	self openCompletionIn: aScripter.
	aScripter
		checkStep: [ :s | 
			s
				label: 'Verify first item selected';
				onSpaceRoot;
				id: #'completion-list';
				satisfies: [ :element | element selectedIndices asArray = #(1) ] ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click first item';
				onSpaceRoot;
				id: #'completion-list';
				onBreadthFirstChildOfClass: BrLabel ].
	aScripter
		checkStep: [ :s | 
			s
				label: 'Verify completion popup has closed';
				onSpaceRoot;
				id: #'completion-list';
				notExists ].
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check text was updated with completion';
				do: [ :element | self assert: (element text asString endsWith: 'isMethod') ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeAddHelpAction [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ aStream add: 1 help: 3 action: 4' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			13 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'add:icon:help:action:keyText:' in: aScripter.
	self completeWithTabIn: aScripter.
	self enterText: '2' in: aScripter.
	(aScripter keyPress: BlKeyboardKey tab) play.
	self enterText: '5' in: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | 
					element text asString
						= 'printOn: aStream ^ aStream add: 1 icon: 2 help: 3 action: 4 keyText: 5' ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeAddHelpKeyText [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ aStream add: 1 help: 3 keyText: 5' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			13 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'add:icon:help:action:keyText:' in: aScripter.
	self completeWithTabIn: aScripter.
	self enterText: '2' in: aScripter.
	(aScripter keyPress: BlKeyboardKey tab) play.
	self enterText: '4' in: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | 
					element text asString
						= 'printOn: aStream ^ aStream add: 1 icon: 2 help: 3 action: 4 keyText: 5' ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeCascade [
	<gtExample>
	| selectors cSelectors |
	selectors := ProtoObject allSelectors.
	cSelectors := selectors select: [ :each | each first = $c ].
	
	self
		checkCompletionsIn: 'a
				ProtoObject new printString; `'
		areSameAs: selectors.
	
	self
		checkCompletionsIn: 'a
				ProtoObject new printString; c`'
		areSupersetOf: cSelectors.

	self
		checkCompletionsIn: 'a
				ProtoObject new printString;`'
		areSameAs: selectors.

	self
		checkCompletionsIn: 'a
				ProtoObject new ` printString; printOn: b'
		areSameAs: selectors.
	
	self
		checkCompletionsIn: 'a
				ProtoObject new c` printString; printOn: b'
		areSupersetOf: cSelectors.

	self
		checkCompletionsIn: 'a
				ProtoObject new printString; ` printOn: b'
		areSameAs: selectors.

	self
		checkCompletionsIn: 'a
				ProtoObject new printString; printOn: b;`'
		areSameAs: selectors.
	
	self
		checkCompletionsIn: 'a
				ProtoObject new printString; printOn: b; c`'
		areSupersetOf: cSelectors.

	^ self
		checkCompletionsIn: 'a
				ProtoObject new printString; printOn: b; `'
		areSameAs: selectors
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeFirstKeywordToMultipleKeywords [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ 4 prOn:' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			2 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'printOn:base:' in: aScripter.
	self completeWithTabIn: aScripter.
	self enterText: 'aStream' in: aScripter.
	(aScripter keyPress: BlKeyboardKey tab) play.
	self enterText: '2' in: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | element text asString = 'printOn: aStream ^ 4 printOn: aStream base: 2' ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeFullSelector [
	<gtExample>
	| aScripter text |
	aScripter := self completeFullVariableName.
	self enterText: ' ' in: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				do: [ :element | text := element text asString ] ].

	self openCompletionIn: aScripter.
	self completeWithTabIn: aScripter.
	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | element text asString ~= text ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeFullVariableName [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ' in: aScripter.
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'aStream' in: aScripter.
	self completeWithTabIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | (element text asString allRangesOfSubstring: 'aStream') size = 2 ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeIconHelpAction [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ aStream icon: 2 help: 3 action: 4' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			13 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'add:icon:help:action:keyText:' in: aScripter.
	self completeWithTabIn: aScripter.
	self enterText: '1' in: aScripter.
	(aScripter keyPress: BlKeyboardKey tab) play.
	self enterText: '5' in: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | 
					element text asString
						= 'printOn: aStream ^ aStream add: 1 icon: 2 help: 3 action: 4 keyText: 5' ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeInMiddleOfMessage [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ 4 prOn' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			2 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'printOn:' in: aScripter.
	self completeWithTabIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | (element text asString allRangesOfSubstring: 'printOn:') size = 2 ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeInMiddleOfVariable [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ SmaInt' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			3 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'SmallInteger' in: aScripter.
	self completeWithTabIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | (element text asString allRangesOfSubstring: 'SmallInteger') size = 1 ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeInstanceVariableReceiver [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.
	(aScripter keyPress: BlKeyboardKey return) play.
	(aScripter keyPress: BlKeyboardKey tab) play.
	self enterText: 'is' in: aScripter.
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'isMethod' in: aScripter.
	self completeWithTabIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				do: [ :element | 
					self
						assert: element text asString lines
						equals: self instanceVariableReceiverSource lines ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeKeywordWithMultipleParts [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ aStream ifPresent: [:e | e] ifAbsent: []' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			5 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'at:ifPresent:ifAbsent:' in: aScripter.
	self completeWithTabIn: aScripter.
	self enterText: '1' in: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | 
					element text asString
						= 'printOn: aStream ^ aStream at: 1 ifPresent: [:e | e] ifAbsent: []' ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeLastKeywordToMultipleKeywords [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ aStream onCharacters: ''3''' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			5 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'addEdgeTo:onCharacters:' in: aScripter.
	self completeWithTabIn: aScripter.
	self enterText: '1' in: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | 
					element text asString
						= 'printOn: aStream ^ aStream addEdgeTo: 1 onCharacters: ''3''' ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeMessageAtEndOfIncompleteBlock [
	<gtExample>
	
	^ self
		checkCompletionsIn:
			'a
				self ifNil: [self printOn`'
		contains: 'printOn:'
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeMessageBetweenStatements [
	<gtExample>
	
	^ self
		checkCompletionsIn:
			'a
				| a b |
				a := 1.
				a printOn`
				b := 2'
		contains: 'printOn:'
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeMessageInsideKeywordAtEndOfIncompleteBlock [
	<gtExample>
	
	^ self
		checkCompletionsIn:
			'a
				self ifNil: [self a: 1 b: self printOn`'
		contains: 'printOn:'
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeMultipleKeywordMessageSend [
	<gtExample>
	| aScripter |
	aScripter := self completeInstanceVariableReceiver.
	self enterText: ' ifTr' in: aScripter.
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'ifTrue:ifFalse:' in: aScripter.
	self completeWithTabIn: aScripter.
	self enterText: '[^1]' in: aScripter.
	(aScripter keyPress: BlKeyboardKey tab) play.
	self enterText: '[^2]' in: aScripter.
	aScripter
		checkStep: [ :s | 
			s
				do: [ :element | 
					self
						assert: element text asString lines
						equals: (self instanceVariableReceiverSource , ' ifTrue: [^1] ifFalse: [^2]') lines ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completePartialKeywordWithMultiplePartsAndMissingArg [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ aStream at: 1 ifPrese: ifAbsent: []' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			14 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'at:ifPresent:ifAbsent:' in: aScripter.
	self completeWithTabIn: aScripter.
	self enterText: '[:e | e]' in: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | 
					element text asString
						= 'printOn: aStream ^ aStream at: 1 ifPresent: [:e | e] ifAbsent: []' ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completePartialKeywordWithMultiplePartsNoMissingArg [
	<gtExample>
	| aScripter |
	aScripter := self openCompletionForPartialKeywordWithMultiplePartsNoMissingArg.
	self selectionCompletionItem: 'at:ifPresent:ifAbsent:' in: aScripter.
	self completeWithTabIn: aScripter.
	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | 
					element text asString
						= 'printOn: aStream ^ aStream at: 1 ifPresent: [:e | e] ifAbsent: []' ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completePragmaAtStart [
	<gtExample>
	| code stream |
	code := 'a <  self foo'.
	stream := self smalltalkStrategy
			completionActionStreamFor: code asRopedText
			at: 3
			requested: true.
	self
		assert: (stream asyncSimilarCopy
				select: [ :each | each displayText asString = 'gtExample' ]) hasNext wait.
	self
		assert: (stream asyncSimilarCopy
				select: [ :each | each displayText asString = 'return:' ]) hasNext wait.
	^ stream
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completePragmaInKeyword [
	<gtExample>
	| code stream |
	code := 'a <g  self foo'.
	stream := self smalltalkStrategy
			completionActionStreamFor: code asRopedText
			at: 4
			requested: true.
	self
		assert: (stream asyncSimilarCopy
				select: [ :each | each displayText asString = 'gtExample' ]) hasNext wait.
	self
		assert: (stream asyncSimilarCopy
				select: [ :each | each displayText asString = 'return:' ]) hasNext wait not.
	^ stream
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completePrintOnMethodSelector [
	<gtExample>
	| aScripter text |
	aScripter := self openCompletionForPrinMethodSelector.
	text := 'printOn:'.
	self selectionCompletionItem: text in: aScripter.
	self completeWithTabIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | element text asString beginsWith: text ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeVariableAtEndOfIncompleteBlock [
	<gtExample>
	
	^ self
		checkCompletionsIn:
			'a
				| zxcv |
				self ifNil: [zx`'
		contains: 'zxcv'
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeVariableBetweenStatements [
	<gtExample>
	
	^ self
		checkCompletionsIn:
			'a
				| zxcv a b |
				a := 1.
				zx`
				b :+ 2'
		contains: 'zxcv'
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeVariableFromBinding [
	<gtExample>
	| aScripter aCompletionController anEditor strategy bindings name |
	aScripter := BlScripter new.
	anEditor := BrEditor new
			aptitude: BrGlamorousCodeEditorAptitude new + BrGlamorousTextAreaSpacingAptitude new;
			text: ''.
	strategy := self smalltalkStrategy.
	strategy isMethod: false.
	strategy hasImplicitVariables: true.
	bindings := GtSharedVariablesBindings new.
	name := #someUniqueVariableName.
	bindings bindings at: name put: 'value'.
	strategy bindings: bindings.
	aCompletionController := GtCompletionController on: anEditor strategy: strategy.
	aCompletionController install.
	aScripter element: anEditor.
	aScripter
		clickStep: [ :s | 
			s
				label: 'focus editor' ].

	self openCompletionIn: aScripter.
	self selectionCompletionItem: name asString in: aScripter.
	self completeWithTabIn: aScripter.
	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | element text asString = name asString ] ].

	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> completeVariableInsideIncompleteBlock [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' self do: [:each | e' in: aScripter.
	self openCompletionIn: aScripter.
	self selectionCompletionItem: 'each' in: aScripter.
	self completeWithTabIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :element | (element text asString allRangesOfSubstring: 'each') size = 2 ] ].

	^ aScripter
]

{ #category : #'private-scripting' }
GtPharoCompleterExamples >> completeWithTabIn: aScripter [
	(aScripter keyPress: BlKeyboardKey tab) play
]

{ #category : #'private-source' }
GtPharoCompleterExamples >> completionStreamFor: aString [
	| text strategy |
	text := (aString copyReplaceAll: '`' with: '') asRopedText.
	strategy := self smalltalkStrategy.
	^ strategy
		completionActionStreamFor: text
		at: (aString indexOf: $`) - 1
		requested: true
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> crLfMessageCompletion [
	<gtExample>
	
	| text strategy items |
	text := ('foo' , String crlf , '^3 ab') asRopedText.
	strategy := self smalltalkStrategy.
	items := strategy
		completionActionStreamFor: text
		at: 10
		requested: true.
	self assert: ((items take: 30) toArray wait anySatisfy: [ :each | each label = 'abs' ]).
	^ strategy
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> emptyExplicitlyRequestedCompletions [
	<gtExample>
	
	| text strategy index |
	text := '  "<"method:  "<"arg  "<"
		| var1 |
		var1  "<":= #().
		self inform: var1 size.
		^var1 size * 3'.
	strategy := self smalltalkStrategy.
	index := 1.
	[ (index := (text indexOfSubCollection: '"<"' startingAt: index) + 1) > 1 ]
		whileTrue:
			[ self
				assert:
					(strategy
						completionActionStreamFor: text asRopedText
						at: index - 2
						requested: true) isNotEmpty wait not ].
	^ strategy
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> endingStatementRequestedCompletions [
	<gtExample>
	
	| text strategy index |
	text := 'method: arg 
		| var1 |
		var1  := #()  "<".
		self inform: var1 size  "<".
		^var1 size * 3  "<"'.
	strategy := self smalltalkStrategy.
	index := 1.
	[ (index := (text indexOfSubCollection: '"<"' startingAt: index) + 1) > 1 ]
		whileTrue:
			[ | actions |
			actions := strategy
				completionActionStreamFor: text asRopedText
				at: index - 2
				requested: true.
			self assert: actions asyncSimilarCopy isNotEmpty wait.
			self
				assert:
					((actions take: 30) toArray wait anySatisfy: [ :each | (each label includes: $:) or: [ each label asSymbol isBinary ] ]).
			self
				assert:
					(strategy
						completionActionStreamFor: text asRopedText
						at: index - 2
						requested: false) isNotEmpty wait not ].
	^ strategy
]

{ #category : #'private-scripting' }
GtPharoCompleterExamples >> enterText: aString in: aScripter [
	(aScripter type: aString) play
]

{ #category : #'private-source' }
GtPharoCompleterExamples >> instanceVariableReceiverSource [
	^ self printOnMethodSelectorSource
		,
			'
	isMethod'
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> methodSourceCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy method ast |
	text := '' asRopedText.
	text attribute: (BlFontSizeAttribute size: 14) beNotOverwritableByStyler.
	method := OrderedCollection >> #addAll:.
	ast := GtPharoParser parse: method sourceCode.
	styler := GtPharoCompleterExamplesMethodBodyTextStyler new.
	styler classOrMetaClass: method methodClass.
	styler methodPatternSource: ast pattern source.
	editor := BrTextEditorModel new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	editorElement editor: editor.
	completionStrategy := GtPharoCompletionStrategy new.
	completionStrategy classOrMetaClass: method methodClass.
	completionStrategy methodPattern: ast pattern.
	completionController := GtCompletionController
			on: editorElement
			strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> openCompletionForPartialKeywordWithMultiplePartsNoMissingArg [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ aStream at: 1 ifPrese: [:e | e] ifAbsent: []' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			23 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	^ aScripter
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> openCompletionForPrinMethodSelector [
	<gtExample>
	| aScripter |
	aScripter := self smalltalkCompletionMethodEditor.
	self enterText: 'prin' in: aScripter.
	self openCompletionIn: aScripter.
	^ aScripter
]

{ #category : #'private-scripting' }
GtPharoCompleterExamples >> openCompletionIn: aScripter [
	(aScripter keyDown: BlKeyboardKey controlLeft) play.
	(aScripter keyPress: BlKeyboardKey space) play.
	(aScripter keyUp: BlKeyboardKey controlLeft) play.
	aScripter
		checkStep: [ :s | 
			s
				label: 'Verify first item selected';
				onSpaceRoot;
				satisfies: [ :element | 
					(Delay forMilliseconds: 50) wait.
					true ] ].
	aScripter wait forEmptySpaceTaskQueue play
]

{ #category : #'private-source' }
GtPharoCompleterExamples >> printOnMethodSelectorSource [
	^ 'printOn: aStream'
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> returnPragma [
	<gtExample>
	<return: #GtPharoCompleterExamples>
	| selectors retSelectors |
	selectors := self class allSelectors.
	retSelectors := selectors
			select: [ :e | (e asString asLowercase beginsWith: 'ret') or: [ e includesSubstring: 'Ret' ] ].

	self
		checkCompletionsIn: 'a
				GtPharoCompleterExamples new returnPragma `'
		areSameAs: selectors.

	self
		checkCompletionsIn: 'a
				GtPharoCompleterExamples new returnPragma ret`'
		areSameAs: retSelectors
]

{ #category : #'private-scripting' }
GtPharoCompleterExamples >> secondaryKey [
	^ (OSPlatform current secondaryModifier includes: BlKeyboardKey controlLeft)
		ifTrue: [ BlKeyboardKey controlLeft ]
		ifFalse: [ BlKeyboardKey altLeft ]
]

{ #category : #'private-scripting' }
GtPharoCompleterExamples >> selectionCompletionItem: text in: aScripter [
	aScripter
		checkStep: [ :s | 
			s
				onSpaceRoot;
				id: #'completion-list';
				do: [ :element | 
					| items item i |
					i := 1.
					items := element items.
					[ item isNil and: [ i <= items size ] ]
						whileTrue: [ (items at: i) label = text
								ifTrue: [ item := items at: i ]
								ifFalse: [ i := i + 1 ] ].
					self assert: item notNil.
					element selectOne: i ] ]
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> smalltalkCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy |
	text := '' asRopedText.
	text attributes: {(BlFontSizeAttribute size: 14) beNotOverwritableByStyler}.
	styler := BrRBTextStyler new.
	styler classOrMetaClass: GtPharoCompletionStrategy.
	editor := BrTextEditorModel new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	editorElement editor: editor.
	completionStrategy := self smalltalkStrategy.
	completionController := GtCompletionController
			on: editorElement
			strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #'private-scripting' }
GtPharoCompleterExamples >> smalltalkCompletionMethodEditor [
	| aCompletionController anEditor aScripter |
	aScripter := BlScripter new.
	anEditor := BrEditor new
			aptitude: BrGlamorousCodeEditorAptitude new + BrGlamorousTextAreaSpacingAptitude new;
			text: ''.
	aCompletionController := GtCompletionController
			on: anEditor
			strategy: self smalltalkStrategy.
	aCompletionController install.
	aScripter element: anEditor.
	aScripter
		clickStep: [ :s | 
			s
				label: 'focus editor' ].
	^ aScripter
]

{ #category : #strategies }
GtPharoCompleterExamples >> smalltalkStrategy [
	<gtExample>
	| completionStrategy |
	completionStrategy := GtPharoCompletionStrategy newForMethod.
	completionStrategy classOrMetaClass: GtPharoCompletionStrategy.
	^ completionStrategy
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> startingStatementRequestedCompletions [
	<gtExample>
	
	| text strategy index |
	text := 'method: arg 
		| var1 |
		 "<"
		var1  := #().  "<"
		self inform: var1 size.  "<"
		^var1 size * 3'.
	strategy := self smalltalkStrategy.
	index := 1.
	[ (index := (text indexOfSubCollection: '"<"' startingAt: index) + 1) > 1 ]
		whileTrue:
			[ | actions |
			actions := strategy
				completionActionStreamFor: text asRopedText
				at: index - 2
				requested: true.
			self assert: actions isNotEmpty wait.
			self
				assert:
					(strategy
						completionActionStreamFor: text asRopedText
						at: index - 2
						requested: false) isNotEmpty wait not ].
	^ strategy
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> subsequenceVariableCompletion [
	<gtExample>
	
	| text strategy items |
	text := ('foo' , String crlf , '^GtPharoCompEx') asRopedText.
	strategy := self smalltalkStrategy.
	items := strategy
		completionActionStreamFor: text
		at: text size
		requested: true.
	self assert: ((items take: 30) toArray wait anySatisfy: [ :each | each label = 'GtPharoCompleterExamples' ]).
	^ strategy
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> tryCompleteOnInvalidKeyword [
	<gtExample>
	| aScripter |
	aScripter := self completePrintOnMethodSelector.

	self enterText: ' ^ aStream at: 1 remove: 2' in: aScripter.
	aScripter
		substep: 'Move cursor'
		do: [ :aStep | 
			3 timesRepeat: [ aStep keyPress: BlKeyboardKey arrowLeft ].
			aStep play ].
	self openCompletionIn: aScripter.
	aScripter
		checkStep: [ :s | 
			s
				notExists;
				onSpaceRoot;
				id: #'completion-list' ].

	^ aScripter
]
