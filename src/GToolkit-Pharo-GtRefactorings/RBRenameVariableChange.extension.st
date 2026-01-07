Extension { #name : #RBRenameVariableChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtIsForClassNamed: aSymbol [
	^ (self changeClassName = aSymbol
		or: [ self changeClassName size = (aSymbol size + 6)
				and: [ (self changeClassName beginsWith: aSymbol)
						and: [ self changeClassName endsWith: ' class' ] ] ])
		or: [ self changes anySatisfy: [ :each | each gtIsForClassNamed: aSymbol ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> isBasicChange [
	^ true
]
