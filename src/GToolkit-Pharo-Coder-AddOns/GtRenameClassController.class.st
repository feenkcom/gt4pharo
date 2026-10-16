Class {
	#name : #GtRenameClassController,
	#superclass : #GtRenameVariableController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #testing }
GtRenameClassController class >> isDeprecated [
	"Replaced by {{gtClass:GtPharoRenameClassCoderController}}, this implementation stays for clients that still depend on it."

	^ true
]

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
