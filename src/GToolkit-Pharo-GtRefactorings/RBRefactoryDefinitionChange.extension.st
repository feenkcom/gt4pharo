Extension { #name : #RBRefactoryDefinitionChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryDefinitionChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryDefinitionChange >> gtIncludesSubstring: aString [
	^ (super gtIncludesSubstring: aString)
		or: [ self definition includesSubstring: aString caseSensitive: false ]
]
