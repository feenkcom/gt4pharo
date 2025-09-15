"
I exemplify refactorings code, e.g., {{gtClass:GtRefactoringsBasicElement}} in isolation.
Refactorings in a context of pharo coder are available in {{gtClass:GtPharoCoderByScripterExamples}} 

"
Class {
	#name : #GtRefactoringsExamples,
	#superclass : #Object,
	#instVars : [
		'environment',
		'rootClass'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Refactorings'
}

{ #category : #'examples - input element' }
GtRefactoringsExamples >> basicInputElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsInputElement new.

	self
		assert: (anElement childWithId: #refactoringTitle) visibility
		equals: BlVisibility gone.

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

{ #category : #'examples - preview with input element' }
GtRefactoringsExamples >> basicPreviewWithInputElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsPreviewWithInputElement new.

	self
		assert: (anElement query / GtRefactoringsToolbarElement) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	
	^ anElement
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> basicToolbarElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsToolbarElement new.

	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.

	^ anElement
]

{ #category : #'examples - environment' }
GtRefactoringsExamples >> environment [
	<gtExample>
	environment
		ifNil: [ environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2 ].

	^ environment
]

{ #category : #'examples - input element' }
GtRefactoringsExamples >> inputElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicInputElement.
	aViewModel := self inputViewModel.
	anElement refactoringsViewModel: aViewModel.

	self
		assert: (anElement childWithId: #refactoringTitle) visibility
		equals: BlVisibility visible.

	^ anElement
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
		type: self rootClass name;
		type: 'Superclass';
		play.

	self assert: allAnnouncements size equals: 0.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

	aScripter editor
		assertHasFocus;
		pressReturn;
		play.

	self assert: allAnnouncements size equals: 1.
	self assert: aViewModel hasPreviewedExecutedRefactorings not.
	self assert: aViewModel canEditInput.

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

	aViewModel refactoringsForInput: ('{1}Superclass' format: {self rootClass name}).
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

	anotherClass := self environment anyDummyPackage dummyClasses
			detect: [ :eachDummyClass | eachDummyClass realClass ~= self rootClass ].

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

	aViewModel
		refactoringsForInput: ('{1}Superclass' format: {self rootClass name}).
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
		block: [ aViewModel
				refactoringsForInput: ('{1}Superclass' format: {self rootClass name}) ];
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

{ #category : #'examples - environment' }
GtRefactoringsExamples >> rootClass [
	<gtExample>
	rootClass ifNil: [ rootClass := self environment anyDummyRootClass realClass ].
	
	self assert: rootClass subclasses size > 0.
	
	^ rootClass
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicToolbarElement.
	aViewModel := self inputViewModel.
	anElement refactoringsViewModel: aViewModel.
	
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.

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
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.

	self
		assert: (anElement query / #container) anyOne visibility
		equals: BlVisibility gone.

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
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.
	
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
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.

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
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.
	
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
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.
	
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
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.

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
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isDisabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query / #container) anyOne visibility
		equals: BlVisibility gone.

	^ aScripter
]

{ #category : #'examples - toolbar element' }
GtRefactoringsExamples >> toolbarElementWithSomeComputedRefactoringsScripter_requestRefactorings [
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

	aScripter click
		label: 'Request accept changes';
		// GtRefactoringsPreviewAcceptId;
		play.

	self assert: allAnnouncements size equals: 2.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelApplyChangesRequested.

	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne visibility
		equals: BlVisibility visible.
	self
		assert: (anElement query // GtRefactoringsPreviewAcceptId) anyOne isEnabled.
	self
		assert: (anElement query // #progress) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #exception) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query // #finished) anyOne visibility
		equals: BlVisibility gone.
	self
		assert: (anElement query / #container) anyOne visibility
		equals: BlVisibility visible.

	^ aScripter
]
