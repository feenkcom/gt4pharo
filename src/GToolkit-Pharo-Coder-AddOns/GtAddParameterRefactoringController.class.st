Class {
	#name : #GtAddParameterRefactoringController,
	#superclass : #GtMethodRefactoringController,
	#instVars : [
		'newSelector',
		'variableName',
		'parameterNode',
		'renameSelectorAction',
		'renameParamAction',
		'argumentSource',
		'sourceAction'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #executing }
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

{ #category : #accessing }
GtAddParameterRefactoringController >> argumentSource [
	^ argumentSource
		ifNil: [ parameterNode ifNil: [ 'nil' ] ifNotNil: [ parameterNode source ] ]
]

{ #category : #accessing }
GtAddParameterRefactoringController >> argumentSource: aString [
	argumentSource := aString.
	self addRefactoringPreview
]

{ #category : #executing }
GtAddParameterRefactoringController >> cancelRefactoring [
	self isRenamingSelector ifTrue: [ renameSelectorAction cancel ].
	self isRenamingParameter ifTrue: [ renameParamAction cancel ].
	self isRenamingSource ifTrue: [ sourceAction cancel ].
	super cancelRefactoring
]

{ #category : #executing }
GtAddParameterRefactoringController >> createRefactoringModel [
	| model modelClass |
	
	model := Smalltalk createRbNamespace
		onEnvironment: RBBrowserEnvironment new.
	model name: self refactoringName.
	
	modelClass := model classFor: sourceCoderViewModel behavior.

	(modelClass sourceCodeFor: methodNode selector) = originalSource asString
		ifFalse: [ modelClass
				compile: originalSource asString
				classified: sourceCoderViewModel protocol ].
	^ model
]

{ #category : #executing }
GtAddParameterRefactoringController >> installArgumentSource [
	| ast |
	parameterNode ifNotNil: [ ^ self ].
	ast := sourceCoderViewModel astSync.
	sourceAction := GtCoderViewModelRenameAction
			locations: {ast pattern variables last sourceInterval}
			textualCoderViewModel: sourceCoderViewModel.
	sourceAction selectAll: true.
	sourceAction allowAccept: false.
	sourceAction hasRefactoringPreview: true.
	sourceAction requestInitialFocus: false.
	sourceAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			#textUpdated = ann eventType
				ifTrue: [ self argumentSource: sourceAction newName ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ]
		for: self.
	sourceAction install.
	sourceAction updateName: self argumentSource
]

{ #category : #executing }
GtAddParameterRefactoringController >> installParameterRenamer [
	| ast |
	ast := sourceCoderViewModel astSync.
	renameParamAction := GtCoderViewModelRenameAction
			locations: {ast pattern variables last sourceInterval}
			textualCoderViewModel: sourceCoderViewModel.
	renameParamAction selectAll: true.
	renameParamAction allowAccept: false.
	renameParamAction hasRefactoringPreview: true.
	renameParamAction requestInitialFocus: false.
	renameParamAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			#textUpdated = ann eventType
				ifTrue: [ self variableName: renameParamAction newName ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ]
		for: self.
	renameParamAction install
]

{ #category : #executing }
GtAddParameterRefactoringController >> installSelectorRenamer [
	| ast |
	ast := sourceCoderViewModel astSync.
	renameSelectorAction := GtRenameSelectorAction
			message: ast pattern
			textualCoderViewModel: sourceCoderViewModel.
	renameSelectorAction selectAll: true.
	renameSelectorAction focusedIndex: ast numArgs.
	renameSelectorAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ self updateSelector: renameSelectorAction newSelector ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ]
		for: self.
	renameSelectorAction install
]

{ #category : #testing }
GtAddParameterRefactoringController >> isRenamingParameter [
	^ renameParamAction notNil and: [ renameParamAction isInstalled ]
]

{ #category : #testing }
GtAddParameterRefactoringController >> isRenamingSelector [
	^ renameSelectorAction notNil and: [ renameSelectorAction isInstalled ]
]

{ #category : #testing }
GtAddParameterRefactoringController >> isRenamingSource [
	^ sourceAction notNil and: [ sourceAction isInstalled ]
]

{ #category : #accessing }
GtAddParameterRefactoringController >> newSelector [
	^ newSelector ifNil: [ 
		  newSelector := (methodNode selector isUnary
			                  ifTrue: [ methodNode selector , ':' ]
			                  ifFalse: [ methodNode selector , '_:' ]) asSymbol ]
]

{ #category : #accessing }
GtAddParameterRefactoringController >> parameterNode [
	^ parameterNode
]

{ #category : #accessing }
GtAddParameterRefactoringController >> parameterNode: aRBValueNode [
	parameterNode := aRBValueNode
]

{ #category : #executing }
GtAddParameterRefactoringController >> previewPosition [
	^ sourceCoderViewModel astSync pattern stopPosition
]

{ #category : #accessing }
GtAddParameterRefactoringController >> refactoring [
	| newArg model |
	model := self createRefactoringModel.
	newArg := RBArgumentName name: self variableName value: self argumentSource.
	^ (GtAddParameterRefactoring
		model: model
		addParameterToMethod: methodNode selector
		in: (model classFor: self methodClass)
		newSelector: self newSelector
		permutation: (1 to: methodNode selector numArgs) , {-1}
		newArgs: {newArg})
		shouldReplaceExpressions: parameterNode notNil;
		yourself
]

{ #category : #accessing }
GtAddParameterRefactoringController >> refactoringName [
	^ 'Add parameter to #' , self methodSelector
]

{ #category : #executing }
GtAddParameterRefactoringController >> safelyExecute [
	self addKeyword.
	self preventSave.
	sourceCoderViewModel selectNone.
	self installSelectorRenamer.
	self installParameterRenamer.
	self installArgumentSource.
	self addRefactoringPreview
]

{ #category : #executing }
GtAddParameterRefactoringController >> updateSelector: aString [
	aString asSymbol isKeyword ifFalse: [ ^ self ].
	newSelector := aString asSymbol.
	self addRefactoringPreview
]

{ #category : #accessing }
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

{ #category : #accessing }
GtAddParameterRefactoringController >> variableName: aString [
	variableName := aString asSymbol.
	self addRefactoringPreview
]
