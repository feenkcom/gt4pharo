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

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> receiver [
	((parent isKindOf: GtPharoMessageSendNode)
		or: [ parent isKindOf: GtPharoCascadeNode ]) ifTrue: [ ^ parent receiver ].
	(parent isKindOf: SmaCCErrorNode)
		ifTrue: [ (parent stackContents notEmpty
				and: [ parent stackContents first isArray
						and: [ parent stackContents first first isKindOf: GtPharoProgramNode ] ])
				ifTrue: [ ^ parent stackContents first first ] ].
	^ (self nodeOfType: GtPharoValueNode) ifNil: [ self ]
]
