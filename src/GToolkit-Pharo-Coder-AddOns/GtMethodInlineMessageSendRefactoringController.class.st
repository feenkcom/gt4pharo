Class {
	#name : #GtMethodInlineMessageSendRefactoringController,
	#superclass : #GtMethodInlineRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtMethodInlineMessageSendRefactoringController >> inlineRefactoringClass [
	^ GtInlineMethodRefactoring
]

{ #category : #accessing }
GtMethodInlineMessageSendRefactoringController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.

	refactoring := self inlineRefactoringClass
			model: model
			inline: node sourceInterval
			inMethod: sourceCoderViewModel coderModel currentSelector
			forClass: (model classFor: sourceCoderViewModel behavior).

	refactoring setOption: #inlineExpression toUse: [ :ref :string | true ].

	^ refactoring
]

{ #category : #accessing }
GtMethodInlineMessageSendRefactoringController >> refactoringName [
	^ 'Inline message send'
]
