Extension { #name : #GtPharoSequenceNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoSequenceNode >> completionActionStreamFor: aStrategy [
	| statementBefore periodIndex receiver |
	(rightBar notNil and: [ rightBar startPosition >= aStrategy index ]) ifTrue: [ ^ #() asAsyncStream ].
	statements
		do:
			[ :each | (aStrategy index between: each startPosition and: each stopPosition) ifTrue: [ ^ each completionActionStreamFor: aStrategy ] ].
	aStrategy wasRequested ifFalse: [ ^ #() asAsyncStream ].
	statementBefore := statements reversed detect: [ :each | aStrategy index > each stopPosition ] ifNone: [  ].
	statementBefore isNil ifTrue: [ ^ aStrategy variableCompletionActionStreamFor: self ].
	periodIndex := (1 to: periods size) detect: [ :i | (periods at: i) startPosition > aStrategy index ] ifNone: [  ].
	(periodIndex isNil
		or: [ periodIndex > 1 and: [ statementBefore stopPosition < (periods at: periodIndex - 1) startPosition ] ])
		ifTrue:
			[ (periods isEmpty or: [ periods last startPosition < statementBefore stopPosition ])
				ifFalse: [ ^ aStrategy variableCompletionActionStreamFor: self ] ].
	receiver := statementBefore messageReceiver.
	^ (aStrategy selectorStreamForReceiver: (receiver guessType: aStrategy) matching: '')
		collect:
			[ :each | 
			receiver
				actionForSelector: each
				startingWith: ''
				at: aStrategy index
				needsParensKeywords: receiver parent needsParenthesisForKeyword
				strategy: aStrategy ]
]
