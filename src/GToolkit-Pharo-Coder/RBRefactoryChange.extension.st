Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtCompilationJob [
	^ [ :job | 
	| totalCount current |
	job label: 'Compiling ' , self name.
	totalCount := self changesSize.
	current := 0.
	self
		executeNotifying: [ current := current + 1 min: totalCount.
			job progress: current / totalCount ] ] asJob
]
