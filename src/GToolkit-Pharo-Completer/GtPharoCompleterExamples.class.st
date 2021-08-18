Class {
	#name : 'GtPharoCompleterExamples',
	#superclass : 'GtCompleterControllerExamples',
	#category : 'GToolkit-Pharo-Completer-Examples'
}

{ #category : 'smalltalk' }
GtPharoCompleterExamples >> binaryCompletion [
	<gtExample>
	| text strategy |
	text := 'foo ^3 <'.
	strategy := self smalltalkStrategy.
	self
		assert:
			(strategy
				completionActionsFor: text asRopedText
				at: text size
				max: 10
				requested: true) notEmpty.
	^ strategy
]

{ #category : 'smalltalk' }
GtPharoCompleterExamples >> completeInstanceVariableReceiver [
	<gtExample>
	| completer |
	completer := self completePrintOnMethodSelector.
	self
		enter:
			{Character cr.
			Character tab} , #('is' #tabComplete:)
		into: completer.
	self
		assert: completer textEditor text asString
		equals: self instanceVariableReceiverSource.
	^ completer
]

{ #category : 'smalltalk' }
GtPharoCompleterExamples >> completeMultipleKeywordMessageSend [
	<gtExample>
	| completer |
	completer := self completeInstanceVariableReceiver.
	self
		enter:
			#(' prin')
				,
					{[ :controller | self selectPreviewMatching: 'print:on:' in: controller ].
					#tabComplete:}
				, #(#tabNext: 'va' #tabComplete: #tabNext: 'ma' #tabComplete:)
		into: completer.
	self
		assert: completer textEditor text asString
		equals:
			self instanceVariableReceiverSource
				, ' print: maxItems on: variableTypes'.
	self
		assert: (completer textEditor cursors allCursors collect: #position)
		equals: #(42).
	^ completer
]

{ #category : 'smalltalk' }
GtPharoCompleterExamples >> completePrintOnMethodSelector [
	<gtExample>
	| completer |
	completer := self openOn: '' withStrategy: self smalltalkStrategy.
	self
		enter:
			#(0 'prin')
				,
					{[ :controller | self selectPreviewMatching: 'printOn:' in: controller ].
					#tabComplete:}
		into: completer.
	self
		assert: completer textEditor text asString
		equals: self printOnMethodSelectorSource.
	^ completer
]

{ #category : 'smalltalk' }
GtPharoCompleterExamples >> crLfMessageCompletion [
	<gtExample>
	| text strategy items |
	text := ('foo' , String crlf , '^3 ab') asRopedText.
	strategy := self smalltalkStrategy.
	items := strategy
		completionActionsFor: text
		at: 10
		max: 11
		requested: true.
	self assert: (items anySatisfy: [ :each | each label = 'abs' ]).
	^ strategy
]

{ #category : 'smalltalk' }
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
	[ (index := (text indexOfSubCollection: '"<"' startingAt: index) + 1)
		> 1 ]
		whileTrue: [ self
				assert:
					(strategy
						completionActionsFor: text asRopedText
						at: index - 2
						max: 10
						requested: true) isEmpty ].
	^ strategy
]

{ #category : 'smalltalk' }
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
	[ (index := (text indexOfSubCollection: '"<"' startingAt: index) + 1)
		> 1 ]
		whileTrue: [ | actions |
			actions := strategy
				completionActionsFor: text asRopedText
				at: index - 2
				max: 10
				requested: true.
			self assert: actions notEmpty.
			self
				assert:
					(actions
						anySatisfy:
							[ :each | (each label includes: $:) or: [ each label asSymbol isBinary ] ]).
			self
				assert:
					(strategy
						completionActionsFor: text asRopedText
						at: index - 2
						max: 10
						requested: false) isEmpty ].
	^ strategy
]

{ #category : 'private-source' }
GtPharoCompleterExamples >> instanceVariableReceiverSource [
	^ self printOnMethodSelectorSource
		,
			'
	isMethod'
]

{ #category : 'smalltalk' }
GtPharoCompleterExamples >> methodSourceCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy completionController method ast |
	text := '' asRopedText.
	text attribute: (BlFontSizeAttribute size: 14) beNotOverwritableByStyler.
	method := OrderedCollection >> #addAll:.
	ast := GtPharoParser parse: method sourceCode.
	styler := BrRBMethodBodyTextStyler new.
	styler classOrMetaClass: method methodClass.
	styler methodPatternSource: ast pattern source.
	editor := BrTextEditor new.
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
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : 'private-source' }
GtPharoCompleterExamples >> printOnMethodSelectorSource [
	^ 'printOn: aStream'
]

{ #category : 'smalltalk' }
GtPharoCompleterExamples >> smalltalkCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy completionController |
	text := '' asRopedText.
	text
		attributes: { (BlFontSizeAttribute size: 14) beNotOverwritableByStyler }.
	styler := BrRBTextStyler new.
	styler classOrMetaClass: GtPharoCompletionStrategy.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	editorElement editor: editor.
	completionStrategy := self smalltalkStrategy.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : 'strategies' }
GtPharoCompleterExamples >> smalltalkStrategy [
	<gtExample>
	| completionStrategy |
	completionStrategy := GtPharoCompletionStrategy newForMethod.
	completionStrategy classOrMetaClass: GtPharoCompletionStrategy.
	^ completionStrategy
]

{ #category : 'smalltalk' }
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
		whileTrue: [
			| actions |
			
			actions := strategy
				completionActionsFor: text asRopedText
				at: index - 2
				max: 10
				requested: true.

			self assert: actions notEmpty.
			self
				assert:
					(strategy
						completionActionsFor: text asRopedText
						at: index - 2
						max: 10
						requested: false) isEmpty ].
	^ strategy
]
