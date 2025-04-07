Class {
	#name : #GtRefactoringsWithInputPreviewElement,
	#superclass : #GtRefactoringsPreviewButton,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement class >> elementForRefactoring: refactoringBlock confirmationLabeled: aString from: anElement beforeApplyingDo: applyBlock [
	| refactoring refactoringButton edit acceptButton |
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
				refactoring := refactoringBlock value.
				refactoringButton refactorings: [ {refactoring} ] ].
	edit addChild: acceptButton.
	refactoringButton editorElement: edit.
	refactoringButton
		when: GtRefactoringsAboutToApplyEvent
		do: [ :event | applyBlock value ].
	^ refactoringButton buildPreviewForButton: anElement
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement class >> elementForRefactoring: refactoringBlock labeled: aString initialValue: initialValueString from: anElement beforeApplyingDo: applyBlock [
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
		focused: true;
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
			requestFocus;
			label: 'Save';
			margin: (BlInsets
					top: 0
					left: 10
					bottom: 10
					right: 0);
			action: [ label acceptEdition ].
	edit addChild: acceptButton.
	refactoringButton editorElement: edit.
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
