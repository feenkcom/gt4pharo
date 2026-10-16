"
I rename the name of a package in a baseline method, e.g., 'GToolkit-Pharo-Coder-Examples' in {{gtMethod:GtPharoDummyBaseline>>#baseline:}}. The refactoring renames the package, see {{gtClass:GtPharoRenamePackageRefactoringsStencil}}. The new name must not be the name of an existing package, see {{gtClass:GtPharoRenamePackageValidator}}. I replace {{gtClass:GtRenamePackageInBaselineController}}. See {{gtMethod:GtPharoSourceCoder>>#renamePackageChoosingImplementation:in:from:}}.

# Example
{{gtExample:GtPharoRenameVariableModelRustEditorExamples>>#rustScripterEditorWithPackageNameMethod_refactoringsPreview | codeExpanded=false | previewExpanded | previewHeight=400}}
"
Class {
	#name : #GtPharoRenamePackageCoderController,
	#superclass : #GtPharoRenameLiteralCoderController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenamePackageCoderController >> createRefactoringsStencil [
	^ GtPharoRenamePackageRefactoringsStencil new
]

{ #category : #accessing }
GtPharoRenamePackageCoderController >> createValidator [
	^ GtPharoRenamePackageValidator new
]

{ #category : #accessing }
GtPharoRenamePackageCoderController >> refactoringName [
	^ 'Rename package'
]
