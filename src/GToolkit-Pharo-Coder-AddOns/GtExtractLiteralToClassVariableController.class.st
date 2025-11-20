Class {
	#name : #GtExtractLiteralToClassVariableController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'literalNode',
		'variableName',
		'getter',
		'renameAction',
		'receiverAttribute',
		'receiverClassName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #adding }
GtExtractLiteralToClassVariableController >> addGetterEditor [
	| message |
	message := self messageNode.
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

{ #category : #adding }
GtExtractLiteralToClassVariableController >> addReceiverAttribute [
	| attribute message |
	self removeReceiverAttribute.
	attribute := GtExtractLiteralToClassVariableAttribute new
			refactoringController: self;
			focusOnFirstShow: true.
	message := self messageNode.
	receiverAttribute := self sourceCoderViewModel
			addTextAttribute: attribute
			from: message receiver startPosition
			to: message receiver stopPosition
]

{ #category : #private }
GtExtractLiteralToClassVariableController >> callSource [
	^ self getterReceiver , ' _'
]

{ #category : #executing }
GtExtractLiteralToClassVariableController >> cancelRefactoring [
	self removeRenamer.
	self removeReceiverAttribute.
	super cancelRefactoring
]

{ #category : #private }
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

{ #category : #executing }
GtExtractLiteralToClassVariableController >> finishRefactoring: refactoring [
	super finishRefactoring: refactoring.
	self removeRenamer.
	sourceCoderViewModel discardChanges
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> getterReceiver [
	^ 'self'
		, (sourceCoderViewModel behavior isClassSide ifTrue: [ '' ] ifFalse: [ ' class' ])
]

{ #category : #initialization }
GtExtractLiteralToClassVariableController >> initialize [
	super initialize.
	getter := #classVar
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> literalNode: aNode [
	literalNode := aNode
]

{ #category : #private }
GtExtractLiteralToClassVariableController >> messageNode [
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
				ifTrue: [ ^ each ] ].
	^ nil
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> parserStartingState [
	^ GtPharoParser startingStateForMethod
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> potentialReceivers [
	^ GtPrefixTree with: self getterReceiver
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> previewPosition [
	^ literalNode startPosition + self callSource size - 1
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> receiverClassName [
	^ receiverClassName
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> receiverClassName: anObject [
	anObject = self getterReceiver
		ifTrue: [ receiverClassName := nil ]
		ifFalse: [ receiverClassName := anObject ].
	self addRefactoringPreview
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
	receiverClassName
		ifNotNil: [ refactoring variableClassName: receiverClassName ].
	refactoring
		setOption: #methodName
		toUse: [ :methodName :ref | 
			methodName selector: getter.
			methodName ].
	^ refactoring
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> refactoringName [
	^'Extract literal to class variable'
]

{ #category : #removing }
GtExtractLiteralToClassVariableController >> removeReceiverAttribute [
	receiverAttribute ifNil: [ ^ self ].
	self sourceCoderViewModel removeCoderTextAttributes: receiverAttribute
]

{ #category : #removing }
GtExtractLiteralToClassVariableController >> removeRenamer [
	(renameAction notNil and: [ renameAction isInstalled ])
		ifTrue: [ renameAction uninstall ]
]

{ #category : #executing }
GtExtractLiteralToClassVariableController >> safelyExecute [
	self preventSave.
	sourceCoderViewModel selectNone.
	self updateSource.
	self addGetterEditor.
	self addReceiverAttribute.
	self addRefactoringPreview
]

{ #category : #accessing }
GtExtractLiteralToClassVariableController >> updateSelector: aSymbol [
	getter := aSymbol.
	self addRefactoringPreview
]

{ #category : #private }
GtExtractLiteralToClassVariableController >> updateSource [
	| newSource oldSource |
	oldSource := sourceCoderViewModel sourceText asString.
	newSource := (oldSource first: literalNode startPosition - 1) , self callSource
			, (oldSource allButFirst: literalNode stopPosition).
	self setText: newSource asRopedText
]
