Extension { #name : #GtPharoMessageSendNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoMessageSendNode >> completionActionStreamFor: aStrategy [
	| index |
	index := aStrategy index.
	(index > receiver stopPosition and: [ index < message startPosition ])
		ifTrue:
			[ ^ (aStrategy selectorStreamForReceiver: (receiver guessType: aStrategy) matching: '')
				collect:
					[ :each | 
					receiver
						actionForSelector: each
						startingWith: ''
						at: aStrategy index
						needsParensKeywords: true
						strategy: aStrategy ] ].
	^ super completionActionStreamFor: aStrategy
]
