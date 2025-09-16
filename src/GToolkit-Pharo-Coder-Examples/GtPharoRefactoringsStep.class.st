Class {
	#name : #GtPharoRefactoringsStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactorings'
}

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertAcceptButtonHasFocus [
	self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert apply changes button has focus';
		hasFocus;
		// GtRefactoringsPreviewAcceptId
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertChangesPreviewIsNotVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert changes preview is visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility gone;
		// #preview
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertChangesPreviewIsVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert changes preview is visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility visible;
		// #preview
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertFormIsClosed [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert refactoring form is closed';
		notExists
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertFormIsOpened [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert refactoring form is closed';
		exists
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertInputToolbarIsNotVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert input toolbar is not visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility gone;
		// #refactoringInputToolbar
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertInputToolbarIsVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert input toolbar is visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility visible;
		// #refactoringInputToolbar
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertPreviewButtonIsEnabled [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert preview button is visible';
		satisfies: [ :anElement | anElement isEnabled ]
			description: [ 'Preview button msut be enabled' ];
		// #refactoringPreviewButton
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertPreviewButtonIsVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert preview button is visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility visible;
		// #refactoringPreviewButton
]

{ #category : #'steps - interactions' }
GtPharoRefactoringsStep >> clickPreviewButton [
	^ self click
		referenceSender;
		label: 'Click preview button';
		// #refactoringPreviewButton
]

{ #category : #'steps - interactions' }
GtPharoRefactoringsStep >> clickPreviewButtonIn: anElementId [
	^ self click
		referenceSender;
		label: ('Click preview button in {1}' format: {anElementId});
		// anElementId;
		// #refactoringPreviewButton
]

{ #category : #'steps - substeps' }
GtPharoRefactoringsStep >> inputEditorDo: aBlock [
	| aStep |
	aStep := self editor
			referenceSender;
			onParentStepTarget: self;
			label: 'Refactorings input editor';
			// #refactoringEditor.

	aBlock value: aStep.

	^ aStep
]

{ #category : #'steps - interactions' }
GtPharoRefactoringsStep >> pressReturnToApplyChanges [
	^ self
		substeps2: 'Press return to apply refactoring changes'
		do: [ :aStep | 
			aStep assert
				referenceSender;
				onParentStepTarget: aStep;
				label: 'Assert apply changes button has focus';
				hasFocus;
				// GtRefactoringsPreviewAcceptId.

			aStep keyPress
				label: 'Press return';
				key: BlKeyboardKey return ]
]
