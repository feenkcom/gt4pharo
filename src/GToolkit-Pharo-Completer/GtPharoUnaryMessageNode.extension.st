Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> completionActionStreamFor: strategy [
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index ifFalse: [ ^ #() asAsyncStream ].
	startingText := selectorPart source.
	^ (strategy selectorStreamForReceiver: (parent receiver guessType: strategy) matching: startingText)
		collect:
			[ :each | 
			parent
				actionForSelector: each
				startingWith: startingText
				at: index
				needsParensKeywords: parent parent needsParenthesisForKeyword ]
]
