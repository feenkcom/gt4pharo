Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtCompilationJob [
	^ self gtCompilationJobWithProgress: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtCompilationJobWithProgress: aBlock [
	^ self
		gtCompilationJobWithProgress: aBlock
		threshold: self gtDefaultBulkExecutionThreshold
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtCompilationJobWithProgress: aBlock threshold: aThreshold [
	^ (GtJob
		block: [ :job | 
			GtRefactoryChangeManager instance
				ignoreChangesWhile: [ | totalCount current undoChange shouldSignalBulkChanges |
					job label: 'Compiling ' , self name.
					totalCount := self changesSize max: 1.
					job max: totalCount.
					current := 0.
					shouldSignalBulkChanges := totalCount >= aThreshold.
					shouldSignalBulkChanges
						ifTrue: [ SystemAnnouncer uniqueInstance
								announce: (GtAboutToPerformBulkChangesAnnouncement new changes: self) ].
					[ undoChange := self
							executeNotifying: [ current := current + 1 min: totalCount.
								job currentValue: current.
								aBlock cull: current / totalCount ] ]
						ensure: [ shouldSignalBulkChanges
								ifTrue: [ SystemAnnouncer uniqueInstance
										announce: (GtFinishedBulkChangesAnnouncement new changes: self) ] ].
					GtRefactoryChangeManager instance addUndo: undoChange ] ])
		announcer: Announcer new
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtDefaultBulkExecutionThreshold [
	^ 10
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtDiffStyler [
	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBRefactoryChange >> gtExecuteWithUndo [
	GtRefactoryChangeManager instance performChange: self
]
