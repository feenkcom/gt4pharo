Extension { #name : 'RBCommentChange' }

{ #category : '*GToolkit-Pharo-Coder' }
RBCommentChange >> gtDiff [
	| oldSource newSource |
	oldSource := (self changeClass ifNotNil: [ :cls | cls comment ])
		ifNil: [ '' ].
	newSource := comment.
	^ TextDiffBuilder
		from: oldSource
		to: newSource
		inClass: self changeClass
]
