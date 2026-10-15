Class {
	#name : #GtPharoRenameVariableCoderControllerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> editorWithInstAPlusOneMethod [
	<gtExample>
	<return: #GtTextEditorElement>
	| anEditor |
	anEditor := GtTextEditorElement new.
	anEditor text: self instAPlusOneMethod sourceCode asRopedText.
	^ anEditor
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> instAPlusOneCoderViewModel [
	<gtExample>
	<return: #GtPharoMethodCoderViewModel>
	^ (GtPharoMethodCoder forMethod: self instAPlusOneMethod) asCoderViewModel
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> instAPlusOneMethod [
	<gtExample>
	<return: #CompiledMethod>
	^ GtPharoDummyOneObject >> #instAPlusOne
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> instAVariableNode [
	<gtExample>
	<return: #GtPharoVariableNode>
	| anAst |
	anAst := (GtPharoMethodCoder forMethod: self instAPlusOneMethod) astSync.
	anAst allNodesDo: [ :each | 
		(each isVariable and: [ each source = 'instA' ]) ifTrue: [ ^ each ] ].
	^ self error: 'Variable instA must exist'
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> installedController [
	<gtExample>
	<return: #GtPharoRenameVariableTestCoderController>
	| aController aModel aSourceString aLog |
	aLog := OrderedCollection new.
	aController := self newInstalledControllerLogging: aLog.
	aModel := aController variableModel.
	aSourceString := aController sourceCoderViewModel sourceText asString.

	self assert: aModel isNotNil.
	self assert: aModel originalName equals: 'instA'.
	self assert: aModel originalIntervals size equals: 2.
	self
		assert: (aSourceString copyFrom: aModel primaryInterval first to: aModel primaryInterval last)
		equals: 'instA'.
	self
		assert: (aSourceString
				copyFrom: aModel otherIntervals first first
				to: aModel otherIntervals first last)
		equals: 'instA'.
	"editor, one other occurrence, refactorings preview"
	self assert: aController attributeTags size equals: 3.
	self assert: (aController editorElement userData at: #variableModel) equals: aModel.
	self assert: (aController editorElement userData at: #variableController) equals: aController.
	self assert: aLog size equals: 1.
	self assert: aLog first class equals: GtMethodCoderSaveDisabled.
	self assert: (aLog first preventors includes: aController).
	^ aController
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> installedController_cancel [
	<gtExample>
	<return: #GtPharoRenameVariableTestCoderController>
	| aController anEditor aLog |
	aLog := OrderedCollection new.
	aController := self newInstalledControllerLogging: aLog.
	anEditor := aController editorElement.

	aController variableModel requestCancelSource: self.

	self assert: aController attributeTags isNil.
	self assert: (anEditor userData includesKey: #variableModel) not.
	self assert: (anEditor userData includesKey: #variableController) not.
	self assert: aLog size equals: 2.
	self assert: aLog last class equals: GtMethodCoderSaveEnabled.
	^ aController
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> installedController_forbiddenName [
	<gtExample>
	<return: #GtPharoRenameVariableTestCoderController>
	| aController aModel |
	aController := self newInstalledController.
	aModel := aController variableModel.

	aModel updateCurrentName: 'VarA' source: self.
	self assert: aModel isValid.

	"`instA` is the original name, other instance variables of the class are not available"
	aModel updateCurrentName: 'instA' source: self.
	self assert: aModel isValid.
	aController sourceCoderViewModel behavior allInstVarNames
		reject: [ :each | each = 'instA' ]
		thenDo: [ :each | 
			aModel updateCurrentName: each source: self.
			self assert: aModel isValid not ].
	^ aController
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> installedController_refactorings [
	<gtExample>
	<return: #GtPharoRenameVariableTestCoderController>
	| aController aModel someRefactorings |
	aController := self newInstalledController.
	aModel := aController variableModel.

	self assert: aController computeRefactorings isEmpty.

	aModel updateCurrentName: 'instB' source: self.
	someRefactorings := aController computeRefactorings.
	self assert: someRefactorings size equals: 1.
	self assert: someRefactorings first class equals: GtRenameInstanceVariableRefactoring.

	aModel updateCurrentName: '1 invalid' source: self.
	self assert: aController computeRefactorings isEmpty.

	aModel updateCurrentName: 'instA' source: self.
	self assert: aController computeRefactorings isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> newInstalledController [
	"The document id is only known to an editor attached to a space. Attributes can be added without it."

	<gtExample>
	<return: #GtPharoRenameVariableTestCoderController>
	^ self newInstalledControllerLogging: OrderedCollection new
]

{ #category : #examples }
GtPharoRenameVariableCoderControllerExamples >> newInstalledControllerLogging: aLogCollection [
	"Install the controller and record save availability announcements of the coder view model."

	| aCoderViewModel |
	aCoderViewModel := self instAPlusOneCoderViewModel.
	aCoderViewModel announcer
		weak
		when: GtMethodCoderSaveDisabled, GtMethodCoderSaveEnabled
		do: [ :each | aLogCollection add: each ]
		for: aLogCollection.
	^ GtPharoRenameVariableTestCoderController new
		originalNode: self instAVariableNode;
		documentId: nil;
		editorElement: self editorWithInstAPlusOneMethod;
		sourceCoderViewModel: aCoderViewModel;
		install
]
