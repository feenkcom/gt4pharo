Extension { #name : #GtPharoVariableNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoVariableNode >> completionActionStreamFor: aStrategy [
	| prefix allLocalVariables |
	self name stopPosition = aStrategy index ifFalse: [ ^ #() asAsyncStream ].
	prefix := name source.
	allLocalVariables := aStrategy localVariablesFor: self.
	^ (((allLocalVariables asyncStreamStartingWith: prefix) merge: (aStrategy variables asyncStreamStartingWith: prefix))
		collect:
			[ :each | 
			GtInsertTextCompletionAction
				labeled: each
				completion: (each allButFirst: prefix size)
				position: aStrategy index ])
		merge:
			(((aStrategy variables asyncStreamStartingWith: '')
				filter: [ :each | (each beginsWith: prefix) not and: [ aStrategy isSubsequence: prefix of: each ] ])
				collect:
					[ :each | 
					(GtCompositeCompletionAction labeled: each)
						addAction:
								(GtDeleteTextCompletionAction
										labeled: ''
										from: self name startPosition
										to: self name stopPosition);
						addAction:
								(GtInsertTextCompletionAction
										labeled: each
										completion: each
										position: self name startPosition - 1) ])
]
