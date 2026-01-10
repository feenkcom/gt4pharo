Extension { #name : #RBRemoveClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRemoveClassChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeRemove
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRemoveClassChange >> gtIncludesSubstring: aString [
	^ (super gtIncludesSubstring: aString)
		or: [ self changeClassName includesSubstring: aString caseSensitive: false ]
]
