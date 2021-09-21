Class {
	#name : 'GtVariableRefactoringController',
	#superclass : 'GtSourceCoderRefactoringController',
	#instVars : [
		'variableNode'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Variables refactoring'
}

{ #category : 'private' }
GtVariableRefactoringController >> createRefactoringModel [
	| aModel aBehavior aProtocol aSourceString aCurrentSelector |
	
	aBehavior := sourceCoderViewModel behavior.
	aProtocol := sourceCoderViewModel protocol.
	aSourceString := sourceCoderViewModel sourceText asString.
	aCurrentSelector := sourceCoderViewModel coderModel currentSelector.
	
	aModel := RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new.
	(((aModel classFor: aBehavior) directlyDefinesMethod: aCurrentSelector) not
		or: [ ((aModel classFor: aBehavior) sourceCodeFor: aCurrentSelector) ~= aSourceString ])
		ifTrue: [ (aModel classFor: aBehavior) compile: aSourceString classified: aProtocol ].

	^ aModel
]

{ #category : 'executing' }
GtVariableRefactoringController >> safelyExecute [
	self preventSave.

	sourceCoderViewModel selectNone.

	self
		addRefactoringChangesPreview: self refactoring
		at: variableNode stopPosition
		whenComplete: [
			self removeRefactoringAttribute.
			self allowSave ]
]

{ #category : 'accessing' }
GtVariableRefactoringController >> variableName [
	^ self variableNode variableName
]

{ #category : 'accessing' }
GtVariableRefactoringController >> variableNode [

	^ variableNode
]

{ #category : 'accessing' }
GtVariableRefactoringController >> variableNode: anObject [

	variableNode := anObject
]
