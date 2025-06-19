Class {
	#name : #GtSnippetUnknownReceiverInlineMessageRefactoringController,
	#superclass : #GtMethodInlineMessageFromComponentRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #executing }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> createRefactoringModel [
	| model |
	model := Smalltalk createRbNamespace
			onEnvironment: RBBrowserEnvironment new.
	self compileSnippetMethodIn: model.
	self modelUpdater cull: model.
	^ model
]

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> finishRefactoring: refactoring [
	| newText |
	super finishRefactoring: refactoring.
	newText := self refactoredSnippetCodeFrom: refactoring.
	self sourceCoderViewModel
		sourceText: newText asRopedText
		from: self
		synchronously: false
]

{ #category : #executing }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.

	refactoring := self refactoringClass
			model: model
			inline: (self snippetIntervalFor: node sourceInterval)+ ((returnLocation notNil
							and: [ returnLocation < (self snippetIntervalFor: node sourceInterval) first ])
							ifTrue: [ 1 ]
							ifFalse: [ 0 ])
			inMethod: self snippetSelector
			forClass: self snippetClass.

	refactoring setOption: #inlineExpression toUse: [ :ref :string | false ].
	refactoring
		setOption: #implementorToInline
		toUse: [ :ref :classes | classes detect: [ :each | each realClass = self implementor ] ifNone: [ nil ] ].
	^ refactoring
]
