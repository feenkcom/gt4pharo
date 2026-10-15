"
I contain examples of {{gtClass:GtPharoRenameClassCoderController}} on {{gtMethod:GtPharoDummyOneObject>>#dummyThree}}.
"
Class {
	#name : #GtPharoRenameClassCoderControllerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> dummyThreeClassNode [
	<gtExample>
	<return: #GtPharoNamedVariableNode>
	(GtPharoMethodCoder forMethod: self dummyThreeMethod) astSync
		allNodesDo: [ :each | 
			(each isVariable and: [ each source = 'GtPharoDummyThreeObject' ])
				ifTrue: [ ^ each ] ].
	^ self error: 'The class must be referenced'
]

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> dummyThreeCoderViewModel [
	<gtExample>
	<return: #GtPharoMethodCoderViewModel>
	^ (GtPharoMethodCoder forMethod: self dummyThreeMethod) asCoderViewModel
]

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> dummyThreeMethod [
	<gtExample>
	<return: #CompiledMethod>
	^ GtPharoDummyOneObject >> #dummyThree
]

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> editorWithDummyThreeMethod [
	<gtExample>
	<return: #GtTextEditorElement>
	| anEditor |
	anEditor := GtTextEditorElement new.
	anEditor text: self dummyThreeMethod sourceCode asRopedText.
	^ anEditor
]

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> installedController [
	<gtExample>
	<return: #GtPharoRenameClassCoderController>
	| aController aModel |
	aController := self newInstalledController.
	aModel := aController variableModel.

	self assert: aModel originalName equals: 'GtPharoDummyThreeObject'.
	self assert: aModel otherIntervals isEmpty.
	"editor and refactorings preview"
	self assert: aController attributeTags size equals: 2.
	self assert: (aController editorElement userData at: #variableModel) equals: aModel.
	self assert: (aController editorElement userData at: #variableController) equals: aController.
	^ aController
]

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> installedController_cancel [
	<gtExample>
	<return: #GtPharoRenameClassCoderController>
	| aController |
	aController := self newInstalledController.
	aController variableModel requestCancelSource: self.
	self assert: aController attributeTags isNil.
	self assert: aController editorElement userData isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> installedController_refactorings [
	"The refactoring is only applied to the refactoring model, the class in the image is not renamed."

	<gtExample>
	<return: #GtPharoRenameClassCoderController>
	| aController aModel someRefactorings aModelClass |
	aController := self newInstalledController.
	aModel := aController variableModel.

	self assert: aController computeRefactorings isEmpty.

	aModel updateCurrentName: 'GtPharoDummyThreeObjectRenamed' source: self.
	someRefactorings := aController computeRefactorings.
	self assert: someRefactorings size equals: 1.
	self assert: someRefactorings first class equals: GtRBRenameClassRefactoring.

	someRefactorings first primitiveExecute.
	aModelClass := someRefactorings first model classFor: GtPharoDummyOneObject.
	self
		assert: ((aModelClass sourceCodeFor: #dummyThree)
				includesSubstring: 'GtPharoDummyThreeObjectRenamed').
	self assert: (Smalltalk globals includesKey: #GtPharoDummyThreeObject).
	self assert: (Smalltalk globals includesKey: #GtPharoDummyThreeObjectRenamed) not.

	aModel updateCurrentName: 'gtPharoDummyThreeObjectRenamed' source: self.
	self assert: aController computeRefactorings isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> installedController_validation [
	<gtExample>
	<return: #GtPharoRenameClassCoderController>
	| aController aModel |
	aController := self newInstalledController.
	aModel := aController variableModel.

	aModel updateCurrentName: 'GtPharoDummyThreeObjectRenamed' source: self.
	self assert: aModel isValid.
	"a class name starts with an uppercase letter"
	aModel updateCurrentName: 'gtPharoDummyThreeObjectRenamed' source: self.
	self assert: aModel isValid not.
	"an existing class"
	aModel updateCurrentName: 'Object' source: self.
	self assert: aModel isValid not.
	"not a name"
	aModel updateCurrentName: 'Dummy Three' source: self.
	self assert: aModel isValid not.
	^ aController
]

{ #category : #examples }
GtPharoRenameClassCoderControllerExamples >> newInstalledController [
	<gtExample>
	<return: #GtPharoRenameClassCoderController>
	^ GtPharoRenameClassCoderController new
		originalNode: self dummyThreeClassNode;
		documentId: nil;
		editorElement: self editorWithDummyThreeMethod;
		sourceCoderViewModel: self dummyThreeCoderViewModel;
		install
]
