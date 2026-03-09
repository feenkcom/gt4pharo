Extension { #name : #RBRefactoryClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtChangedObject [
	^ self changeClass
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtClassChangeGroup [
	^ GtRBClassChangeGroup named: self changeClassName
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtDefaultClassFilterName [
	^ super gtDefaultClassFilterName
		ifNil: [ self changeClass ifNotNil: [ :cls | cls name ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtIncludesSubstring: aString [
	^ (super gtIncludesSubstring: aString)
		or: [ self changeClassName includesSubstring: aString caseSensitive: false ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtIsForClassHierarchy: aSymbol [
	^ self gtIs: self changeClassName inSameHierarchyWith: aSymbol
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryClassChange >> gtIsForClassNamed: aSymbol [
	^ self changeClassName = aSymbol
]
