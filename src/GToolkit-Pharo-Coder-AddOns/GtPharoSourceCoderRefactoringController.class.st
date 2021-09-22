Class {
	#name : 'GtPharoSourceCoderRefactoringController',
	#superclass : 'GtSourceCoderRefactoringController',
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : 'private' }
GtPharoSourceCoderRefactoringController >> createRefactoringModel [
	| aModel aBehavior aProtocol aSourceString aCurrentSelector |
	
	aBehavior := sourceCoderViewModel behavior.
	aProtocol := sourceCoderViewModel protocol.
	aSourceString := sourceCoderViewModel sourceText asString.
	aCurrentSelector := sourceCoderViewModel coderModel currentSelector.
	
	aModel := RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new.
	(((aModel classFor: aBehavior) directlyDefinesMethod: aCurrentSelector) not
		or: [ ((aModel classFor: aBehavior) sourceCodeFor: aCurrentSelector) ~= aSourceString ])
		ifTrue: [ (aModel classFor: aBehavior) compile: aSourceString classified: aProtocol ].

	aModel name: self refactoringName.

	^ aModel
]
