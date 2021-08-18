Extension { #name : 'RBAddMethodChange' }

{ #category : '*GToolkit-Pharo-Coder' }
RBAddMethodChange >> gtDiff [
	| oldSource newSource |
	oldSource := (self changeClass notNil
		ifTrue: [ self methodSourceFor: self selector ]) ifNil: [ '' ].
	newSource := source.
	^ PrettyTextDiffBuilder
		from: oldSource
		to: newSource
		inClass: self changeClass
]
