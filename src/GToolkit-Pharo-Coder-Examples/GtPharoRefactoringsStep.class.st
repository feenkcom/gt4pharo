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
GtPharoRefactoringsStep >> assertAcceptButtonIsDisabled [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert accept button is disabled';
		satisfies: [ :anElement | anElement isDisabled ]
			description: [ 'Accept button must be disabled' ];
		// GtRefactoringsPreviewAcceptId
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertAcceptButtonIsEnabled [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert accept button is enabled';
		satisfies: [ :anElement | anElement isEnabled ]
			description: [ 'Accept button must be enabled' ];
		// GtRefactoringsPreviewAcceptId
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertAcceptButtonIsNotVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert accept button is not visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility gone;
		// GtRefactoringsPreviewAcceptId
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertAcceptButtonIsVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert accept button is visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility visible;
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
GtPharoRefactoringsStep >> assertErrorMessagesAreNotVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert error messages are visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility gone;
		// #refactoringMessagesContainer
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertErrorMessagesAreVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert error messages are visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility visible;
		// #refactoringMessagesContainer
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertFinishedLabelIsNotVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert finished label is not visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility gone;
		// #refactoringFinished
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertFinishedLabelIsVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert finished label is visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility visible;
		// #refactoringFinished
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
GtPharoRefactoringsStep >> assertInlinedRefactoringButtonWithDropdownPreviewExists [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert inlined refactoring button with dropdown preview exists';
		exists;
		// GtRefactoringsInDropdownPreviewElement
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertInlinedRefactoringButtonWithDropdownPreviewNotExists [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert inlined refactoring button with dropdown preview does not exists';
		notExists;
		// GtRefactoringsInDropdownPreviewElement
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertPreviewButtonIsDisabled [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert preview button is disabled';
		satisfies: [ :anElement | anElement isDisabled ]
			description: [ 'Preview button must be disabled' ];
		// #refactoringPreviewButton
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertPreviewButtonIsEnabled [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert preview button is enabled';
		satisfies: [ :anElement | anElement isEnabled ]
			description: [ 'Preview button must be enabled' ];
		// #refactoringPreviewButton
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertPreviewButtonIsNotVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert preview button is not visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility gone;
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

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertRefactoringInputWidgetExists [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert input widget exists';
		satisfies: [ :anElement | anElement hasChildren ]
			description: [ 'Input widget is missing' ];
		// #refactoringInputWidgetContainer
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertRefactoringInputWidgetNotExists [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert input widget does not exist';
		satisfies: [ :anElement | anElement hasChildren not ]
			description: [ 'Input widget must not exist' ];
		// #refactoringInputWidgetContainer
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertToolbarIsNotVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert toolbar is not visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility gone;
		// #refactoringToolbarContainer
]

{ #category : #'steps - checks' }
GtPharoRefactoringsStep >> assertToolbarIsVisible [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Assert toolbar is visible';
		value: [ :anElement | anElement visibility ] equals: BlVisibility visible;
		// #refactoringToolbarContainer
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

{ #category : #'steps - substeps' }
GtPharoRefactoringsStep >> inputEditorExists [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: 'Refactorings input editor exists';
		// #refactoringEditor;
		exists
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
