Extension { #name : #RBRenameVariableChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameVariableChange >> isBasicChange [
	^ true
]
