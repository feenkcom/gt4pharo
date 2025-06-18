Extension { #name : #GtCompositeDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCompositeDefinition >> createRefactoringModel [
	^ Smalltalk createRbNamespace onEnvironment: RBBrowserEnvironment new
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCompositeDefinition >> executeRefactoring: refactoring [
	[ refactoring execute ]
		on: RBRefactoringError
		do: [ :ex | 
			| message |
			message := ex messageText.
			(message endsWith: 'Browse references?')
				ifTrue: [ message := message allButLast: 18 ].
			self inform: message ]
]
