"
I rename an instance variable in a coder. The new name must not be the name of another instance variable of the class. I replace {{gtClass:GtRenameInstanceVariableController}}. See {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}}.

# Example
{{gtExample:GtPharoRenameVariableModelRustEditorExamples>>#rustScripterEditorWithInstAPlusOneMethod_enterShowsPreview | codeExpanded=false | previewExpanded | previewHeight=400}}
"
Class {
	#name : #GtPharoRenameInstanceVariableCoderController,
	#superclass : #GtPharoRenameVariableCoderController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #hooks }
GtPharoRenameInstanceVariableCoderController >> createRefactoringsStencil [
	^ GtPharoRenameInstanceVariableRefactoringsStencil new
]

{ #category : #hooks }
GtPharoRenameInstanceVariableCoderController >> forbiddenNames [
	"The new name must not be the name of another instance variable."

	^ sourceCoderViewModel behavior allInstVarNames
]

{ #category : #hooks }
GtPharoRenameInstanceVariableCoderController >> refactoringName [
	^ 'Rename instance variable'
]
