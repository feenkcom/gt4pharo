"
I rename a class that is referenced in a coder. All references to the class in the coder are renamed together, the refactoring renames the class and all its references in the image. The new name must be a valid class name, see {{gtClass:GtPharoRenameClassValidator}}. I replace {{gtClass:GtRenameClassController}}. See {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}}.

# Example
{{gtExample:GtPharoRenameVariableModelRustEditorExamples>>#rustScripterEditorWithDummyThreeMethod_refactoringsPreview | codeExpanded=false | previewExpanded | previewHeight=400}}
"
Class {
	#name : #GtPharoRenameClassCoderController,
	#superclass : #GtPharoRenameVariableCoderController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #hooks }
GtPharoRenameClassCoderController >> createRefactoringsStencil [
	^ GtPharoRenameClassRefactoringsStencil new
]

{ #category : #hooks }
GtPharoRenameClassCoderController >> createValidator [
	"Existing globals are not valid names, so there are no forbidden names."

	^ GtPharoRenameClassValidator new
]

{ #category : #hooks }
GtPharoRenameClassCoderController >> refactoringName [
	^ 'Rename class'
]
