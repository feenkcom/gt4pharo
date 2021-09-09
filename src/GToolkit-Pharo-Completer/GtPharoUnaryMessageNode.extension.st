Extension { #name : 'GtPharoUnaryMessageNode' }

{ #category : '*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> completionActionsFor: strategy [
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index
		ifFalse: [ ^ #() ].
	startingText := selectorPart source.
	^ (strategy
		selectorsForReceiver: (parent receiver guessType: strategy)
		matching: startingText)
		collect: [ :each | 
			parent
				actionForSelector: each
				startingWith: startingText
				at: index
				needsParensKeywords: parent parent needsParenthesisForKeyword ]
]
