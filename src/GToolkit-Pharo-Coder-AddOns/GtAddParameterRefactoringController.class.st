Class {
	#name : 'GtAddParameterRefactoringController',
	#superclass : 'GtMethodRefactoringController',
	#instVars : [
		'renameAction',
		'newSelector',
		'variableName',
		'parameterNode'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : 'executing' }
GtAddParameterRefactoringController >> addKeyword [
	| parameter text |
	sourceCoderViewModel selectNone.
	parameter := methodNode pattern variables isEmpty
		ifTrue: [ ': ' , self variableName ]
		ifFalse: [ ' _: ' , self variableName ].
	text := ((originalSource asString first: methodNode pattern stopPosition) , parameter
		, (originalSource asString allButFirst: methodNode pattern stopPosition)) asRopedText.
	(GtPharoStyler new)
		coderViewModel: sourceCoderViewModel;
		style: text ast: (GtPharoParser parse: text asString).
	self setText: text
]

{ #category : 'executing' }
GtAddParameterRefactoringController >> addRefactoringPreview [
	self removeRefactoringAttribute.
	super addRefactoringPreview
]

{ #category : 'executing' }
GtAddParameterRefactoringController >> cancelRefactoring [
	self isRenaming
		ifTrue: [ renameAction cancel ].	
	self restoreText.
	self allowSave
]

{ #category : 'executing' }
GtAddParameterRefactoringController >> createRefactoringModel [
	| model modelClass |
	
	model := RBClassModelFactory rbNamespace
		onEnvironment: RBBrowserEnvironment new.
	model name: self refactoringName.
	
	modelClass := model classFor: sourceCoderViewModel behavior.

	(modelClass sourceCodeFor: methodNode selector) = originalSource asString
		ifFalse: [ modelClass
				compile: originalSource asString
				classified: sourceCoderViewModel protocol ].
	^ model
]

{ #category : 'executing' }
GtAddParameterRefactoringController >> installRenamer [
	| ast |
	ast := sourceCoderViewModel astAwait.
	renameAction := GtRenameAction2
		                locations: { ast pattern selectorParts last sourceInterval }
		                textualCoderViewModel: sourceCoderViewModel.
	renameAction forKeyword.
	renameAction selectAll: true.
	renameAction when: GtRenameActionAnnouncement do: [ :ann | 
		ann eventType = #textUpdated ifTrue: [ self updateSelector: renameAction newName ].
		ann eventType = #accept ifTrue: [ self addRefactoringPreview ].
		ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	renameAction install
]

{ #category : 'testing' }
GtAddParameterRefactoringController >> isRenaming [
	^ renameAction notNil and: [ renameAction isInstalled ]
]

{ #category : 'accessing' }
GtAddParameterRefactoringController >> newSelector [
	^ newSelector ifNil: [ 
		  newSelector := (methodNode selector isUnary
			                  ifTrue: [ methodNode selector , ':' ]
			                  ifFalse: [ methodNode selector , '_:' ]) asSymbol ]
]

{ #category : 'accessing' }
GtAddParameterRefactoringController >> parameterNode [
	^ parameterNode
]

{ #category : 'accessing' }
GtAddParameterRefactoringController >> parameterNode: aRBValueNode [
	parameterNode := aRBValueNode
]

{ #category : 'executing' }
GtAddParameterRefactoringController >> previewPosition [
	^ sourceCoderViewModel astAwait pattern stopPosition
]

{ #category : 'accessing' }
GtAddParameterRefactoringController >> refactoring [
	| newArg model |
	model := self createRefactoringModel.
	newArg := RBArgumentName
		name: self variableName
		value: (parameterNode ifNil: [ 'nil' ] ifNotNil: [ parameterNode source ]).
	^ (parameterNode ifNil: [ RBAddParameterRefactoring ] ifNotNil: [ GtAddParameterRefactoring ])
		model: model
		addParameterToMethod: methodNode selector
		in: (model classFor: self methodClass)
		newSelector: self newSelector
		permutation: (1 to: methodNode selector numArgs) , {-1}
		newArgs: {newArg}
]

{ #category : 'accessing' }
GtAddParameterRefactoringController >> refactoringName [
	^ 'Add parameter to #' , self methodSelector
]

{ #category : 'executing' }
GtAddParameterRefactoringController >> safelyExecute [
	self addKeyword.
	super safelyExecute.
	self installRenamer
]

{ #category : 'executing' }
GtAddParameterRefactoringController >> updateSelector: aString [
	aString asSymbol isKeyword ifFalse: [ ^ self ].
	newSelector := ('' join:
		                self newSelector keywords allButLast , { aString })
		               asSymbol.
	self addRefactoringPreview
]

{ #category : 'accessing' }
GtAddParameterRefactoringController >> variableName [
	^ variableName ifNil: [ 
		  | index prefix locals |
		  variableName := prefix := #anObject.
		  locals := Set withAll: self methodClass allInstVarNames.
		  methodNode
			  allNodesOfType: GtPharoVariableNode
			  do: [ :each | locals add: each variableName ].
		  index := 1.
		  [ 
		  (locals includes: variableName) or: [ 
			  (self methodClass bindingOf: variableName) notNil ] ] whileTrue: [ 
			  variableName := (prefix , index printString) asSymbol.
			  index := index + 1 ].
		  variableName ]
]
