Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtCompilationJob [
	^ self gtCompilationJobWithProgress: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtCompilationJobWithProgress: aBlock [
	^ GtJob
		block: [ :job | 
			| totalCount current |
			job label: 'Compiling ' , self name.
			totalCount := self changesSize max: 1.
			job max: totalCount.
			current := 0.
			self
				executeNotifying: [ current := current + 1 min: totalCount.
					job currentValue: current.
					aBlock cull: current / totalCount ] ]
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtDiffStyler [
	^ nil
]
