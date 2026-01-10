Extension { #name : #RBAddClassChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddClassChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeAdd
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddClassChange >> gtIncludesSubstring: aString [
	^ self definition includesSubstring: aString caseSensitive: false
]
