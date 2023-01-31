Extension { #name : #RBClassCategoryChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBClassCategoryChange >> gtDiffChange [
	^ GtDiffBuilder
		computeDifferencesFrom: (self changeClass category
				copyReplaceAll: '-'
				with: ' - ')
		to: (self displayCategoryName copyReplaceAll: '-' with: ' - ')
		using: GtCharacterGroupDiffSplitter words
]
