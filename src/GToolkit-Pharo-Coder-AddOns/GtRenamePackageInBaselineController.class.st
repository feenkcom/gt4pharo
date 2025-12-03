Class {
	#name : #GtRenamePackageInBaselineController,
	#superclass : #GtRenameLiteralItemController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtRenamePackageInBaselineController >> installValidation [
	renameAction forText
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> refactoringName [
	^ 'Rename package'
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> rename: anOldName to: aNewName [
	| aModel |
	aModel := self createModel.
	^ (GtRBRenamePackageRefactoring from: anOldName to: aNewName)
		model: aModel;
		yourself
]
