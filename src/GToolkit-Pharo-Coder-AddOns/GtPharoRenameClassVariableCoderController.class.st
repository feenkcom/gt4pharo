"
I rename a class variable in a coder. The new name must be a valid class variable name, see {{gtClass:GtPharoRenameClassVariableValidator}}, and must not be the name of a variable in the hierarchy of the class. I replace {{gtClass:GtRenameClassVariableController}}. See {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}}.

# Example
{{gtExample:GtPharoRenameVariableModelRustEditorExamples>>#rustScripterEditorWithVarAMethod_refactoringsPreview | codeExpanded=false | previewExpanded | previewHeight=400}}
"
Class {
	#name : #GtPharoRenameClassVariableCoderController,
	#superclass : #GtPharoRenameVariableCoderController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #hooks }
GtPharoRenameClassVariableCoderController >> createRefactoringsStencil [
	^ GtPharoRenameClassVariableRefactoringsStencil new
]

{ #category : #hooks }
GtPharoRenameClassVariableCoderController >> createValidator [
	^ GtPharoRenameClassVariableValidator new
]

{ #category : #hooks }
GtPharoRenameClassVariableCoderController >> forbiddenNames [
	"The new name must not be the name of a variable in the hierarchy of the class, see {{gtMethod:RBRenameClassVariableRefactoring>>#applicabilityPreconditions}}."

	| aClass |
	aClass := sourceCoderViewModel behavior instanceSide.
	^ Array
		streamContents: [ :aStream | 
			(aClass withAllSuperclasses , aClass allSubclasses)
				do: [ :each | 
					aStream nextPutAll: each instVarNames.
					each classVarNames do: [ :eachName | aStream nextPut: eachName asString ] ] ]
]

{ #category : #hooks }
GtPharoRenameClassVariableCoderController >> refactoringName [
	^ 'Rename class variable'
]
