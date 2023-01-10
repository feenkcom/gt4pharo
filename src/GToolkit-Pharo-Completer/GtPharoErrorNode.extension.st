Extension { #name : #GtPharoErrorNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoErrorNode >> completeToken: aToken at: anInteger for: aStrategy [
	| previousItem item |
	anInteger <= 1 ifTrue: [ ^ #() asAsyncStream ].
	previousItem := smaccError stackContents at: anInteger - 1.
	(previousItem isKindOf: GtPharoValueNode)
		ifTrue: [ ^ self
				messageCompletionsSendTo: previousItem
				matching: aToken
				withParens: false
				parentMessage: nil
				for: aStrategy ].
	(previousItem isArray
		and: [ previousItem size = 2
				and: [ (previousItem last isKindOf: OrderedCollection)
						and: [ previousItem last last isKindOf: GtPharoValueNode ] ] ])
		ifTrue: [ ^ self
				messageCompletionsSendTo: previousItem last last
				matching: aToken
				withParens: true
				parentMessage: nil
				for: aStrategy ].
	(aToken source = ';' and: [ anInteger >= 2 ])
		ifTrue: [ item := smaccError stackContents at: anInteger - 1.
			(item isKindOf: Array)
				ifTrue: [ ((item first isKindOf: OrderedCollection)
						and: [ item first notEmpty
								and: [ (item first first isKindOf: SmaCCToken) and: [ item first first source = ';' ] ] ])
						ifTrue: [ item := smaccError stackContents at: anInteger - 2.
							((item isKindOf: Array) and: [ item first isKindOf: GtPharoValueNode ])
								ifTrue: [ ^ (aStrategy
										selectorStreamForReceiver: (item first guessType: aStrategy)
										matching: '')
										collect: [ :each | 
											item first
												actionForSelector: each
												startingWith: ''
												at: aStrategy index
												needsParensKeywords: false
												strategy: aStrategy ] ] ] ] ].
	^ #() asAsyncStream
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoErrorNode >> completionActionStreamFor: aStrategy [
	| nodeBlock |
	nodeBlock := [ :each :i | 
	((each isKindOf: GtPharoProgramNode) and: [ aStrategy index between: each startPosition and: each stopPosition ])
		ifTrue: [ ^ each completionActionStreamFor: aStrategy ].
	((each isKindOf: SmaCCToken) and: [ aStrategy index = each stopPosition ])
		ifTrue:
			[ ^ self
				completeToken: each
				at: i
				for: aStrategy ] ].
	smaccError stackContents
		keysAndValuesDo:
			[ :i :each | 
			(each isKindOf: SequenceableCollection)
				ifTrue: [ each do: [ :value | nodeBlock value: value value: 1 ] ]
				ifFalse: [ nodeBlock value: each value: i ] ].
	^ super completionActionStreamFor: aStrategy
]
