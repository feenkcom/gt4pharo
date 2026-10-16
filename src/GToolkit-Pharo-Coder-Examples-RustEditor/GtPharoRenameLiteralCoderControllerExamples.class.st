"
I exemplify {{gtClass:GtPharoRenameBaselineCoderController}} and {{gtClass:GtPharoRenamePackageCoderController}} on {{gtMethod:GtPharoDummyBaseline>>#baseline:}}. Refactorings are executed only on the refactoring model, the image is not changed. Examples with a Rust text editor are in {{gtClass:GtPharoRenameVariableModelRustEditorExamples}}.
"
Class {
	#name : #GtPharoRenameLiteralCoderControllerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-RustEditor-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> baselineCoderViewModel [
	<gtExample>
	<return: #GtPharoMethodCoderViewModel>
	^ (GtPharoMethodCoder forMethod: self baselineMethod) asCoderViewModel
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> baselineMethod [
	<gtExample>
	<return: #CompiledMethod>
	^ GtPharoDummyBaseline >> #baseline:
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> baselineNode [
	<gtExample>
	<return: #GtPharoStringLiteralNode>
	^ self literalNodeNamed: 'GtPharoDummyBaselineTarget'
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> editorWithBaselineMethod [
	<gtExample>
	<return: #GtTextEditorElement>
	| anEditor |
	anEditor := GtTextEditorElement new.
	anEditor text: self baselineMethod sourceCode asRopedText.
	^ anEditor
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> installedBaselineController [
	"The name is in the baseline method twice, the intervals do not include quotes."

	<gtExample>
	<return: #GtPharoRenameBaselineCoderController>
	| aController aModel aSource |
	aController := self newInstalledBaselineController.
	aModel := aController variableModel.
	aSource := self baselineMethod sourceCode.

	self assert: aModel originalName equals: 'GtPharoDummyBaselineTarget'.
	self assert: aModel originalIntervals size equals: 2.
	aModel originalIntervals
		do: [ :eachInterval | 
			self
				assert: (aSource copyFrom: eachInterval first to: eachInterval last)
				equals: 'GtPharoDummyBaselineTarget' ].
	"the editor, one other occurrence, and the refactorings preview"
	self assert: aController attributeTags size equals: 3.
	self assert: (aController editorElement userData at: #variableModel) equals: aModel.
	^ aController
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> installedBaselineController_cancel [
	<gtExample>
	<return: #GtPharoRenameBaselineCoderController>
	| aController anOriginalSource |
	aController := self newInstalledBaselineController.
	anOriginalSource := aController sourceCoderViewModel sourceText asString.

	aController variableModel updateCurrentName: 'X' source: self.
	aController variableModel requestCancelSource: self.

	self assert: aController sourceCoderViewModel sourceText asString equals: anOriginalSource.
	self assert: aController attributeTags isNil.
	self assert: aController editorElement userData isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> installedBaselineController_refactorings [
	"The refactoring is only applied to the refactoring model, the image is not changed."

	<gtExample>
	<return: #GtPharoRenameBaselineCoderController>
	| aController aModel someRefactorings aModelClass aNewSource |
	aController := self newInstalledBaselineController.
	aModel := aController variableModel.
	self assert: aController computeRefactorings isEmpty.

	aModel updateCurrentName: 'GtPharoDummyBaselineRenamed' source: self.
	someRefactorings := aController computeRefactorings.
	self assert: someRefactorings size equals: 1.
	self assert: someRefactorings first class equals: GtRBRenameClassRefactoring.

	someRefactorings first primitiveExecute.
	aModelClass := someRefactorings first model classFor: GtPharoDummyBaseline.
	aNewSource := aModelClass sourceCodeFor: #baseline:.
	self assert: (aNewSource includesSubstring: '''GtPharoDummyBaselineRenamed''').
	self assert: (aNewSource includesSubstring: 'GtPharoDummyBaselineTarget') not.
	self
		assert: (someRefactorings first model includesClassNamed: #BaselineOfGtPharoDummyBaselineRenamed).
	self assert: (Smalltalk globals includesKey: #BaselineOfGtPharoDummyBaselineTarget).
	self
		assert: (Smalltalk globals includesKey: #BaselineOfGtPharoDummyBaselineRenamed) not.
	self
		assert: (self baselineMethod sourceCode includesSubstring: 'GtPharoDummyBaselineTarget').
	^ aController
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> installedBaselineController_validation [
	<gtExample>
	<return: #GtPharoRenameBaselineCoderController>
	| aModel |
	aModel := self newInstalledBaselineController variableModel.

	aModel updateCurrentName: 'GtPharoDummyBaselineRenamed' source: self.
	self assert: aModel isValid.
	"the class BaselineOfGToolkitExamplesEngine exists"
	aModel updateCurrentName: 'GToolkitExamplesEngine' source: self.
	self assert: aModel isValid not.
	aModel updateCurrentName: 'Dummy Baseline' source: self.
	self assert: aModel isValid not.
	^ self newInstalledBaselineController
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> installedPackageController [
	<gtExample>
	<return: #GtPharoRenamePackageCoderController>
	| aController aModel aSource |
	aController := self newInstalledPackageController.
	aModel := aController variableModel.
	aSource := self baselineMethod sourceCode.

	self assert: aModel originalName equals: 'GToolkit-Pharo-Coder-Examples'.
	self assert: aModel originalIntervals size equals: 2.
	aModel originalIntervals
		do: [ :eachInterval | 
			self
				assert: (aSource copyFrom: eachInterval first to: eachInterval last)
				equals: 'GToolkit-Pharo-Coder-Examples' ].
	self assert: aController attributeTags size equals: 3.
	^ aController
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> installedPackageController_refactorings [
	<gtExample>
	<return: #GtPharoRenamePackageCoderController>
	| aController aModel someRefactorings aModelClass aNewSource |
	aController := self newInstalledPackageController.
	aModel := aController variableModel.
	self assert: aController computeRefactorings isEmpty.

	aModel updateCurrentName: 'GToolkit-Pharo-Coder-Examples-Renamed' source: self.
	someRefactorings := aController computeRefactorings.
	self assert: someRefactorings size equals: 1.
	self assert: someRefactorings first class equals: GtRBRenamePackageRefactoring.

	someRefactorings first primitiveExecute.
	aModelClass := someRefactorings first model classFor: GtPharoDummyBaseline.
	aNewSource := aModelClass sourceCodeFor: #baseline:.
	self assert: (aNewSource includesSubstring: '''GToolkit-Pharo-Coder-Examples-Renamed''').
	self assert: (Smalltalk packageOrganizer includesPackageNamed: 'GToolkit-Pharo-Coder-Examples').
	self
		assert: (Smalltalk packageOrganizer includesPackageNamed: 'GToolkit-Pharo-Coder-Examples-Renamed') not.
	^ aController
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> installedPackageController_validation [
	<gtExample>
	<return: #GtPharoRenamePackageCoderController>
	| aModel |
	aModel := self newInstalledPackageController variableModel.

	"a package name is not a variable name"
	aModel updateCurrentName: 'GToolkit-Pharo-Coder-Examples-Renamed' source: self.
	self assert: aModel isValid.
	"an existing package"
	aModel updateCurrentName: 'GToolkit-Pharo-Coder' source: self.
	self assert: aModel isValid not.
	aModel updateCurrentName: ' ' source: self.
	self assert: aModel isValid not.
	^ self newInstalledPackageController
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> literalNodeNamed: aString [
	"The first literal with the given value."

	<return: #GtPharoStringLiteralNode>
	self baselineCoderViewModel coderModel astSync
		allNodesDo: [ :each | 
			(each isLiteral and: [ each isErrorNode not and: [ each literalValue = aString ] ])
				ifTrue: [ ^ each ] ].
	^ self error: 'Literal ' , aString , ' must exist'
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> newInstalledBaselineController [
	<gtExample>
	<return: #GtPharoRenameBaselineCoderController>
	^ self newInstalledController: GtPharoRenameBaselineCoderController node: self baselineNode
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> newInstalledController: aControllerClass node: aNode [
	^ aControllerClass new
		originalNode: aNode;
		documentId: nil;
		editorElement: self editorWithBaselineMethod;
		sourceCoderViewModel: self baselineCoderViewModel;
		install
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> newInstalledPackageController [
	<gtExample>
	<return: #GtPharoRenamePackageCoderController>
	^ self newInstalledController: GtPharoRenamePackageCoderController node: self packageNode
]

{ #category : #examples }
GtPharoRenameLiteralCoderControllerExamples >> packageNode [
	<gtExample>
	<return: #GtPharoStringLiteralNode>
	^ self literalNodeNamed: 'GToolkit-Pharo-Coder-Examples'
]
