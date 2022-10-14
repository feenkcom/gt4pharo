Class {
	#name : #GtPharoSourceCoderRefactoringController,
	#superclass : #GtSourceCoderRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #'private - attributes' }
GtPharoSourceCoderRefactoringController >> addRefactoringChangesPreview: aRefactoring at: aTextPosition [
	self
		addRefactoringChangesPreview: aRefactoring
		at: aTextPosition
		whenComplete: [  ]
]

{ #category : #'private - attributes' }
GtPharoSourceCoderRefactoringController >> addRefactoringChangesPreview: aRefactoring at: aTextPosition whenComplete: aBlock [
	self removeRefactoringAttribute.
	refactoringPreviewAttributes := self sourceCoderViewModel
			addTextAttribute: (GtRefactoringChangesAttribute new
					refactoring: aRefactoring;
					completionAction: aBlock;
					cancelAction: [ 
						self restoreText ])
			from: aTextPosition
			to: aTextPosition
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> compileSnippetMethodIn: model [
	| cls |
	cls := model classFor: nil class.
	cls compile: self snippetSelector , ' ' , self sourceText asString classified: #accessing
]

{ #category : #private }
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

{ #category : #private }
GtPharoSourceCoderRefactoringController >> snippetSelector [
	^ #_
]
