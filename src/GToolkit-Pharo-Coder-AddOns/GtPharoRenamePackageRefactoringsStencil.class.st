"
I create {{gtClass:GtRBRenamePackageRefactoring}} that renames a package. See {{gtClass:GtPharoRenamePackageCoderController}}.
"
Class {
	#name : #GtPharoRenamePackageRefactoringsStencil,
	#superclass : #GtPharoRenameLiteralRefactoringsStencil,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenamePackageRefactoringsStencil >> computeRefactoring [
	"Same as {{gtMethod:GtRenamePackageInBaselineController>>#rename:to:}}."

	^ (GtRBRenamePackageRefactoring
		from: variableModel originalName
		to: variableModel currentName)
		model: self createModel;
		yourself
]

{ #category : #accessing }
GtPharoRenamePackageRefactoringsStencil >> refactoringName [
	^ 'Rename package'
]
