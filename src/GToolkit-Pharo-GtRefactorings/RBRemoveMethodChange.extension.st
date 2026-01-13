Extension { #name : #RBRemoveMethodChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRemoveMethodChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeRemove
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRemoveMethodChange >> gtIncludesSubstring: aString [
	^ (super gtIncludesSubstring: aString)
		or: [ self selector includesSubstring: aString caseSensitive: false ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRemoveMethodChange >> gtIsForSelector: aSymbol [
	^ self selector = aSymbol
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRemoveMethodChange >> gtMethodChangeGroup [
	^ GtRBMethodChangeGroup named: self displayClassName , '>>' , self selector
]
