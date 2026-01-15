Extension { #name : #RBRenameVariableChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtClassChangeGroup [
	^ GtRBClassChangeGroup named: self changeClassName
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
