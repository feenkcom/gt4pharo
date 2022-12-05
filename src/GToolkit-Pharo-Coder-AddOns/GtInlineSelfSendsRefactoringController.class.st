Class {
	#name : #GtInlineSelfSendsRefactoringController,
	#superclass : #GtMethodRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtInlineSelfSendsRefactoringController >> refactoring [
	| model refactoring |
	model := self createRefactoringModel.
	refactoring := GtInlineAllSendersRefactoring
		               model: model
		               sendersOf: methodNode selector
		               in: (model classFor: self methodClass).
	refactoring options at: #inlineExpression put: [ :ref :msg | false ].
	^ refactoring
]

{ #category : #accessing }
GtInlineSelfSendsRefactoringController >> refactoringName [
	^ 'Inline all self sends to ' , methodNode selector
]
