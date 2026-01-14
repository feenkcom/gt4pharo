Extension { #name : #RBAddMethodChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddMethodChange >> gtChangeIcon [
	^ Smalltalk ui icons
		iconNamed: ((self changeClass notNil
				and: [ self changeClass includesSelector: self selector ])
				ifTrue: [ #changeUpdate ]
				ifFalse: [ #changeAdd ])
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddMethodChange >> gtIncludesSubstring: aString [
	^ (super gtIncludesSubstring: aString)
		or: [ self source includesSubstring: aString caseSensitive: false ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddMethodChange >> gtIsForSelector: aSymbol [
	^ self selector = aSymbol
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddMethodChange >> gtMethodChangeGroup [
	^ GtRBMethodChangeGroup named: self displayClassName , '>>' , self selector
]
