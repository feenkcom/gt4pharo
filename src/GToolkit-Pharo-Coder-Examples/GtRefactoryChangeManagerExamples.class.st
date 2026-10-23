"
I exemplify ${class:GtRefactoryChangeManager}$.
My examples use ${method:GtRefactoryChangeManager class>>#isolatedInstanceDuring:}$ so that they do not affect the global undo/redo history.
"
Class {
	#name : #GtRefactoryChangeManagerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - isolation' }
GtRefactoryChangeManagerExamples >> isolatedInstanceAnswersBlockResult [
	"The outer isolated instance is not performing changes, which is the same situation as with the global instance"

	<gtExample>
	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ 
			| aResult |
			aResult := Object new.
			self
				assert: (GtRefactoryChangeManager isolatedInstanceDuring: [ aResult ]) 
					== aResult.
			self
				assert: (GtRefactoryChangeManager
						isolatedInstanceDuring: [ :anInstance | anInstance ]) class 
								== GtRefactoryChangeManager.
			aResult ]
]

{ #category : #'examples - isolation' }
GtRefactoryChangeManagerExamples >> isolatedInstanceDoesNotCreateGlobalInstance [
	"Without a current instance, no instance is created and none is left afterwards.
	The outer isolated instance protects the real global one while the current instance is removed"

	<gtExample>
	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ 
			| anIsolatedInstance |
			GtRefactoryChangeManager nuke.
			self assert: (GtRefactoryChangeManager classPool at: #Instance) isNil.

			GtRefactoryChangeManager
				isolatedInstanceDuring: [ :anInstance | 
					anIsolatedInstance := anInstance.
					self assert: GtRefactoryChangeManager instance == anInstance ].

			self assert: (GtRefactoryChangeManager classPool at: #Instance) isNil.
			anIsolatedInstance ]
]

{ #category : #'examples - isolation' }
GtRefactoryChangeManagerExamples >> isolatedInstanceIsRestoredAfterError [
	<gtExample>
	| originalInstance |
	originalInstance := GtRefactoryChangeManager instance.

	[ GtRefactoryChangeManager isolatedInstanceDuring: [ 
			Error signal: 'Failing block' ] ]
		on: Error
		do: [ :anError | anError return ].

	self assert: GtRefactoryChangeManager instance == originalInstance.

	^ originalInstance
]

{ #category : #'examples - isolation' }
GtRefactoryChangeManagerExamples >> isolatedInstanceIsTheCurrentInstance [
	<gtExample>
	| originalInstance |
	originalInstance := GtRefactoryChangeManager instance.

	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :anIsolatedInstance | 
			self assert: anIsolatedInstance ~~ originalInstance.
			self assert: GtRefactoryChangeManager instance == anIsolatedInstance.
			self assert: anIsolatedInstance hasUndoableOperations not.
			self assert: anIsolatedInstance hasRedoableOperations not.
			anIsolatedInstance ]
]

{ #category : #'examples - isolation' }
GtRefactoryChangeManagerExamples >> isolatedInstanceKeepsOuterHistory [
	"An outer isolated instance plays the role of the global one, so that the example
	can record a change in it without affecting the real global undo/redo history"

	<gtExample>
	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :anOuterInstance | 
			anOuterInstance addUndo: (RBCompositeRefactoryChange named: 'Outer change').
			self assert: anOuterInstance hasUndoableOperations.

			GtRefactoryChangeManager
				isolatedInstanceDuring: [ :anInnerInstance | 
					| anEnvironment |
					anEnvironment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
					[ (RBRemoveClassChange remove: anEnvironment anyDummyLeafClass realClass)
						gtExecuteWithUndo.
					self assert: anInnerInstance hasUndoableOperations ]
						ensure: [ anEnvironment removeFromSystem ] ].

			self assert: GtRefactoryChangeManager instance == anOuterInstance.
			self
				assert: anOuterInstance hasUndoableOperations
				description: 'Creating and removing classes in the inner instance must not clear the outer history'.
			anOuterInstance ]
]
