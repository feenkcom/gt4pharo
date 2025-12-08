Extension { #name : #GtPharoVariableNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoVariableNode >> completionActionStreamFor: aStrategy [
	^ self completeVariable: name for: aStrategy
]
