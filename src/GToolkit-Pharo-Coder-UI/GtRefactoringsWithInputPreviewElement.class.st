Class {
	#name : #GtRefactoringsWithInputPreviewElement,
	#superclass : #GtRefactoringsPreviewButton,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement class >> elementForRefactoring: refactoringsBlock confirmationLabeled: aString from: anElement beforeApplyingDo: applyBlock [
	| refactorings refactoringButton edit acceptButton |
	refactoringButton := self new.
	refactoringButton cancelBlock: [  ].
	edit := BrHorizontalPane new.
	edit padding: (BlInsets all: 10).
	edit fitContent.
	edit
		addChild: (BrLabel new
				fitContent;
				aptitude: BrGlamorousLabelAptitude;
				text: aString).
	acceptButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude new;
			id: #'confirm-preview';
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			requestFocus;
			label: 'Save';
			margin: (BlInsets
					top: 0
					left: 10
					bottom: 0
					right: 0);
			action: [ acceptButton visibility: BlVisibility gone.
				refactorings := refactoringsBlock value.
				refactoringButton refactorings: [ refactorings asCollection ] ].
	edit addChild: acceptButton.
	refactoringButton editorElement: edit.
	refactoringButton
		when: GtRefactoringsAboutToApplyEvent
		do: [ :event | applyBlock value ].
	^ refactoringButton buildPreviewForButton: anElement
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement class >> elementForRefactoring: refactoringBlock labeled: aString initialValue: initialValueString from: anElement beforeApplyingDo: applyBlock [
	^ self
		elementForRefactoring: refactoringBlock
		labeled: aString
		initialValue: initialValueString
		from: anElement
		beforeApplyingDo: applyBlock
		focusedEditor: true
		focusedAcceptButton: false
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement class >> elementForRefactoring: refactoringBlock labeled: aString initialValue: initialValueString from: anElement beforeApplyingDo: applyBlock focusedEditor: isEditorFocusedByDefault focusedAcceptButton: isAcceptButtonFocused [
	| refactoring label refactoringButton edit acceptButton |
	refactoringButton := self new.
	refactoringButton cancelBlock: [  ].
	edit := BrHorizontalPane new.
	edit padding: (BlInsets all: 10).
	edit fitContent.
	edit
		addChild: (BrLabel new
				fitContent;
				aptitude: BrGlamorousLabelAptitude;
				text: aString).
	label := BrEditableLabel new.
	label
		aptitude: (BrGlamorousEditableLabelAptitude new
				fontSize: 11.9;
				background: Color transparent);
		text: initialValueString;
		focused: isEditorFocusedByDefault;
		when: BrEditorAcceptWish
			do: [ :aWish | 
				acceptButton removeFromParent.
				edit
					padding: (BlInsets
							top: 10
							bottom: 0
							left: 10
							right: 10).
				refactoring := refactoringBlock value: aWish text asString.
				refactoringButton refactorings: [ {refactoring} ].
				label switchToLabel ];
		switchToEditor.
	label viewModel
		when: BrEditorModeChanged
		do: [ :event | 
			event mode isEditable
				ifTrue: [ edit padding: (BlInsets all: 10).
					refactoringButton refactorings: [ #() ].
					edit addChild: acceptButton ] ].
	edit addChild: label as: #refactoringEditor.
	
	acceptButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude new;
			id: GtRefactoringsPreviewAcceptId;
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			label: 'Save';
			margin: (BlInsets
					top: 0
					left: 10
					bottom: 10
					right: 0);
			action: [ label acceptEdition ].
			
	isAcceptButtonFocused ifTrue: [
		acceptButton requestFocus ].
			
	edit addChild: acceptButton.
	refactoringButton editorElement: edit.
	refactoringButton
		when: GtRefactoringsAboutToApplyEvent
		do: [ :event | applyBlock value ].
	^ refactoringButton buildPreviewForButton: anElement
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement class >> elementForRefactoringInputElement: inputElement from: anElement beforeApplyingDo: applyBlock [
	| refactoringButton |
	refactoringButton := self new.
	refactoringButton cancelBlock: [ ].
	refactoringButton editorElement: inputElement.
	inputElement
		when: GtRefactoringsPreviewRefactoringsWish
		do: [ :event | 
			event consumed: true.
			refactoringButton refactorings: event refactoringsBlock ].
	refactoringButton
		when: GtRefactoringsAboutToApplyEvent
		do: [ :event | applyBlock value ].
	^ refactoringButton buildPreviewForButton: anElement
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> buildPreviewForButton: previewButton [
	| pane |
	pane := BrVerticalPane new.
	pane fitContentLimited.
	editorElement
		ifNotNil: [ editorElement removeFromParent.
			pane addChild: editorElement ].
	self buildRefactoringsFor: previewButton in: pane.
	^ pane
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> buildRefactoringsFor: previewButton in: pane [
	self refactorings notEmpty
		ifTrue: [ pane addChild: (self buildAsyncPreviewForButton: previewButton) as: #preview ]
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> editorElement: anObject [
	editorElement := anObject
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> refactorings: aBlock [
	| pane |
	super refactorings: aBlock.
	executedRefactorings := nil.
	editorElement ifNil: [ ^ self ].
	pane := editorElement parent.
	pane ifNil: [ ^ self ].
	pane removeChildNamed: #preview.
	self buildRefactoringsFor: (self childNamed: #previewCheckButton) in: pane
]

{ #category : #testing }
GtRefactoringsWithInputPreviewElement >> shouldFocusAcceptButton [
	^ false
]
