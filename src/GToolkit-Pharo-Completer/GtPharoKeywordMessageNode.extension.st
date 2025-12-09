Extension { #name : #GtPharoKeywordMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoKeywordMessageNode >> completionActionFor: strategy selector: aSymbol withWords: words [
	| composite actions keywords index |
	actions := OrderedCollection new.
	aSymbol isKeyword ifFalse: [ ^ nil ].
	keywords := aSymbol keywords.
	keywords size < self selectorParts size ifTrue: [ ^ nil ].
	index := 1.
	keywords
		do: [ :each | 
			(index <= self selectorParts size
				and: [ each = (self selectorParts at: index) source
						or: [ (strategy index
								between: (self selectorParts at: index) startPosition
								and: (self selectorParts at: index) stopPosition)
								and: [ self does: (self selectorParts at: index) source haveWordsIn: each ] ] ])
				ifTrue: [ (each ~= (self selectorParts at: index) source
						or: [ (self values at: index) isKindOf: GtPharoErrorNode ])
						ifTrue: [ actions
								add: (GtInsertTextCompletionAction
										labeled: ''
										completion: each
												, (((self values at: index) isKindOf: GtPharoErrorNode)
														ifTrue: [ ' _' ]
														ifFalse: [ '' ])
										position: (self selectorParts at: index) startPosition - 1).
							actions
								add: (GtDeleteTextCompletionAction
										labeled: ''
										from: (self selectorParts at: index) startPosition
										to: (self selectorParts at: index) stopPosition) ].
					index := index + 1 ]
				ifFalse: [ index <= self selectorParts size
						ifTrue: [ actions
								add: (GtInsertTextCompletionAction
										labeled: ''
										completion: each , ' _ '
										position: (self selectorParts at: index) startPosition - 1) ]
						ifFalse: [ actions
								add: (GtInsertTextCompletionAction
										labeled: ''
										completion: ' ' , each , ' _'
										position: self stopPosition) ] ] ].
	index <= self selectorParts size ifTrue: [ ^ nil ].
	composite := GtMultiPartKeywordCompletionAction
			labeled: (strategy labelFor: aSymbol withWords: words).
	actions reverseDo: [ :each | composite addAction: each ].
	^ composite
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoKeywordMessageNode >> completionActionStreamFor: strategy [
	selectorParts
		doWithIndex: [ :each :i | 
			(strategy index between: each startPosition and: each stopPosition)
				ifTrue: [ ^ self completionActionStreamFor: strategy andKeyword: i ] ].
	^ super completionActionStreamFor: strategy
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoKeywordMessageNode >> completionActionStreamFor: strategy andKeyword: anInteger [
	| type selector selectorStream actionStream |
	type := self receiver guessType: strategy.
	selector := self selector.
	strategy wasRequested
		ifFalse: [ (type
				ifNil: [ (GtPharoIndex current implementersOf: selector) notEmpty ]
				ifNotNil: [ type canUnderstand: selector ]) ifTrue: [ ^ #() asAsyncStream ] ].
	selectorStream := ((strategy selectorStreamForReceiver: type matching: selector)
			merge: (strategy selectorStreamForReceiver: type matchingWords: selector) cached)
			withoutDuplicates.
	actionStream := selectorStream
			collect: [ :each | 
				self
					completionActionFor: strategy
					selector: each asSymbol
					withWords: selector ].
	^ actionStream select: [ :each | each notNil ]
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoKeywordMessageNode >> does: searchString haveWordsIn: keywordString [
	| searchWords keywordWords |
	searchWords := (GtPharoIndex current wordsIn: searchString)
			asSortedCollection: [ :a :b | a size < b size ].
	keywordWords := (GtPharoIndex current wordsIn: keywordString)
			asSortedCollection: [ :a :b | a size < b size ].
	searchWords
		do: [ :search | 
			| keyword |
			keyword := keywordWords
					detect: [ :each | each beginsWith: search ]
					ifNone: [ ^ false ].
			keywordWords remove: keyword ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoKeywordMessageNode >> keywordArrayWithToken: aToken [
	| hasInserted keywords |
	hasInserted := false.
	keywords := OrderedCollection new.
	self selectorParts
		do: [ :each | 
			hasInserted
				ifFalse: [ aToken startPosition < each startPosition
						ifTrue: [ hasInserted := true.
							keywords add: aToken source ] ].
			keywords add: each source ].
	hasInserted ifFalse: [ keywords add: aToken source ].
	^ keywords
]
