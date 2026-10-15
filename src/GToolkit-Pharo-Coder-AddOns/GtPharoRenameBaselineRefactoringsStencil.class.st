"
I create {{gtClass:GtRBRenameClassRefactoring}} that renames the class `BaselineOf<name>`. See {{gtClass:GtPharoRenameBaselineCoderController}}.
"
Class {
	#name : #GtPharoRenameBaselineRefactoringsStencil,
	#superclass : #GtPharoRenameLiteralRefactoringsStencil,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameBaselineRefactoringsStencil >> computeRefactoring [
	"Same as {{gtMethod:GtRenameBaselineInMethodController>>#rename:to:}}."

	^ GtRBRenameClassRefactoring
		model: self createModel
		rename: ('BaselineOf' , variableModel originalName) asSymbol
		to: ('BaselineOf' , variableModel currentName) asSymbol
]

{ #category : #accessing }
GtPharoRenameBaselineRefactoringsStencil >> refactoringName [
	^ 'Rename class'
]
