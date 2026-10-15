"
I contain examples of {{gtClass:GtPharoRenameTemporaryCoderController}} on {{gtMethod:GtPharoDummyOneObject>>#tempReceiver}}.
"
Class {
	#name : #GtPharoRenameTemporaryCoderControllerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> controllerWithShadowedVariable [
	"A variable of a nested scope that has the same name is not renamed."

	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	| aSource anAst aNode aController |
	aSource := 'foo
	| a |
	a := 1.
	^ [ :a | a ] value: a'.
	anAst := GtPharoParser parse: aSource.
	anAst allNodesDo: [ :each | 
		(aNode isNil and: [ each isVariable and: [ each source = 'a' ] ])
			ifTrue: [ aNode := each ] ].
	aController := GtPharoRenameTemporaryCoderController new
			originalNode: aNode;
			sourceCoderViewModel: self tempReceiverCoderViewModel.

	"the assignment and the last reference, not the argument of the block and its reference"
	self assert: aController otherRenameIntervals size equals: 2.
	aController otherRenameIntervals
		do: [ :each | 
			self assert: (aSource copyFrom: each first to: each last) equals: 'a'.
			self assert: (each first < (aSource indexOf: $[) or: [ each first > (aSource indexOf: $]) ]) ].
	"the name of the variable of the block is not available"
	self assert: (aController forbiddenNames includes: 'a').
	^ aController
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> editorWithTempReceiverMethod [
	<gtExample>
	<return: #GtTextEditorElement>
	| anEditor |
	anEditor := GtTextEditorElement new.
	anEditor text: self tempReceiverMethod sourceCode asRopedText.
	^ anEditor
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> installedController [
	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	| aController aModel |
	aController := self newInstalledController.
	aModel := aController variableModel.

	self assert: aModel originalName equals: 'a'.
	"the declaration, the assignment, and the reference"
	self assert: aModel originalIntervals size equals: 3.
	"the editor and two other occurrences, there is no refactorings preview"
	self assert: aController attributeTags size equals: 3.
	self assert: (aController editorElement userData at: #variableModel) equals: aModel.
	self assert: (aController editorElement userData at: #variableController) equals: aController.
	^ aController
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> installedController_accept [
	"Enter replaces the text of all occurrences."

	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	| aController aViewModel anExpectedSource aLog |
	aLog := OrderedCollection new.
	aController := self newInstalledController.
	aViewModel := aController sourceCoderViewModel.
	anExpectedSource := aViewModel sourceText asString.
	anExpectedSource := anExpectedSource copyReplaceAll: '| a b |' with: '| x b |'.
	anExpectedSource := anExpectedSource copyReplaceAll: 'a := 3' with: 'x := 3'.
	anExpectedSource := anExpectedSource copyReplaceAll: '^ a raisedTo' with: '^ x raisedTo'.

	aController variableModel updateCurrentName: 'x' source: self.
	aController variableModel requestRefactoringsPreviewSource: self.

	self assert: aViewModel sourceText asString equals: anExpectedSource.
	self assert: aController attributeTags isNil.
	self assert: aController editorElement userData isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> installedController_acceptInvalidName [
	"An invalid name is not applied, the rename stays installed."

	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	| aController aViewModel anOriginalSource |
	aController := self newInstalledController.
	aViewModel := aController sourceCoderViewModel.
	anOriginalSource := aViewModel sourceText asString.

	aController variableModel updateCurrentName: 'x y' source: self.
	aController variableModel requestRefactoringsPreviewSource: self.

	self assert: aViewModel sourceText asString equals: anOriginalSource.
	self assert: aController attributeTags isNotNil.
	^ aController
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> installedController_acceptWithoutChange [
	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	| aController aViewModel anOriginalSource |
	aController := self newInstalledController.
	aViewModel := aController sourceCoderViewModel.
	anOriginalSource := aViewModel sourceText asString.

	aController variableModel requestRefactoringsPreviewSource: self.

	self assert: aViewModel sourceText asString equals: anOriginalSource.
	self assert: aController attributeTags isNil.
	^ aController
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> installedController_cancel [
	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	| aController aViewModel anOriginalSource |
	aController := self newInstalledController.
	aViewModel := aController sourceCoderViewModel.
	anOriginalSource := aViewModel sourceText asString.

	aController variableModel updateCurrentName: 'x' source: self.
	aController variableModel requestCancelSource: self.

	self assert: aViewModel sourceText asString equals: anOriginalSource.
	self assert: aController attributeTags isNil.
	self assert: aController editorElement userData isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> installedController_noRefactorings [
	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	| aController |
	aController := self newInstalledController.
	aController variableModel updateCurrentName: 'x' source: self.
	self assert: aController computeRefactorings isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> installedController_validation [
	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	| aController aModel |
	aController := self newInstalledController.
	aModel := aController variableModel.

	aModel updateCurrentName: 'x' source: self.
	self assert: aModel isValid.
	"another temporary variable of the method"
	aModel updateCurrentName: 'b' source: self.
	self assert: aModel isValid not.
	"a reserved name"
	aModel updateCurrentName: 'self' source: self.
	self assert: aModel isValid not.
	"an instance variable of the class"
	aModel updateCurrentName: 'instA' source: self.
	self assert: aModel isValid not.
	"a class variable of the class"
	aModel updateCurrentName: 'VarA' source: self.
	self assert: aModel isValid not.
	"not a variable name"
	aModel updateCurrentName: 'x y' source: self.
	self assert: aModel isValid not.
	^ aController
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> newInstalledController [
	<gtExample>
	<return: #GtPharoRenameTemporaryCoderController>
	^ GtPharoRenameTemporaryCoderController new
		originalNode: self temporaryNodeA;
		documentId: nil;
		editorElement: self editorWithTempReceiverMethod;
		sourceCoderViewModel: self tempReceiverCoderViewModel;
		install
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> tempReceiverCoderViewModel [
	<gtExample>
	<return: #GtPharoMethodCoderViewModel>
	^ (GtPharoMethodCoder forMethod: self tempReceiverMethod) asCoderViewModel
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> tempReceiverMethod [
	<gtExample>
	<return: #CompiledMethod>
	^ GtPharoDummyOneObject >> #tempReceiver
]

{ #category : #examples }
GtPharoRenameTemporaryCoderControllerExamples >> temporaryNodeA [
	"The declaration of the temporary variable a."

	<gtExample>
	<return: #GtPharoNamedVariableNode>
	(GtPharoMethodCoder forMethod: self tempReceiverMethod) astSync
		allNodesDo: [ :each | 
			(each isVariable and: [ each source = 'a' ]) ifTrue: [ ^ each ] ].
	^ self error: 'Variable a must exist'
]
