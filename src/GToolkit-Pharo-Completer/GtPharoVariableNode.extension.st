Extension { #name : #GtPharoVariableNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoVariableNode >> completionActionStreamFor: aStrategy [
	self name stopPosition = aStrategy index ifFalse: [ ^ #() asAsyncStream ].
	^ self completeVariable: name for: aStrategy
]
