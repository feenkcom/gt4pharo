Extension { #name : #RBRefactoryClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtIsForClassNamed: aSymbol [
	^ self changeClassName = aSymbol
		or: [ self changeClassName size = (aSymbol size + 6)
				and: [ (self changeClassName beginsWith: aSymbol)
						and: [ self changeClassName endsWith: ' class' ] ] ]
]
