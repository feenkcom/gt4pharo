Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoUnaryMessageNode >> completionActionStreamFor: strategy [
	selectorPart stopPosition = strategy index ifFalse: [ ^ #() asAsyncStream ].
	^ self
		messageCompletionsSendTo: parent receiver
		matching: selectorPart
		withParens: false
		for: strategy
]
