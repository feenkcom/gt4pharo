Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> completionActionStreamFor: strategy [
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index ifFalse: [ ^ #() asAsyncStream ].
	startingText := selectorPart source.
	^ ((strategy selectorStreamForReceiver: (parent receiver guessType: strategy) matching: startingText)
		collect:
			[ :each | 
			parent
				actionForSelector: each
				startingWith: startingText
				at: index
				needsParensKeywords: parent parent needsParenthesisForKeyword ])
		merge:
			(((strategy selectorStreamForReceiver: (parent receiver guessType: strategy) matching: '')
				filter: [ :each | (each beginsWith: startingText) not and: [ strategy isSubsequence: startingText of: each ] ])
				collect:
					[ :each | 
					(GtCompositeCompletionAction labeled: each)
						addAction:
								(GtDeleteTextCompletionAction
										labeled: ''
										from: self selectorPart startPosition
										to: self selectorPart stopPosition);
						addAction:
								(parent
										actionForSelector: each
										startingWith: ''
										at: self selectorPart startPosition - 1
										needsParensKeywords: parent parent needsParenthesisForKeyword) ])
]
