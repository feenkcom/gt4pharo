Class {
	#name : #GtConvertCascadesToStatementsController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'receiverName',
		'node',
		'temporaryCreated'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtConvertCascadesToStatementsController >> initialize [
	super initialize.
	receiverName := '_'.
	temporaryCreated := false
]

{ #category : #accessing }
GtConvertCascadesToStatementsController >> installRenameAction [
	(self findNodeAssigning: receiverName)
		ifNotNil: [ :var | 
			sourceCoderViewModel selectNone.
			sourceCoderViewModel moveCursorTo: var stopPosition.
			(sourceCoderViewModel renameLocalVariableAt: var stopPosition)
				ifNotNil: [ :action | 
					action
						when: GtRenameActionAnnouncement
						do: [ :ann | 
							ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ]
						for: self ] ]
]

{ #category : #accessing }
GtConvertCascadesToStatementsController >> node [
	^ node
]

{ #category : #accessing }
GtConvertCascadesToStatementsController >> node: aCascadeNode [
	node := aCascadeNode
]

{ #category : #accessing }
GtConvertCascadesToStatementsController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.
	refactoring := GtConvertCascadesToStatementsRefactoring
			model: model
			convert: node sourceInterval
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
GtConvertCascadesToStatementsController >> refactoringName [
	^ 'Convert cascades to statements'
]

{ #category : #accessing }
GtConvertCascadesToStatementsController >> safelyExecute [
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
