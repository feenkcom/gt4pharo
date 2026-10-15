Class {
	#name : #GtRenameClassVariableController,
	#superclass : #GtRenameVariableController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #testing }
GtRenameClassVariableController class >> isDeprecated [
	"Replaced by {{gtClass:GtPharoRenameClassVariableCoderController}}, this implementation stays for clients that still depend on it."

	^ true
]

{ #category : #accessing }
GtRenameClassVariableController >> refactoringName [
	^ 'Rename class variable'
]

{ #category : #accessing }
GtRenameClassVariableController >> rename: anOldName to: aNewName [
	| aModel aClass |

	aModel := self createModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior) instanceSide
		whoDefinesClassVariable: anOldName.
	
	^ RBRenameClassVariableRefactoring
		  model: aModel
		  rename: anOldName
		  to: aNewName
		  in: aClass
]
