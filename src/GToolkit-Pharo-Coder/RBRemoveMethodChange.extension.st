Extension { #name : #RBRemoveMethodChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRemoveMethodChange >> gtDiffChange [
	| oldSource |
	oldSource := (self changeClass notNil
			ifTrue: [ self methodSourceFor: self selector ]) ifNil: [ '' ].
	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: ''
		using: GtSmaCCDiffSplitter forPharo
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRemoveMethodChange >> gtDiffStyler [
	^ BrRBTextStyler new classOrMetaClass: self changeClass
]
