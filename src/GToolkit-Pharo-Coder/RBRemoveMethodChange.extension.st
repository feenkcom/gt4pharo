Extension { #name : #RBRemoveMethodChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRemoveMethodChange >> gtDiff [
	| oldSource |
	oldSource := (self changeClass notNil
			ifTrue: [ self methodSourceFor: self selector ]) ifNil: [ '' ].
	^ PrettyTextDiffBuilder
		from: oldSource
		to: ''
		inClass: self changeClass
]
