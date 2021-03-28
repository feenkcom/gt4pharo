Extension { #name : #GtPharoVariableNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoVariableNode >> completionActionsFor: aStrategy [
	| prefix variables allLocalVariables |
	self name stopPosition = aStrategy index
		ifFalse: [ ^ #() ].
	prefix := name source.
	allLocalVariables := aStrategy localVariablesFor: self.
	variables := allLocalVariables
		first: aStrategy maxItems
		startingWith: prefix.
	variables
		addAll:
			(aStrategy variables
				first: aStrategy maxItems - variables size
				startingWith: prefix).
	^ variables
		collect: [ :each | 
			GtInsertTextCompletionAction
				labeled: each
				completion: (each allButFirst: prefix size)
				position: aStrategy index ]
]
