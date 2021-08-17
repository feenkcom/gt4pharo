Extension { #name : 'GtPharoMessageSendNode' }

{ #category : '*GToolkit-Pharo-Completer' }
GtPharoMessageSendNode >> completionActionsFor: aStrategy [
	| index |
	index := aStrategy index.
	(index > receiver stopPosition and: [ index < message startPosition ])
		ifTrue: [ ^ (aStrategy
				selectorsForReceiver: (receiver guessType: aStrategy)
				matching: '')
				collect: [ :each | 
					receiver
						actionForSelector: each
						startingWith: ''
						at: aStrategy index
						needsParensKeywords: true ] ].
	^ super completionActionsFor: aStrategy
]
