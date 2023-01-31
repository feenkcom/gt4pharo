Extension { #name : #RBCommentChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBCommentChange >> gtDiffChange [
	| oldSource newSource |
	oldSource := (self changeClass ifNotNil: [ :cls | cls comment ]) ifNil: [ '' ].
	newSource := comment.
	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtCharacterGroupDiffSplitter words
]
