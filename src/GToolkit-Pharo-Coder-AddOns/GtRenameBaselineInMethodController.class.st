Class {
	#name : #GtRenameBaselineInMethodController,
	#superclass : #GtRenameLiteralItemController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #testing }
GtRenameBaselineInMethodController class >> isDeprecated [
	"Replaced by {{gtClass:GtPharoRenameBaselineCoderController}}, this implementation stays for clients that still depend on it."

	^ true
]

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
