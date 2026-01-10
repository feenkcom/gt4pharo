Extension { #name : #RBRenameClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> gtIsForClassNamed: aSymbol [
	^ (oldName = aSymbol or: [ newName = aSymbol ])
		or: [ self changes anySatisfy: [ :each | each gtIsForClassNamed: aSymbol ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> isBasicChange [
	^ true
]
