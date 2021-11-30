Extension { #name : #GtPharoVariableNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoVariableNode >> completionActionStreamFor: aStrategy [
	| prefix variables allLocalVariables |
	self name stopPosition = aStrategy index ifFalse: [ ^ #() asAsyncStream ].
	prefix := name source.
	allLocalVariables := aStrategy localVariablesFor: self.
	^ ((allLocalVariables asyncStreamStartingWith: prefix) merge: (aStrategy variables asyncStreamStartingWith: prefix))
		collect:
			[ :each | 
			GtInsertTextCompletionAction
				labeled: each
				completion: (each allButFirst: prefix size)
				position: aStrategy index ]
]
