"
I compute refactorings that apply a rename of a {{gtClass:GtPharoRenameVariableModel}}. I return no refactoring if the name is not modified or not valid. My subclasses create the refactoring, see {{gtMethod:GtPharoRenameVariableRefactoringsStencil>>#computeRefactoring}}. I am the counterpart of {{gtClass:GtPharoRenameSelectorRefactoringsStencil}}.
"
Class {
	#name : #GtPharoRenameVariableRefactoringsStencil,
	#superclass : #Object,
	#instVars : [
		'variableModel',
		'sourceCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #creation }
GtPharoRenameVariableRefactoringsStencil >> computeRefactoring [
	"Return a refactoring that renames `variableModel originalName` to `variableModel currentName`, or nil."

	^ self subclassResponsibility
]

{ #category : #creation }
GtPharoRenameVariableRefactoringsStencil >> computeRefactorings [
	"Return no refactoring if the name is not modified or not valid."

	(variableModel isModified and: [ variableModel isValid ]) ifFalse: [ ^ #() ].
	^ self computeRefactoring
		ifNil: [ #() ]
		ifNotNil: [ :aRefactoring | {aRefactoring} ]
]

{ #category : #creation }
GtPharoRenameVariableRefactoringsStencil >> create [
	^ self computeRefactorings
]

{ #category : #creation }
GtPharoRenameVariableRefactoringsStencil >> createModel [
	"Same idea as {{gtMethod:GtPharoSourceCoderRefactoringController>>#createModel}}, but the source of the coder is never modified before accepting, so it is compiled into the model only if it differs from the class source."

	| aModel aModelClass |
	aModel := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	aModel name: self refactoringName.
	sourceCoderViewModel coderModel isForMethod ifFalse: [ ^ aModel ].

	aModelClass := aModel classFor: sourceCoderViewModel behavior.
	aModel changes
		attributeNamed: #defaultClassFilterName
		put: aModelClass instanceSide name.
	(aModelClass sourceCodeFor: sourceCoderViewModel selector)
		~= sourceCoderViewModel sourceText asString
		ifTrue: [ aModelClass
				compile: sourceCoderViewModel sourceText asString
				classified: sourceCoderViewModel protocol ].
	^ aModel
]

{ #category : #accessing }
GtPharoRenameVariableRefactoringsStencil >> refactoringName [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoRenameVariableRefactoringsStencil >> sourceCoderViewModel [
	^ sourceCoderViewModel
]

{ #category : #accessing }
GtPharoRenameVariableRefactoringsStencil >> sourceCoderViewModel: anObject [
	sourceCoderViewModel := anObject
]

{ #category : #accessing }
GtPharoRenameVariableRefactoringsStencil >> variableModel [
	^ variableModel
]

{ #category : #accessing }
GtPharoRenameVariableRefactoringsStencil >> variableModel: anObject [
	variableModel := anObject
]
