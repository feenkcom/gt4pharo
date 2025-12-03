Class {
	#name : #GtMethodInlineTemporaryVariableRefactoringController,
	#superclass : #GtMethodInlineRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtMethodInlineTemporaryVariableRefactoringController >> refactoring [
	| aModel |

	aModel := self createRefactoringModel.

	^ RBInlineTemporaryRefactoring
		model: aModel
		inline: node sourceInterval
		from: sourceCoderViewModel coderModel currentSelector
		in: (aModel classFor: sourceCoderViewModel behavior)
]

{ #category : #accessing }
GtMethodInlineTemporaryVariableRefactoringController >> refactoringName [
	^ 'Inline temporary variable'
]
