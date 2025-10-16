"
I exemplify refactorings code, e.g., {{gtClass:GtRefactoringsBasicElement}} in isolation.
Refactorings in a context of pharo coder are available in {{gtClass:GtPharoCoderByScripterExamples}} 

"
Class {
	#name : #GtRefactoringsExamples,
	#superclass : #Object,
	#instVars : [
		'environment',
		'rootClass',
		'nonRootClass',
		'leafClass',
		'leafClassInstVarName'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Refactorings'
}

{ #category : #'examples - view model' }
GtRefactoringsExamples >> basicConfirmationViewModel [
	<gtExample>
	| aViewModel |
	aViewModel := GtRefactoringsWithConfirmationViewModel new.

	self assert: aViewModel refactoringTitle isNil.
	self assert: aViewModel targetName isNil.
	self assert: aViewModel confirmationLabel equals: 'Confirm'.
	self assert: aViewModel refactoringsWithConfirmationComputation isNotNil.

	^ aViewModel
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> basicInputElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsInputElement new.

	self
		assert: (anElement childWithId: #refactoringEditor) viewModel mode class
		equals: BrTextEditorEditableSingleLineMode.
	self
		assert: (anElement childWithId: #refactoringEditor) text asString
		equals: ''.
	self
		assert: (anElement childWithId: #refactoringInputLabel) text asString
		equals: 'Input:'.

	^ anElement
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> basicInputViewModel [
	<gtExample>
	| aViewModel |
	aViewModel := GtRefactoringsWithInputViewModel new.

	self assert: aViewModel refactoringTitle isNil.
	self assert: aViewModel targetName isNil.
	self assert: aViewModel refactoringsWithInputComputation isNotNil.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> basicInputWidgetViewModel [
	<gtExample>
	| aViewModel |
	aViewModel := GtRefactoringsWithInputWidgetViewModel new.

	self assert: aViewModel refactoringTitle isNil.
	self assert: aViewModel targetName isNil.
	self assert: aViewModel inputElement isNil.

	^ aViewModel
]

{ #category : #'examples - just preview element' }
GtRefactoringsExamples >> basicJustPreviewElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsJustPreviewElement new.

	self
		assert: (anElement query / #preview) anyOne visibility
		equals: BlVisibility gone.

	^ anElement
]

{ #category : #'examples - messages element' }
GtRefactoringsExamples >> basicMessagesElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsMessagesElement new.

	self
		assert: (anElement query / #refactoringMessagesContainer) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query / #refactoringMessagesContainer) anyOne childrenCount
		equals: 0.

	^ anElement
]

{ #category : #'examples - preview with confirmation element' }
GtRefactoringsExamples >> basicPreviewWithConfirmationElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsPreviewWithConfirmationElement new.

	self assert: (anElement query // #progress) isEmpty.

	^ anElement
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> basicPreviewWithInputElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsPreviewWithInputElement new.

	self
		assert: (anElement query / GtRefactoringsToolbarElement) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #progress) isEmpty.

	^ anElement
]

{ #category : #'examples - preview with input widget element' }
GtRefactoringsExamples >> basicPreviewWithInputWidgetElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsPreviewWithInputWidgetElement new.

	^ anElement
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> basicToolbarElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsToolbarElement new.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isDisabled.

	^ anElement
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> confirmationViewModel [
	<gtExample>
	| aViewModel aConfirmationLabel aTargetName |
	aViewModel := self basicConfirmationViewModel.
	aViewModel optionAt: #dummyEnvironment put: self environment.
	aConfirmationLabel := 'Push up {1}' format: {self leafClassInstVarName}.
	aTargetName := '{1}''s {2} instance variable'
			format: {self leafClass name.
					self leafClassInstVarName}.

	aViewModel
		refactoringTitle: 'Push up';
		targetName: aTargetName;
		confirmationLabel: aConfirmationLabel;
		refactoringWithConfirmation: [ RBPullUpInstanceVariableRefactoring
				variable: self leafClassInstVarName
				class: self leafClass superclass ].

	self assert: aViewModel confirmationLabel equals: aConfirmationLabel.
	self assert: aViewModel targetName equals: aTargetName.
	self assert: aViewModel refactoringsWithConfirmationComputation isNotNil.

	^ aViewModel
]

{ #category : #'examples - environment' }
GtRefactoringsExamples >> environment [
	<gtExample>
	environment
		ifNil: [ environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2 ].

	^ environment
]

{ #category : #'examples - support' }
GtRefactoringsExamples >> extraLongClassName [
	^ 'WithVeryVeryVeryLongName1234'
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicInputElement.
	aViewModel := self inputViewModel.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #refactoringEditor) viewModel mode class
		equals: BrTextEditorEditableSingleLineMode.
	self
		assert: (anElement childWithId: #refactoringEditor) text asString
		equals: 'NewClass'.
	self
		assert: (anElement childWithId: #refactoringInputLabel) text asString
		equals: 'Superclass:'.

	^ anElement
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementEmptyComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicInputElement.
	aViewModel := self inputViewModelEmptyComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #refactoringEditor) viewModel mode class
		equals: BrTextEditorEditableSingleLineMode.
	self
		assert: (anElement childWithId: #refactoringEditor) text asString
		equals: 'NewClass'.
	self
		assert: (anElement childWithId: #refactoringInputLabel) text asString
		equals: 'Superclass:'.

	^ anElement
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementEmptyComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self inputElementEmptyComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	aScripter editor
		requestFocus;
		assertHasFocus;
		assertTextEqualsTo: 'NewClass';
		selectAll;
		assertIsEditableSingleLineMode;
		type: self rootClass name;
		type: 'Superclass';
		assertTextEqualsTo: self superclassFromRootClassName;
		play.

	self assert: allAnnouncements size equals: 0.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	aScripter editor
		assertHasFocus;
		pressReturn;
		assertIsEditableSingleLineMode;
		assertTextEqualsTo: self superclassFromRootClassName;
		play.

	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	^ aScripter
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementExceptionComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicInputElement.
	aViewModel := self inputViewModelExceptionComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #refactoringEditor) viewModel mode class
		equals: BrTextEditorEditableSingleLineMode.
	self
		assert: (anElement childWithId: #refactoringEditor) text asString
		equals: self superclassFromRootClassName.
	self
		assert: (anElement childWithId: #refactoringInputLabel) text asString
		equals: 'Superclass:'.

	^ anElement
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementExceptionComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self inputElementExceptionComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	aScripter editor
		requestFocus;
		assertHasFocus;
		assertIsEditableSingleLineMode;
		assertTextEqualsTo: self superclassFromRootClassName;
		play.

	self assert: allAnnouncements size equals: 0.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	aScripter editor
		assertHasFocus;
		pressReturn;
		assertIsEditableSingleLineMode;
		play.

	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	^ aScripter
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementFaultyComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicInputElement.
	aViewModel := self inputViewModelFaultyComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #refactoringEditor) viewModel mode class
		equals: BrTextEditorEditableSingleLineMode.
	self
		assert: (anElement childWithId: #refactoringEditor) text asString
		equals: self nonRootClass name.
	self
		assert: (anElement childWithId: #refactoringInputLabel) text asString
		equals: 'Superclass:'.

	^ anElement
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementFaultyComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self inputElementFaultyComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	aScripter editor
		requestFocus;
		assertHasFocus;
		assertTextEqualsTo: self nonRootClass name;
		assertIsEditableSingleLineMode;
		play.

	self assert: allAnnouncements size equals: 0.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	aScripter editor
		assertHasFocus;
		pressReturn;
		assertIsEditableSingleLineMode;
		play.

	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.
	self assert: aViewModel executedRefactorings errorMessages size equals: 1.

	^ aScripter
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self inputElement.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	aScripter editor
		requestFocus;
		assertHasFocus;
		selectAll;
		assertIsEditableSingleLineMode;
		type: self rootClass name;
		type: 'Superclass';
		assertTextEqualsTo: self superclassFromRootClassName;
		play.

	self assert: allAnnouncements size equals: 0.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	aScripter editor
		assertHasFocus;
		pressReturn;
		assertIsEditableSingleLineMode;
		play.

	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	^ aScripter
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementScripter_submit [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self inputElementScripter.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter do 
		label: 'Notify submit executed refactorings requested';
		block: [ aViewModel notifySubmitExecutedRefactoringsRequested ];
		play.
		
	aScripter editor
		requestFocus;
		assertHasFocus;
		assertIsEditableSingleLineMode;
		assertTextEqualsTo: self superclassFromRootClassName;
		play.

	self assert: allAnnouncements size equals: 2.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelSubmitExecutedRefactoringsRequested.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	^ aScripter
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementSomeComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicInputElement.
	aViewModel := self inputViewModelSomeComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #refactoringEditor) viewModel mode class
		equals: BrTextEditorEditableSingleLineMode.
	self
		assert: (anElement childWithId: #refactoringEditor) text asString
		equals: self superclassFromRootClassName.
	self
		assert: (anElement childWithId: #refactoringInputLabel) text asString
		equals: 'Superclass:'.

	^ anElement
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElementSomeComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self inputElementSomeComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	aScripter editor
		requestFocus;
		assertHasFocus;
		assertTextEqualsTo: self superclassFromRootClassName;
		assertIsEditableSingleLineMode;
		play.

	self assert: allAnnouncements size equals: 0.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	aScripter editor
		assertHasFocus;
		pressReturn;
		assertIsEditableSingleLineMode;
		play.

	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.
	self assert: aViewModel executedRefactorings errorMessages size equals: 0.

	^ aScripter
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> inputViewModel [
	<gtExample>
	| aViewModel |
	aViewModel := self basicInputViewModel.
	aViewModel optionAt: #dummyEnvironment put: self environment.

	aViewModel
		refactoringTitle: 'Create as sibling';
		targetName: self rootClass name;
		inputLabel: 'Superclass:';
		initialText: 'NewClass';
		refactoringWithInput: [ :anInput | 
			GtChildrenToSiblingsRefactoring
				name: anInput
				class: self rootClass
				subclasses: self rootClass subclasses ].
	
	self assert: aViewModel refactoringTitle equals: 'Create as sibling'.
	self assert: aViewModel targetName equals: self rootClass name.
	self assert: aViewModel refactoringsWithInputComputation isNotNil.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> inputViewModelEmptyComputedRefactorings [
	<gtExample>
	| aViewModel aCollection allAnnouncements |
	aViewModel := self inputViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel optionAt: #allAnnouncements put: allAnnouncements.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aViewModel computeRefactoringsFrom: self.
	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements anyOne class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.

	aCollection := aViewModel executedRefactorings executedRefactorings.
	self assert: aCollection size equals: 0.
	self assert: aViewModel executedRefactorings errorMessages size equals: 0.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> inputViewModelExceptionComputedRefactorings [
	<gtExample>
	| aViewModel allAnnouncements |
	aViewModel := self inputViewModelWithException.
	allAnnouncements := OrderedCollection new.
	aViewModel optionAt: #allAnnouncements put: allAnnouncements.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aViewModel refactoringsForInput: self superclassFromRootClassName.
	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements anyOne class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> inputViewModelFaultyComputedRefactorings [
	<gtExample>
	| aViewModel aCollection allAnnouncements anotherClass |
	aViewModel := self inputViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel optionAt: #allAnnouncements put: allAnnouncements.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.
	
	anotherClass := self nonRootClass.

	aViewModel refactoringsForInput: ('{1}' format: {anotherClass realClass name}).
	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements anyOne class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.

	aViewModel computeRefactoringsFrom: self.
	self assert: allAnnouncements size equals: 2.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.

	aCollection := aViewModel executedRefactorings executedRefactorings.
	self assert: aCollection size equals: 1.
	self assert: aViewModel executedRefactorings errorMessages size equals: 1.
	
	^ aViewModel
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> inputViewModelSomeComputedRefactorings [
	<gtExample>
	| aViewModel aCollection allAnnouncements |
	aViewModel := self inputViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel optionAt: #allAnnouncements put: allAnnouncements.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aViewModel refactoringsForInput: self superclassFromRootClassName.
	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements anyOne class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.

	aViewModel computeRefactoringsFrom: self.
	self assert: allAnnouncements size equals: 2.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.

	aCollection := aViewModel executedRefactorings executedRefactorings.
	self assert: aCollection size equals: 1.

	self assert: aViewModel executedRefactorings errorMessages size equals: 0.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> inputViewModelWithException [
	<gtExample>
	| aViewModel |
	aViewModel := self basicInputViewModel.
	aViewModel optionAt: #dummyEnvironment put: self environment.

	aViewModel
		refactoringTitle: 'Create as sibling';
		targetName: self rootClass name;
		inputLabel: 'Superclass:';
		initialText: 'NewClass';
		refactoringWithInput: [ :anInput | 
			1/0.
			GtChildrenToSiblingsRefactoring
				name: anInput
				class: self rootClass
				subclasses: self rootClass subclasses ].
	
	self assert: aViewModel refactoringTitle equals: 'Create as sibling'.
	self assert: aViewModel targetName equals: self rootClass name.
	self assert: aViewModel refactoringsWithInputComputation isNotNil.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtRefactoringsExamples >> inputWidgetViewModel [
	<gtExample>
	| aViewModel aSource |
	aViewModel := self basicInputWidgetViewModel.

	aViewModel optionAt: #environment put: self environment.

	aSource := 'object := Object new.
object finalize.
object yourself'.

	aViewModel
		inputElement: [ :theViewModel | 
			| aForm aMagritteViewModel |
			aForm := GtPackageTagForm new.
			aForm
				onAccept: [ :aFuture :aButton | 
					theViewModel
						refactoringWithConfirmation: [ | aRefactoring |
							aRefactoring := GtExtractExampleFromSnippetToClassRefactoring
									extract: (1 to: aSource size)
									from: aSource
									into: ('{1}Examples' format: {self rootClass name})
									category: aForm packageAndTagName category asSymbol.
							aRefactoring
								setOption: #selfArgumentName toUse: [ :ref | 'myObject' ];
								setOption: #selectVariableToMoveTo
									toUse: [ :ref :cls :sel | '{1}Examples' format: {self rootClass name} ];
								setOption: #variableTypesForReceiver
									toUse: [ :ref :block | 
										{self rootClass.
											self leafClass} ];
								setOption: #variableTypes
									toUse: [ :ref :types :selected | 
										{self rootClass.
											self leafClass} ];
								setOption: #useExistingMethod toUse: [ :ref1 :sel1 | false ];
								setOption: #extractAssignment toUse: [ :ref1 :varName1 | true ].
							aRefactoring ].
					theViewModel inputReady ].
			aMagritteViewModel := aForm asGtMagritteViewModel.
			aMagritteViewModel focusFirstInputField.
			theViewModel optionAt: #packageTagForm put: aForm.
			theViewModel optionAt: #magritteViewModel put: aMagritteViewModel.
			aMagritteViewModel asElement ].

	self assert: (aViewModel inputElement isKindOf: BlElement).
	self
		assert: aViewModel executedRefactorings state
		equals: GtExecutedRefactoringsState disabled.

	^ aViewModel
]

{ #category : #'examples - just preview element' }
GtRefactoringsExamples >> justPreviewElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicJustPreviewElement.
	aViewModel := self inputViewModel.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #preview) visibility
		equals: BlVisibility gone.
	
	^ anElement
]

{ #category : #'examples - just preview element' }
GtRefactoringsExamples >> justPreviewElementEmptyComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicJustPreviewElement.
	aViewModel := self inputViewModelEmptyComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #preview) visibility
		equals: BlVisibility gone.
	
	^ anElement
]

{ #category : #'examples - just preview element' }
GtRefactoringsExamples >> justPreviewElementEmptyComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self justPreviewElementEmptyComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	self
		assert: (anElement query / #preview) anyOne visibility
		equals: BlVisibility gone.
	self assert: anElement height equals: 0.
	self assert: anElement width equals: 0.

	self
		assert: (anElement query // GtUserActivatableChangeWithExpanderElement) isEmpty.

	^ aScripter
]

{ #category : #'examples - just preview element' }
GtRefactoringsExamples >> justPreviewElementFaultyComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicJustPreviewElement.
	aViewModel := self inputViewModelFaultyComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #preview) visibility
		equals: BlVisibility gone.
	
	^ anElement
]

{ #category : #'examples - just preview element' }
GtRefactoringsExamples >> justPreviewElementFaultyComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self justPreviewElementFaultyComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	self
		assert: (anElement query / #preview) anyOne visibility
		equals: BlVisibility gone.
	self assert: anElement height equals: 0.
	self assert: anElement width equals: 0.

	self
		assert: (anElement query // GtUserActivatableChangeWithExpanderElement) isEmpty.

	^ aScripter
]

{ #category : #'examples - just preview element' }
GtRefactoringsExamples >> justPreviewElementScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements anAnnouncement |
	anElement := self justPreviewElement.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 1.
	anAnnouncement := allAnnouncements anyOne.
	self
		assert: anAnnouncement class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.

	self
		assert: (anElement query / #preview) anyOne visibility
		equals: BlVisibility gone.

	aScripter do
		label: 'Set refactorings with superclass name';
		block: [ aViewModel refactoringsForInput: self superclassFromRootClassName ];
		play.

	self assert: allAnnouncements size equals: 4.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self
		assert: allAnnouncements third class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.
	self
		assert: allAnnouncements fourth class
		equals: GtRefactoringsViewModelExecutedRefactoringsPreviewed.

	self
		assert: (anElement query / #preview) anyOne visibility
		equals: BlVisibility visible.

	self assert: anElement height > 15.
	self assert: anElement width > 200.

	self
		assert: (anElement query // GtUserActivatableChangeWithExpanderElement) anyOne
				isVisibleInSpace.

	^ aScripter
]

{ #category : #'examples - environment' }
GtRefactoringsExamples >> leafClass [
	<gtExample>
	leafClass ifNil: [ leafClass := self environment anyDummyLeafClass realClass ].
	
	self assert: leafClass subclasses size equals: 0.
	
	^ leafClass
]

{ #category : #'examples - environment' }
GtRefactoringsExamples >> leafClassInstVarName [
	<gtExample>
	leafClassInstVarName ifNil: [ 
		leafClassInstVarName := self leafClass instVarNames anyOne.
		self assert: leafClassInstVarName isNotNil.
		self assert: leafClassInstVarName isNotEmpty ].
	
	^ leafClassInstVarName
]

{ #category : #'examples - messages element' }
GtRefactoringsExamples >> messagesElementExceptionComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicMessagesElement.
	aViewModel := self inputViewModelExceptionComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement query / #refactoringMessagesContainer) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query / #refactoringMessagesContainer) anyOne childrenCount
		equals: 0.

	^ anElement
]

{ #category : #'examples - messages element' }
GtRefactoringsExamples >> messagesElementFaultyComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicMessagesElement.
	aViewModel := self inputViewModelFaultyComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement query / #refactoringMessagesContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query / #refactoringMessagesContainer) anyOne childrenCount
		equals: 1.

	^ anElement
]

{ #category : #'examples - environment' }
GtRefactoringsExamples >> nonRootClass [
	<gtExample>
	nonRootClass ifNil: [ 
		nonRootClass := self environment anyDummyPackage dummyClasses
			detect: [ :eachDummyClass | eachDummyClass realClass ~= self rootClass ]
			ifFound: #realClass 
			ifNone: [ NotFound signalFor: 'A non root class' in: self environment anyDummyPackage ] ].
	
	^ nonRootClass
]

{ #category : #'examples - preview with confirmation element' }
GtRefactoringsExamples >> previewWithConfirmationElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicPreviewWithConfirmationElement.
	aViewModel := self confirmationViewModel.
	anElement refactoringsViewModel: aViewModel.

	self assert: (anElement query // #progress) isEmpty.

	^ anElement
]

{ #category : #'examples - preview with confirmation element' }
GtRefactoringsExamples >> previewWithConfirmationElementScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self previewWithConfirmationElement.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	
	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements anyOne class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.

	aScripter refactorings
		assertPreviewButtonIsVisible;
		assertPreviewButtonIsEnabled;
		assertAcceptButtonIsNotVisible;
		assertChangesPreviewIsNotVisible;
		play.

	^ aScripter
]

{ #category : #'examples - preview with confirmation element' }
GtRefactoringsExamples >> previewWithConfirmationElementScripter_preview [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self previewWithConfirmationElementScripter.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter refactorings
		clickPreviewButton;
		assertChangesPreviewIsVisible;
		assertPreviewButtonIsNotVisible;
		assertPreviewButtonIsDisabled;
		assertAcceptButtonIsVisible;
		assertAcceptButtonIsEnabled;
		assertAcceptButtonHasFocus;
		play.

	self assert: allAnnouncements size equals: 4.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelSubmitExecutedRefactoringsRequested.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self
		assert: allAnnouncements third class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.
	self
		assert: allAnnouncements fourth class
		equals: GtRefactoringsViewModelExecutedRefactoringsPreviewed.


	^ aScripter
]

{ #category : #'examples - preview with confirmation element' }
GtRefactoringsExamples >> previewWithConfirmationElementScripter_preview_apply [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self previewWithConfirmationElementScripter_preview.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.


	aScripter refactorings
		assertFinishedLabelIsNotVisible;
		assertAcceptButtonHasFocus;
		pressReturnToApplyChanges;
		assertPreviewButtonIsNotVisible;
		assertPreviewButtonIsDisabled;
		assertAcceptButtonIsVisible;
		assertAcceptButtonIsDisabled;
		assertChangesPreviewIsVisible;
		assertFinishedLabelIsVisible;
		play.

	self assert: allAnnouncements size equals: 5.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelApplyChangesRequested.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelExecutedRefactoringsAboutToApply.
	self
		assert: allAnnouncements third class
		equals: GtRefactoringsViewModelExecutedRefactoringsProgressChanged.
	self
		assert: allAnnouncements fourth class
		equals: GtRefactoringsViewModelExecutedRefactoringsProgressChanged.
	self
		assert: allAnnouncements fifth class
		equals: GtRefactoringsViewModelExecutedRefactoringsApplied.

	^ aScripter
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicPreviewWithInputElement.
	aViewModel := self inputViewModel.
	anElement refactoringsViewModel: aViewModel.

	^ anElement
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementExceptionComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicPreviewWithInputElement.
	aViewModel := self inputViewModelExceptionComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	^ anElement
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementFaultyComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicPreviewWithInputElement.
	aViewModel := self inputViewModelFaultyComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement query // #refactoringMessagesContainer) anyOne visibility
		equals: BlVisibility visible.

	self
		assert: (anElement query // #refactoringMessagesContainer) anyOne childrenCount
		equals: 1.

	^ anElement
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementFaultyComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self previewWithInputElementFaultyComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	self
		assert: (anElement query // #refactoringMessagesContainer) anyOne visibility
		equals: BlVisibility visible.

	self
		assert: (anElement query // #refactoringMessagesContainer) anyOne childrenCount
		equals: 1.

	self
		assert: ((anElement query // #refactoringMessagesContainer) anyOne childAt: 1) height
				> 5.

	self
		assert: ((anElement query // #refactoringMessagesContainer) anyOne childAt: 1) width
				> 5.

	^ aScripter
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self previewWithInputElement.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 1.
	self assert: allAnnouncements anyOne class equals: GtRefactoringsViewModelExecutedRefactoringsComputed.
	
	^ aScripter
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementScripter_typeSuperclassName [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self previewWithInputElementScripter.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter refactorings
		inputEditorDo: [ :anEditorStep | 
			anEditorStep
				click;
				assertHasFocus;
				selectAll;
				typeText: self rootClass name;
				typeText: self extraLongClassName;
				assertTextEqualsTo: ('{1}{2}'
						format: {self rootClass name.
								self extraLongClassName});
				assertHasFocus ];
		assertToolbarIsVisible;
		assertPreviewButtonIsVisible;
		assertPreviewButtonIsEnabled;
		play.

	self assert: allAnnouncements size equals: 0.

	^ aScripter
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementScripter_typeSuperclassName_preview [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self previewWithInputElementScripter_typeSuperclassName.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter refactorings
		clickPreviewButton;
		assertToolbarIsVisible;
		assertChangesPreviewIsVisible;
		assertAcceptButtonHasFocus;
		play.
		
	self assert: allAnnouncements size equals: 4.
	self assert: allAnnouncements first class equals: GtRefactoringsViewModelSubmitExecutedRefactoringsRequested.
	self assert: allAnnouncements second class equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self assert: allAnnouncements third class equals: GtRefactoringsViewModelExecutedRefactoringsComputed.
	self assert: allAnnouncements fourth class equals: GtRefactoringsViewModelExecutedRefactoringsPreviewed.

	^ aScripter
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementScripter_typeSuperclassName_preview_editInput [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self previewWithInputElementScripter_typeSuperclassName_preview.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter refactorings
		inputEditorDo: [ :anEditorStep | 
			anEditorStep
				click;
				assertHasFocus;
				moveToEnd;
				typeText: '5';
				typeText: '6';
				assertTextEqualsTo: ('{1}{2}{3}'
						format: {self rootClass name.
								self extraLongClassName.
								56});
				assertHasFocus ];
		assertToolbarIsVisible;
		assertPreviewButtonIsVisible;
		assertPreviewButtonIsEnabled;
		assertChangesPreviewIsNotVisible;
		play.

	self assert: allAnnouncements size equals: 2.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.

	^ aScripter
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementScripter_typeSuperclassName_preview_editInput_preview [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self previewWithInputElementScripter_typeSuperclassName_preview_editInput.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter refactorings
		clickPreviewButton;
		assertToolbarIsVisible;
		assertChangesPreviewIsVisible;
		assertPreviewButtonIsNotVisible;
		assertPreviewButtonIsDisabled;
		assertAcceptButtonIsEnabled;
		assertAcceptButtonIsVisible;
		assertAcceptButtonHasFocus;
		play.
	
	self assert: allAnnouncements size equals: 4.
	self assert: allAnnouncements first class equals: GtRefactoringsViewModelSubmitExecutedRefactoringsRequested.
	self assert: allAnnouncements second class equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self assert: allAnnouncements third class equals: GtRefactoringsViewModelExecutedRefactoringsComputed.
	self assert: allAnnouncements fourth class equals: GtRefactoringsViewModelExecutedRefactoringsPreviewed.

	^ aScripter
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementSomeComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicPreviewWithInputElement.
	aViewModel := self inputViewModelSomeComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	^ anElement
]

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> previewWithInputElementSomeComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self previewWithInputElementSomeComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.
	
	^ aScripter
]

{ #category : #'examples - preview with input widget element' }
GtRefactoringsExamples >> previewWithInputWidgetElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicPreviewWithInputWidgetElement.
	aViewModel := self inputWidgetViewModel.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: aViewModel executedRefactorings state
		equals: GtExecutedRefactoringsState disabled.

	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility gone.

	^ anElement
]

{ #category : #'examples - preview with input widget element' }
GtRefactoringsExamples >> previewWithInputWidgetElementScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self previewWithInputWidgetElement.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	
	self assert: allAnnouncements size equals: 0.

	aScripter refactorings
		assertRefactoringInputWidgetExists;
		assertPreviewButtonIsNotVisible;
		assertPreviewButtonIsDisabled;
		assertAcceptButtonIsNotVisible;
		assertChangesPreviewIsNotVisible;
		play.

	^ aScripter
]

{ #category : #'examples - environment' }
GtRefactoringsExamples >> rootClass [
	<gtExample>
	rootClass ifNil: [ rootClass := self environment anyDummyRootClass realClass ].
	
	self assert: rootClass subclasses size > 0.
	
	^ rootClass
]

{ #category : #'examples - environment' }
GtRefactoringsExamples >> superclassFromRootClassName [
	<gtExample>
	^ '{1}Superclass' format: {self rootClass name}
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicToolbarElement.
	aViewModel := self inputViewModel.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ anElement
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementEmptyComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicToolbarElement.
	aViewModel := self inputViewModelEmptyComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.
	
	^ anElement
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementEmptyComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self toolbarElementEmptyComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementExceptionComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicToolbarElement.
	aViewModel := self inputViewModelExceptionComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ anElement
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementExceptionComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self toolbarElementExceptionComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementExceptionComputedRefactoringsScripter_compute [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self toolbarElementExceptionComputedRefactoringsScripter.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter do
		label: 'Simulate a refactoring computation';
		block: [ [ aViewModel computeRefactoringsFrom: self ]
				onErrorDo: [ :anException | 
					aViewModel
						notifyComputingRefactoringsFailed: (GtSystemUtility freeze: anException) ] ];
		play.

	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements anyOne class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputationFailed.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // #refactoringException) anyOne children size
		equals: 1.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementFaultyComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicToolbarElement.
	aViewModel := self inputViewModelFaultyComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ anElement
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementFaultyComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self toolbarElementFaultyComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self toolbarElement.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementWithSomeComputedRefactorings [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicToolbarElement.
	aViewModel := self inputViewModelSomeComputedRefactorings.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ anElement
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementWithSomeComputedRefactoringsScripter [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	anElement := self toolbarElementWithSomeComputedRefactorings.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter := BlScripter new element: anElement.
	aScripter userData at: #refactoringsAnnouncements put: allAnnouncements.
	self assert: allAnnouncements size equals: 0.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementWithSomeComputedRefactoringsScripter_previewed [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self toolbarElementWithSomeComputedRefactoringsScripter.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter do
		label: 'Simulate a previewed changes';
		block: [ aViewModel previewedRefactorings: aViewModel executedRefactorings ];
		play.
	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements anyOne class
		equals: GtRefactoringsViewModelExecutedRefactoringsPreviewed.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isEnabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility gone.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isDisabled.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementWithSomeComputedRefactoringsScripter_previewed_requestRefactorings [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self toolbarElementWithSomeComputedRefactoringsScripter_previewed.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter click
		label: 'Request accept changes';
		// GtRefactoringsPreviewAcceptId;
		play.

	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelApplyChangesRequested.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isEnabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility gone.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isDisabled.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementWithSomeComputedRefactoringsScripter_requestPreview [
	<gtExample>
	| anElement aViewModel aScripter allAnnouncements |
	aScripter := self toolbarElementWithSomeComputedRefactoringsScripter.
	anElement := aScripter element.
	aViewModel := anElement refactoringsViewModel.
	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: Announcement
		send: #add:
		to: allAnnouncements.

	aScripter click
		label: 'Request preview changes';
		// #refactoringPreviewButton;
		play.

	self assert: allAnnouncements size equals: 1.
	self
		assert: allAnnouncements first class
		equals: GtRefactoringsViewModelSubmitExecutedRefactoringsRequested.

	self
		assert: (anElement query // #refactoringToolbarContainer) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #refactoringProgress) isEmpty
		description: [ 'Progress element must not be hidden' ].
	self
		assert: (anElement query // #refactoringException) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringFinished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #refactoringPreviewButton) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // #refactoringPreviewButton) anyOne isEnabled.

	^ aScripter
]
