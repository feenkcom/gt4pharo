Extension { #name : #RBAddPackageChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddPackageChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeAdd
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddPackageChange >> packageName [
	^ packageName
]
