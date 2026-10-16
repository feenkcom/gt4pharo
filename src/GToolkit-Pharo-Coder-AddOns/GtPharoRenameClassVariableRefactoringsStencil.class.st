"
I compute {{gtClass:RBRenameClassVariableRefactoring}} that renames a class variable. See {{gtClass:GtPharoRenameClassVariableCoderController}}.

# Example
{{gtExample:GtPharoRenameClassVariableCoderControllerExamples>>#installedController_refactorings | codeExpanded=false | previewExpanded | previewHeight=200}}
"
Class {
	#name : #GtPharoRenameClassVariableRefactoringsStencil,
	#superclass : #GtPharoRenameVariableRefactoringsStencil,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #creation }
GtPharoRenameClassVariableRefactoringsStencil >> computeRefactoring [
	"Same as {{gtMethod:GtRenameClassVariableController>>#rename:to:}}."

	| aModel aClass |
	aModel := self createModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior) instanceSide
			whoDefinesClassVariable: variableModel originalName.
	^ RBRenameClassVariableRefactoring
		model: aModel
		rename: variableModel originalName
		to: variableModel currentName
		in: aClass
]

{ #category : #accessing }
GtPharoRenameClassVariableRefactoringsStencil >> refactoringName [
	^ 'Rename class variable'
]
