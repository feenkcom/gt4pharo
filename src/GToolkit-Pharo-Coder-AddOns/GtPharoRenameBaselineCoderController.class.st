"
I rename the name of a baseline in a baseline method, e.g., 'GtPharoDummyBaselineTarget' in {{gtMethod:GtPharoDummyBaseline>>#baseline:}}. The refactoring renames the class `BaselineOf<name>`, see {{gtClass:GtPharoRenameBaselineRefactoringsStencil}}. The new name must not be the name of an existing baseline, see {{gtClass:GtPharoRenameBaselineValidator}}. I replace {{gtClass:GtRenameBaselineInMethodController}}. See {{gtMethod:GtPharoSourceCoder>>#renameBaselineChoosingImplementation:in:for:}}.

# Example
{{gtExample:GtPharoRenameVariableModelRustEditorExamples>>#rustScripterEditorWithBaselineNameMethod_refactoringsPreview | codeExpanded=false | previewExpanded | previewHeight=400}}
"
Class {
	#name : #GtPharoRenameBaselineCoderController,
	#superclass : #GtPharoRenameLiteralCoderController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameBaselineCoderController >> createRefactoringsStencil [
	^ GtPharoRenameBaselineRefactoringsStencil new
]

{ #category : #accessing }
GtPharoRenameBaselineCoderController >> createValidator [
	^ GtPharoRenameBaselineValidator new
]

{ #category : #accessing }
GtPharoRenameBaselineCoderController >> refactoringName [
	^ 'Rename class'
]
