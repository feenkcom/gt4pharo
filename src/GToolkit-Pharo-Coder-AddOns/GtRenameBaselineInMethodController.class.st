Class {
	#name : #GtRenameBaselineInMethodController,
	#superclass : #GtRenameLiteralItemController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtRenameBaselineInMethodController >> refactoringName [
	^ 'Rename class'
]

{ #category : #accessing }
GtRenameBaselineInMethodController >> rename: anOldName to: aNewName [
	| aModel |
	aModel := self createModel.
	^ GtRBRenameClassRefactoring
		model: aModel
		rename: ('BaselineOf' , anOldName) asSymbol
		to: ('BaselineOf' , aNewName) asSymbol
]
