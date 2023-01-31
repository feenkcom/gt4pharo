Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtCompilationJob [
	^ self gtCompilationJobWithProgress: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtCompilationJobWithProgress: aBlock [
	^ [ :job | 
	| totalCount current |
	job label: 'Compiling ' , self name.
	totalCount := self changesSize max: 1.
	current := 0.
	self
		executeNotifying: [ current := current + 1 min: totalCount.
			job progress: current / totalCount.
			aBlock cull: current / totalCount ] ] asJob
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtDiffStyler [
	^ nil
]
