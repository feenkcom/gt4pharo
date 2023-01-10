Extension { #name : #GtPharoErrorNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoErrorNode >> completeToken: aToken at: anInteger for: aStrategy [
	| previousItem |
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
			(each isKindOf: OrderedCollection)
				ifTrue: [ each do: [ :value | nodeBlock value: value value: 1 ] ]
				ifFalse: [ nodeBlock value: each value: i ] ].
	^ super completionActionStreamFor: aStrategy
]
