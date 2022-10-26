Class {
	#name : #GtPharoSourceCoderRefactoringController,
	#superclass : #GtSourceCoderRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #'private - attributes' }
GtPharoSourceCoderRefactoringController >> addRefactoringChangesPreview: aRefactoring at: aTextPosition whenComplete: aBlock [
	self removeRefactoringAttribute.
	refactoringPreviewAttributes := self sourceCoderViewModel
			addTextAttribute: (GtRefactoringChangesAttribute new
					refactoring: aRefactoring;
					completionAction: aBlock;
					cancelAction: [ self cancelRefactoring ])
			from: aTextPosition
			to: aTextPosition
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> addRefactoringPreview [
	| refactoring |
	self isValidForPreview ifFalse: [ ^ self cancelRefactoring ].
	refactoring := self refactoring.
	refactoring ifNil: [ ^ self cancelRefactoring ].
	self setPreviewOptionsOn: refactoring.
	self
		addRefactoringChangesPreview: refactoring
		at: self previewPosition
		whenComplete: [ self finishRefactoring: refactoring ]
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

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> finishRefactoring: refactoring [
	^ self cleanUp
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> isValidForPreview [
	^ true
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> previewPosition [
	self subclassResponsibility
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> setPreviewOptionsOn: refactoring [ 
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> snippetSelector [
	^ #_
]
