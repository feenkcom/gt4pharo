Class {
	#name : #GtExtractLiteralToClassVariableController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'literalNode',
		'variableName',
		'getter',
		'renameAction'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> addGetterEditor [
	| message |
	self sourceAst
		withAllNodesOfType: GtPharoMessageNode
		do: [ :each | 
			(each selector = #_
				and: [ (sourceCoderViewModel behavior isClassSide
						and: [ each receiver isVariable and: [ each receiver variableName = 'self' ] ])
						or: [ each receiver isMessageSend
								and: [ each receiver selector = #class
										and: [ each receiver receiver isVariable
												and: [ each receiver receiver variableName = 'self' ] ] ] ] ])
				ifTrue: [ message := each ] ].
	renameAction := GtRenameSelectorAction
			message: message
			textualCoderViewModel: sourceCoderViewModel.
	renameAction newSelector: getter.
	renameAction selectAll: true.
	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAction isValid ifTrue: [ self updateSelector: renameAction newSelector ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ]
		for: self.
	renameAction install
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> callSource [
	^ 'self '
		, (sourceCoderViewModel behavior isClassSide ifTrue: [ '' ] ifFalse: [ 'class ' ])
		, '_'
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> cancelRefactoring [
	self removeRenamer.
	super cancelRefactoring
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> createRefactoringModel [
	| aModel aBehavior aProtocol aSourceString aCurrentSelector |
	
	aBehavior := sourceCoderViewModel behavior.
	aProtocol := sourceCoderViewModel protocol.
	aSourceString := originalSource asString.
	aCurrentSelector := sourceCoderViewModel coderModel currentSelector.
	
	aModel := Smalltalk createRbNamespace onEnvironment: RBBrowserEnvironment new.
	(((aModel classFor: aBehavior) directlyDefinesMethod: aCurrentSelector) not
		or: [ ((aModel classFor: aBehavior) sourceCodeFor: aCurrentSelector) ~= aSourceString ])
		ifTrue: [ (aModel classFor: aBehavior) compile: aSourceString classified: aProtocol ].

	aModel name: self refactoringName.

	^ aModel
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> finishRefactoring: refactoring [
	super finishRefactoring: refactoring.
	self removeRenamer.
	sourceCoderViewModel discardChanges
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> initialize [
	super initialize.
	getter := #classVar
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> literalNode: aNode [
	literalNode := aNode
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> parserStartingState [
	^ GtPharoParser startingStateForMethod
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> previewPosition [
	^ literalNode startPosition + self callSource size - 1
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.
	refactoring := GtExtractLiteralToClassVariableRefactoring
			model: model
			extract: literalNode sourceInterval
			inMethod: sourceCoderViewModel coderModel currentSelector
			forClass: (model classFor: sourceCoderViewModel behavior).
	refactoring
		setOption: #methodName
		toUse: [ :methodName :ref | 
			methodName selector: getter.
			methodName ].
	^ refactoring
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> refactoringName [
	^'Extract literal to class variable'
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> removeRenamer [
	(renameAction notNil and: [ renameAction isInstalled ])
		ifTrue: [ renameAction uninstall ]
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> safelyExecute [
	self preventSave.
	sourceCoderViewModel selectNone.
	self updateSource.
	self addGetterEditor.
	self addRefactoringPreview
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> updateSelector: aSymbol [
	getter := aSymbol.
	self addRefactoringPreview
]

{ #category : #'as yet unclassified' }
GtExtractLiteralToClassVariableController >> updateSource [
	| newSource oldSource |
	oldSource := sourceCoderViewModel sourceText asString.
	newSource := (oldSource first: literalNode startPosition - 1) , self callSource
			, (oldSource allButFirst: literalNode stopPosition).
	self setText: newSource asRopedText
]
