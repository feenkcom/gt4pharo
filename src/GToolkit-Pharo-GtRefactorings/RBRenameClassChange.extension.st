Extension { #name : #RBRenameClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> gtChangedObject [
	^ self changeClass
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> gtClassChangeGroup [
	^ GtRBClassChangeGroup named: newName
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> gtDefaultClassFilterName [
	^ super gtDefaultClassFilterName
		ifNil: [ self changeClass ifNotNil: [ :cls | cls name ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> gtIsForClassHierarchy: aSymbol [
	^ (self gtIs: oldName inSameHierarchyWith: aSymbol)
		or: [ (self gtIs: newName inSameHierarchyWith: aSymbol)
				or: [ self changes anySatisfy: [ :each | each gtIsForClassHierarchy: aSymbol ] ] ]
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
