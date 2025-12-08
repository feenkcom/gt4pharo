Extension { #name : #GtPharoProgramNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoProgramNode >> actionForSelector: aSymbol startingWith: aString at: anInteger strategy: aStrategy [
	| isKeyword isBinary actionClass action |
	isKeyword := aSymbol last = $:.
	isBinary := aSymbol asSymbol isBinary.
	actionClass := isKeyword
		ifTrue: [ GtKeywordCompletionAction ]
		ifFalse: [ isBinary ifTrue: [ GtBinaryCompletionAction ] ifFalse: [ GtInsertTextCompletionAction ] ].
	action := actionClass
		labeled: (aStrategy labelFor: aSymbol withSearch: aString)
		completion: (aSymbol allButFirst: aString size)
		position: anInteger.
	^ action
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoProgramNode >> completeVariable: token for: aStrategy [
	| allLocalVariables prefix stream compositeTree |
	prefix := token source.
	allLocalVariables := aStrategy localVariablesFor: self.
	compositeTree := GtCompositePrefixTree
			trees: {allLocalVariables.
					aStrategy variables}.
	aStrategy wasRequested
		ifFalse: [ ((compositeTree includes: prefix)
				or: [ GtPharoIndex current globalCache includes: prefix ])
				ifTrue: [ ^ #() asAsyncStream ] ].
	stream := (((((compositeTree
			asyncStreamStartingWith: prefix
			caseSensitive: true)
			merge: (compositeTree asyncStreamStartingWith: prefix caseSensitive: false))
			merge: (GtPharoIndex current asyncClassNamesForWord: prefix))
			merge: ((aStrategy variables asyncStreamStartingWith: '')
					filter: [ :each | 
						(each beginsWith: prefix) not
							and: [ aStrategy isCamelCaseSubsequence: prefix of: each ] ]))
			merge: ((aStrategy variables asyncStreamStartingWith: '')
					filter: [ :each | (each beginsWith: prefix) not and: [ aStrategy isSubsequence: prefix of: each ] ]))
			withoutDuplicates useContentComparison.
	^ stream
		collect: [ :each | 
			(each beginsWith: prefix)
				ifTrue: [ GtInsertTextCompletionAction
						labeled: (aStrategy labelFor: each withSearch: prefix)
						completion: (each allButFirst: prefix size)
						position: aStrategy index ]
				ifFalse: [ (GtCompositeCompletionAction
						labeled: (aStrategy labelFor: each withWords: prefix))
						addAction: (GtDeleteTextCompletionAction
								labeled: ''
								from: token startPosition
								to: token stopPosition);
						addAction: (GtInsertTextCompletionAction
								labeled: each
								completion: each
								position: token startPosition - 1) ] ]
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
GtPharoProgramNode >> mergeKeywordCompletionsWith: completionsStream from: aMessage matching: aToken preferKeywords: aBoolean for: strategy [
	| keywordStream keywords cachedCompletions cachedKeywords |
	keywords := aMessage keywordArrayWithToken: aToken.
	keywordStream := (GtPharoIndex current asyncKeywordImplementorsFor: keywords)
			collect: [ :each | 
				GtKeywordPartCompletionAction
					on: aToken
					forMessage: aMessage
					completing: each ].
	cachedCompletions := completionsStream cached.
	cachedKeywords := keywordStream cached.
	^ ((aBoolean
		ifTrue: [ #() asAsyncStream ]
		ifFalse: [ cachedCompletions asyncSimilarCopy take: 6 ])
		merge: (((cachedKeywords asyncSimilarCopy take: 10)
				merge: cachedCompletions asyncSimilarCopy)
				merge: cachedKeywords asyncSimilarCopy)) withoutDuplicates
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoProgramNode >> messageCompletionsSendTo: receiver matching: aToken parentMessage: aMessage for: strategy [
	| index type name completionsStream replacementsStream wordSelectorStream |
	index := aToken stopPosition.
	type := receiver guessType: strategy.
	name := aToken source.
	strategy wasRequested
		ifFalse: [ (type
				ifNil: [ (GtPharoIndex current implementersOf: name) notEmpty ]
				ifNotNil: [ type canUnderstand: name asSymbol ])
				ifTrue: [ ^ #() asAsyncStream ] ].
	completionsStream := (strategy selectorStreamForReceiver: type matching: name)
			collect: [ :each | 
				receiver
					actionForSelector: each
					startingWith: name
					at: index
					strategy: strategy ].
	wordSelectorStream := (strategy
			selectorStreamForReceiver: type
			matchingWords: name) cached.
	aMessage
		ifNotNil: [ completionsStream := self
					mergeKeywordCompletionsWith: completionsStream
					from: aMessage
					matching: aToken
					preferKeywords: (type notNil and: [ type includesBehavior: BlockClosure ])
					for: strategy ].
	replacementsStream := wordSelectorStream
			collect: [ :each | 
				(GtCompositeCompletionAction labeled: (strategy labelFor: each withWords: name))
					addAction: (GtDeleteTextCompletionAction
							labeled: ''
							from: aToken startPosition
							to: aToken stopPosition);
					addAction: (receiver
							actionForSelector: each
							startingWith: ''
							at: aToken startPosition - 1
							strategy: strategy) ].
	^ completionsStream merge: replacementsStream
]
