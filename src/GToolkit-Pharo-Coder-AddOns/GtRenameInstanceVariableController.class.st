Class {
	#name : #GtRenameInstanceVariableController,
	#superclass : #GtRenameVariableController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #testing }
GtRenameInstanceVariableController class >> isDeprecated [
	"Replaced by {{gtClass:GtPharoRenameInstanceVariableCoderController}}, this implementation stays for clients that still depend on it."

	^ true
]

{ #category : #accessing }
GtRenameInstanceVariableController >> refactoringName [
	^ 'Rename instance variable'
]

{ #category : #accessing }
GtRenameInstanceVariableController >> rename: anOldName to: aNewName [
	| aModel aClass |

	aModel := self createModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior)
		whoDefinesInstanceVariable: anOldName.

	^ GtRenameInstanceVariableRefactoring
		model: aModel
		rename: anOldName
		to: aNewName
		in: aClass
]
