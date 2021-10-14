Class {
	#name : #GtMethodInlineMessageSendRefactoringController,
	#superclass : #GtMethodInlineRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtMethodInlineMessageSendRefactoringController >> refactoring [
	| aRefactoring aModel |

	aModel := self createRefactoringModel.

	aRefactoring := RBInlineMethodRefactoring
		model: aModel
		inline: node sourceInterval
		inMethod: sourceCoderViewModel coderModel currentSelector
		forClass: (aModel classFor: sourceCoderViewModel behavior).

	aRefactoring
		setOption: #inlineExpression
		toUse: [ :ref :string | true ].
		
	^ aRefactoring
]

{ #category : #accessing }
GtMethodInlineMessageSendRefactoringController >> refactoringName [
	^ 'Inline message send'
]
