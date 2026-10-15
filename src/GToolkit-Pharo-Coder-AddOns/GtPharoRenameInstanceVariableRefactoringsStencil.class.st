"
I compute {{gtClass:GtRenameInstanceVariableRefactoring}} that renames an instance variable. See {{gtClass:GtPharoRenameInstanceVariableCoderController}}.

# Example
{{gtExample:GtPharoRenameVariableCoderControllerExamples>>#installedController_refactorings | codeExpanded=false | previewExpanded | previewHeight=200}}
"
Class {
	#name : #GtPharoRenameInstanceVariableRefactoringsStencil,
	#superclass : #GtPharoRenameVariableRefactoringsStencil,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #creation }
GtPharoRenameInstanceVariableRefactoringsStencil >> computeRefactoring [
	"Same as {{gtMethod:GtRenameInstanceVariableController>>#rename:to:}}."

	| aModel aClass |
	aModel := self createModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior)
			whoDefinesInstanceVariable: variableModel originalName.
	^ GtRenameInstanceVariableRefactoring
		model: aModel
		rename: variableModel originalName
		to: variableModel currentName
		in: aClass
]

{ #category : #accessing }
GtPharoRenameInstanceVariableRefactoringsStencil >> refactoringName [
	^ 'Rename instance variable'
]
