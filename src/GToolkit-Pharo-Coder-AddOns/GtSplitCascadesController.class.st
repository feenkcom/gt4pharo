Class {
	#name : #GtSplitCascadesController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'receiverName',
		'node',
		'temporaryCreated'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtSplitCascadesController >> initialize [
	super initialize.
	receiverName := '_'.
	temporaryCreated := false
]

{ #category : #accessing }
GtSplitCascadesController >> installRenameAction [
	(self findNodeAssigning: receiverName)
		ifNotNil: [ :var | 
			sourceCoderViewModel selectNone.
			sourceCoderViewModel moveCursorTo: var stopPosition.
			(sourceCoderViewModel renameLocalVariableAt: var stopPosition)
				ifNotNil: [ :action | 
					action
						when: GtRenameActionAnnouncement
						do: [ :ann | 
							ann eventType = #cancel 
								ifTrue: [ self cancelRefactoring ] ]
						for: self ] ]
]

{ #category : #accessing }
GtSplitCascadesController >> node [
	^ node
]

{ #category : #accessing }
GtSplitCascadesController >> node: aMessage [
	node := aMessage
]

{ #category : #accessing }
GtSplitCascadesController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.
	refactoring := GtSplitCascadesRefactoring
			model: model
			splitAt: (node parent semicolons
					at: (node parent messages identityIndexOf: node) - 1) startPosition
			inMethod: sourceCoderViewModel coderModel currentSelector
			forClass: (model classFor: sourceCoderViewModel behavior).
	temporaryCreated := false.
	refactoring
		setOption: #receiverName
		toUse: [ :ref | 
			temporaryCreated := true.
			receiverName ].
	^ refactoring
]

{ #category : #accessing }
GtSplitCascadesController >> refactoringName [
	^ 'Split cascade'
]

{ #category : #accessing }
GtSplitCascadesController >> safelyExecute [
	| refactoring newSource |
	refactoring := self refactoring.
	sourceCoderViewModel selectNone.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ false ].
	newSource := (refactoring model classFor: sourceCoderViewModel behavior)
			sourceCodeFor: sourceCoderViewModel selector.
	sourceCoderViewModel sourceText asString = newSource
		ifFalse: [ self setText: newSource asText ].
	temporaryCreated ifTrue: [ self installRenameAction ]
]
