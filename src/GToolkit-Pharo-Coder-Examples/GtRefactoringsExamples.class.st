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

{ #category : #'examples - elements' }
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

{ #category : #'examples - elements' }
GtRefactoringsExamples >> basicJustPreviewElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsJustPreviewElement new.

	self
		assert: (anElement query / #preview) anyOne visibility
		equals: BlVisibility gone.

	^ anElement
]

{ #category : #'examples - elements' }
GtRefactoringsExamples >> basicToolbarElement [
	<gtExample>
	| anElement |
	anElement := GtRefactoringsToolbarElement new.

	^ anElement
]

{ #category : #'examples - environment' }
GtRefactoringsExamples >> environment [
	<gtExample>
	environment
		ifNil: [ environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2 ].

	^ environment
]

{ #category : #'examples - elements' }
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

{ #category : #'examples - elements' }
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
GtRefactoringsExamples >> inputViewModelComputedRefactorings [
	<gtExample>
	| aViewModel aCollection |
	aViewModel := self inputViewModel.

	aCollection := aViewModel executedRefactorings executedRefactorings.
	self assert: aCollection size equals: 0.

	^ aViewModel
]

{ #category : #'examples - elements' }
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

{ #category : #'examples - elements' }
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
		
	self assert: allAnnouncements size equals: 3.
	self
		assert: allAnnouncements second class
		equals: GtRefactoringsViewModelExecutedRefactoringsChanged.
	self
		assert: allAnnouncements third class
		equals: GtRefactoringsViewModelExecutedRefactoringsComputed.

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
GtRefactoringsExamples >> rootClass [
	<gtExample>
	rootClass ifNil: [ rootClass := self environment anyDummyRootClass realClass ].
	
	self assert: rootClass subclasses size > 0.
	
	^ rootClass
]

{ #category : #'examples - elements' }
GtRefactoringsExamples >> toolbarElement [
	<gtExample>
	| anElement aViewModel |
	anElement := self basicToolbarElement.
	aViewModel := self inputViewModel.
	anElement refactoringsViewModel: aViewModel.

	^ anElement
]
