Extension { #name : 'RBRemoveMethodChange' }

{ #category : '*GToolkit-Pharo-Coder' }
RBRemoveMethodChange >> gtDiff [
	| oldSource |
	oldSource := (self methodSourceFor: self selector) ifNil: [ '' ].
	^ PrettyTextDiffBuilder
		from: oldSource
		to: ''
		inClass: self changeClass
]
