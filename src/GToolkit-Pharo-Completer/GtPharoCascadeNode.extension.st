Extension { #name : #GtPharoCascadeNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoCascadeNode >> completionActionStreamFor: aStrategy [
	self
		nodesDo: [ :each | 
			(aStrategy index between: each startPosition and: each stopPosition)
				ifTrue: [ ^ each completionActionStreamFor: aStrategy ] ].
	(aStrategy index > receiver stopPosition
		and: [ aStrategy index < messages last startPosition ])
		ifTrue: [ ^ (aStrategy
				selectorStreamForReceiver: (receiver guessType: aStrategy)
				matching: '')
				collect: [ :each | 
					receiver
						actionForSelector: each
						startingWith: ''
						at: aStrategy index
						needsParensKeywords: receiver parent needsParenthesisForKeyword
						strategy: aStrategy ] ].
	^ #() asAsyncStream
]
