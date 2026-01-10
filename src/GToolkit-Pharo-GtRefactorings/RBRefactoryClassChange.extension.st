Extension { #name : #RBRefactoryClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtIncludesSubstring: aString [
	^ (super gtIncludesSubstring: aString)
		or: [ self changeClassName includesSubstring: aString caseSensitive: false ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtIsForClassNamed: aSymbol [
	^ self changeClassName = aSymbol
		or: [ self changeClassName size = (aSymbol size + 6)
				and: [ (self changeClassName beginsWith: aSymbol)
						and: [ self changeClassName endsWith: ' class' ] ] ]
]
