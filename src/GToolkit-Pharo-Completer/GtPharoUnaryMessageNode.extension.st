Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> completionActionStreamFor: strategy [
	^ self
		messageCompletionsSendTo: self receiver
		matching: selectorPart
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
