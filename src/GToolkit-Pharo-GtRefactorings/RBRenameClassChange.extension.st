Extension { #name : #RBRenameClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRenameClassChange >> isBasicChange [
	^ true
]
