Extension { #name : #GtPharoProgramNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoProgramNode >> actionForSelector: aSymbol startingWith: aString at: anInteger needsParensKeywords: aBoolean [
	| isKeyword isBinary actionClass action |
	isKeyword := aSymbol last = $:.
	isBinary := aSymbol asSymbol isBinary.
	actionClass := isKeyword
		ifTrue: [ GtKeywordCompletionAction ]
		ifFalse: [ isBinary
				ifTrue: [ GtBinaryCompletionAction ]
				ifFalse: [ GtInsertTextCompletionAction ] ].
	action := actionClass
		labeled: aSymbol
		completion: (aSymbol allButFirst: aString size)
		position: anInteger.
	((isKeyword or: [ isBinary ]) and: [ aBoolean ])
		ifTrue: [ action addParenthesesBefore: self startPosition ].
	^ action
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoProgramNode >> completeVariable: token for: aStrategy [
	| allLocalVariables prefix |
	prefix := token source.
	allLocalVariables := aStrategy localVariablesFor: self.
	^ (((allLocalVariables asyncStreamStartingWith: prefix) merge: (aStrategy variables asyncStreamStartingWith: prefix))
		collect:
			[ :each | 
			GtInsertTextCompletionAction
				labeled: each
				completion: (each allButFirst: prefix size)
				position: aStrategy index ])
		merge:
			(((aStrategy variables asyncStreamStartingWith: '')
				filter: [ :each | (each beginsWith: prefix) not and: [ aStrategy isSubsequence: prefix of: each ] ])
				collect:
					[ :each | 
					(GtCompositeCompletionAction labeled: each)
						addAction:
								(GtDeleteTextCompletionAction
										labeled: ''
										from: token startPosition
										to: token stopPosition);
						addAction:
								(GtInsertTextCompletionAction
										labeled: each
										completion: each
										position: token startPosition - 1) ])
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoProgramNode >> completionActionStreamFor: aStrategy [
	((self comments ifNil: [ #() ]) anySatisfy: [ :each | aStrategy index between: each first and: each last ])
		ifFalse:
			[ self
				nodesDo:
					[ :each | 
					((each isKindOf: GtPharoProgramNode) and: [ aStrategy index between: each startPosition and: each stopPosition ])
						ifTrue: [ ^ each completionActionStreamFor: aStrategy ] ] ].
	^ #() asAsyncStream
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoProgramNode >> localVariables [
	| variables |

	variables := GtPrefixTree new.
	self localVariablesInto: variables.

	^ variables
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoProgramNode >> messageCompletionsSendTo: receiver matching: aToken withParens: needsParensForKeyword for: strategy [
	| index |
	index := strategy index.
	^ ((strategy selectorStreamForReceiver: (receiver guessType: strategy) matching: aToken source)
		collect:
			[ :each | 
			receiver
				actionForSelector: each
				startingWith: aToken source
				at: index
				needsParensKeywords: needsParensForKeyword ])
		merge:
			(((strategy selectorStreamForReceiver: (receiver guessType: strategy) matching: '')
				filter: [ :each | (each beginsWith: aToken source) not and: [ strategy isSubsequence: aToken source of: each ] ])
				collect:
					[ :each | 
					(GtCompositeCompletionAction labeled: each)
						addAction:
								(GtDeleteTextCompletionAction
										labeled: ''
										from: aToken startPosition
										to: aToken stopPosition);
						addAction:
								(receiver
										actionForSelector: each
										startingWith: ''
										at: aToken startPosition - 1
										needsParensKeywords: needsParensForKeyword) ])
]
