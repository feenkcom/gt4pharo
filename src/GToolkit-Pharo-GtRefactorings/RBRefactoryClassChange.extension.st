Extension { #name : #RBRefactoryClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtClassChangeGroup [
	^ GtRBClassChangeGroup named: self changeClassName
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtIncludesSubstring: aString [
	^ (super gtIncludesSubstring: aString)
		or: [ self changeClassName includesSubstring: aString caseSensitive: false ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtIsForClassNamed: aSymbol [
	^ self changeClassName = aSymbol
]
