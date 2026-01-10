Extension { #name : #RBRefactoryVariableChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryVariableChange >> gtIncludesSubstring: aString [
	^ (super gtIncludesSubstring: aString)
		or: [ self variable includesSubstring: aString caseSensitive: false ]
]
