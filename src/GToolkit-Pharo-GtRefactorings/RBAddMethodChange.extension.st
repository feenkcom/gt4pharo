Extension { #name : #RBAddMethodChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAddMethodChange >> gtChangeIcon [
	^ Smalltalk ui icons
		iconNamed: ((self changeClass notNil
				and: [ self changeClass includesSelector: self selector ])
				ifTrue: [ #changeUpdate ]
				ifFalse: [ #changeAdd ])
]
