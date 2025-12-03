Class {
	#name : #GtRenameInstanceVariableController,
	#superclass : #GtRenameVariableController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

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
