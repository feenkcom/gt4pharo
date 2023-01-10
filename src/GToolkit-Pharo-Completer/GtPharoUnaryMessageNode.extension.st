Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> completionActionStreamFor: strategy [
	selectorPart stopPosition = strategy index ifFalse: [ ^ #() asAsyncStream ].
	^ self
		messageCompletionsSendTo: parent receiver
		matching: selectorPart
		withParens: false
		parentMessage: self completionKeywordMessage
		for: strategy
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> completionKeywordMessage [
	| current |
	current := self parent.
	[ current notNil ]
		whileTrue: [ (current isKindOf: GtPharoMessageNode)
				ifTrue: [ current isKeyword ifTrue: [ ^ current ] ]
				ifFalse: [ (current isKindOf: GtPharoMessageSendNode)
						ifTrue: [ (current message isKindOf: GtPharoKeywordMessageNode)
								ifTrue: [ ^ current message ] ]
						ifFalse: [ ^ nil ] ].
			(current isValueNode and: [ current leftParens notEmpty ]) ifTrue: [ ^ nil ].

			current := current parent ].
	^ nil
]
