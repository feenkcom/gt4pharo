Class {
	#name : #GtRenameClassController,
	#superclass : #GtRenameVariableController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtRenameClassController >> refactoringName [
	^ 'Rename class'
]

{ #category : #accessing }
GtRenameClassController >> rename: anOldName to: aNewName [
	| aModel |

	aModel := self createModel.

	^ GtRBRenameClassWithCommentsRefactoring
		model: aModel
		rename: (self class environment at: anOldName asSymbol)
		to: aNewName
]
