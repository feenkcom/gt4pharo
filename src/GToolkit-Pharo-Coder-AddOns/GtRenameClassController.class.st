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

	^ GtRBRenameClassRefactoring
		model: aModel
		rename: anOldName asSymbol
		to: aNewName
]
