"
I contain examples of {{gtClass:GtPharoRenameClassVariableCoderController}} on {{gtMethod:GtPharoDummyOneObject>>#varA}}.
"
Class {
	#name : #GtPharoRenameClassVariableCoderControllerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-RustEditor-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> editorWithVarAMethod [
	<gtExample>
	<return: #GtTextEditorElement>
	| anEditor |
	anEditor := GtTextEditorElement new.
	anEditor text: self varAMethod sourceCode asRopedText.
	^ anEditor
]

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> installedController [
	<gtExample>
	<return: #GtPharoRenameClassVariableCoderController>
	| aController aModel |
	aController := self newInstalledController.
	aModel := aController variableModel.

	self assert: aModel originalName equals: 'VarA'.
	self assert: aModel otherIntervals isEmpty.
	"editor and refactorings preview"
	self assert: aController attributeTags size equals: 2.
	self assert: (aController editorElement userData at: #variableModel) equals: aModel.
	self assert: (aController editorElement userData at: #variableController) equals: aController.
	^ aController
]

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> installedController_cancel [
	<gtExample>
	<return: #GtPharoRenameClassVariableCoderController>
	| aController |
	aController := self newInstalledController.
	aController variableModel requestCancelSource: self.
	self assert: aController attributeTags isNil.
	self assert: aController editorElement userData isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> installedController_refactorings [
	"The refactoring is only applied to the refactoring model, the class in the image is not modified."

	<gtExample>
	<return: #GtPharoRenameClassVariableCoderController>
	| aController aModel someRefactorings aModelClass |
	aController := self newInstalledController.
	aModel := aController variableModel.

	self assert: aController computeRefactorings isEmpty.

	aModel updateCurrentName: 'VarB' source: self.
	someRefactorings := aController computeRefactorings.
	self assert: someRefactorings size equals: 1.
	self assert: someRefactorings first class equals: RBRenameClassVariableRefactoring.

	someRefactorings first primitiveExecute.
	aModelClass := someRefactorings first model classFor: GtPharoDummyOneObject.
	self assert: ((aModelClass sourceCodeFor: #varA) includesSubstring: 'VarB').
	self assert: ((GtPharoDummyOneObject >> #varA) sourceCode includesSubstring: 'VarA').
	self assert: (GtPharoDummyOneObject classVarNames includes: #VarA).

	aModel updateCurrentName: 'varB' source: self.
	self assert: aController computeRefactorings isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> installedController_validation [
	<gtExample>
	<return: #GtPharoRenameClassVariableCoderController>
	| aController aModel |
	aController := self newInstalledController.
	aModel := aController variableModel.

	aModel updateCurrentName: 'VarB' source: self.
	self assert: aModel isValid.
	"the original name is valid"
	aModel updateCurrentName: 'VarA' source: self.
	self assert: aModel isValid.
	"a class variable starts with an uppercase letter"
	aModel updateCurrentName: 'varB' source: self.
	self assert: aModel isValid not.
	"an instance variable of the class"
	aModel updateCurrentName: 'instA' source: self.
	self assert: aModel isValid not.
	"a global"
	aModel updateCurrentName: 'Object' source: self.
	self assert: aModel isValid not.
	"not a variable name"
	aModel updateCurrentName: 'Var B' source: self.
	self assert: aModel isValid not.
	^ aController
]

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> newInstalledController [
	<gtExample>
	<return: #GtPharoRenameClassVariableCoderController>
	^ GtPharoRenameClassVariableCoderController new
		originalNode: self varAVariableNode;
		documentId: nil;
		editorElement: self editorWithVarAMethod;
		sourceCoderViewModel: self varACoderViewModel;
		install
]

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> varACoderViewModel [
	<gtExample>
	<return: #GtPharoMethodCoderViewModel>
	^ (GtPharoMethodCoder forMethod: self varAMethod) asCoderViewModel
]

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> varAMethod [
	<gtExample>
	<return: #CompiledMethod>
	^ GtPharoDummyOneObject >> #varA
]

{ #category : #examples }
GtPharoRenameClassVariableCoderControllerExamples >> varAVariableNode [
	<gtExample>
	<return: #GtPharoNamedVariableNode>
	(GtPharoMethodCoder forMethod: self varAMethod) astSync
		allNodesDo: [ :each | 
			(each isVariable and: [ each source = 'VarA' ]) ifTrue: [ ^ each ] ].
	^ self error: 'Variable VarA must exist'
]
