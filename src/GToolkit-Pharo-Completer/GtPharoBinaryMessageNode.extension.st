Extension { #name : #GtPharoBinaryMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoBinaryMessageNode >> completionActionStreamFor: strategy [
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index ifFalse: [ ^ super completionActionStreamFor: strategy ].
	startingText := selectorPart value.
	^ (strategy selectorStreamForReceiver: (parent receiver guessType: strategy) matching: startingText)
		collect:
			[ :each | 
			parent
				actionForSelector: each
				startingWith: startingText
				at: index
				needsParensKeywords:
					((value isKindOf: GtPharoErrorNode) ifTrue: [ parent parent ] ifFalse: [ parent ]) needsParenthesisForKeyword
				strategy: strategy ]
]
