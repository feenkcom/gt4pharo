Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> completionActionStreamFor: strategy [
	| needsParensForKeyword |
	selectorPart stopPosition = strategy index ifFalse: [ ^ #() asAsyncStream ].
	needsParensForKeyword := (parent parent isKindOf: GtPharoProgramNode) and: [ parent parent needsParenthesisForKeyword ].
	^ self
		messageCompletionsSendTo: parent receiver
		matching: selectorPart
		withParens: needsParensForKeyword
		for: strategy
]
