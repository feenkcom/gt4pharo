"
I compute {{gtClass:GtRBRenameClassRefactoring}} that renames a class. See {{gtClass:GtPharoRenameClassCoderController}}.

# Example
{{gtExample:GtPharoRenameClassCoderControllerExamples>>#installedController_refactorings | codeExpanded=false | previewExpanded | previewHeight=200}}
"
Class {
	#name : #GtPharoRenameClassRefactoringsStencil,
	#superclass : #GtPharoRenameVariableRefactoringsStencil,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #creation }
GtPharoRenameClassRefactoringsStencil >> computeRefactoring [
	"Same as {{gtMethod:GtRenameClassController>>#rename:to:}}."

	^ GtRBRenameClassRefactoring
		model: self createModel
		rename: variableModel originalName asSymbol
		to: variableModel currentName
]

{ #category : #accessing }
GtPharoRenameClassRefactoringsStencil >> refactoringName [
	^ 'Rename class'
]
