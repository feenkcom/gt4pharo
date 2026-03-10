Extension { #name : #RBRenameVariableChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtChangedObject [
	^ self changeClass
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtClassChangeGroup [
	^ GtRBClassChangeGroup named: self changeClassName
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtDefaultClassFilterName [
	^ super gtDefaultClassFilterName
		ifNil: [ self changeClass ifNotNil: [ :cls | cls name ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtIsForClassHierarchy: aSymbol [
	^ (self gtIs: self changeClassName inSameHierarchyWith: aSymbol)
		or: [ self changes anySatisfy: [ :each | each gtIsForClassHierarchy: aSymbol ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtIsForClassNamed: aSymbol [
	^ self changeClassName = aSymbol
		or: [ self changes anySatisfy: [ :each | each gtIsForClassNamed: aSymbol ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> isBasicChange [
	^ true
]
