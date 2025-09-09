Class {
	#name : #GtRefactoringsInputElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithRefactoringsViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithRefactoringsViewModel classTrait',
	#instVars : [
		'inputEditorElement',
		'previewButtonElement',
		'inputLabelElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #initialization }
GtRefactoringsInputElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #'focus requesting' }
GtRefactoringsInputElement >> focusTarget [
	^ inputEditorElement
]

{ #category : #initialization }
GtRefactoringsInputElement >> initialize [
	| inputContainer |
	super initialize.

	self initializeInputLabelElement.
	self initializeInputEditorElement.
	self initializePreviewButton.

	inputContainer := BrHorizontalPane new
			alignTopCenter;
			hMatchParent;
			vFitContent;
			addChild: inputLabelElement;
			addChild: inputEditorElement as: #refactoringEditor;
			addAptitude: (BrLayoutResizerAptitude new
					hMatchParentToMatchParent: inputEditorElement;
					hExactToMatchParent: inputEditorElement;
					hFitContentToFitContent: inputEditorElement;
					hFitContentLimitedToFitContentLimited: inputEditorElement).

	self addChild: inputContainer as: #refactoringInputLine.
	self addChild: previewButtonElement as: #refactoringPreviewButton.

	self addAptitude: (BrLayoutResizerAptitude new hInherit: inputContainer).

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializeInputEditorElement [
	inputEditorElement := BrEditor new
			beFocusable;
			hMatchParent;
			vFitContent;
			aptitude: BrGlamorousCodeEditorAptitude new;
			text: '';
			beMode: BrTextEditorEditableSingleLineMode new;
			inputFilter: BrTextEditorNoLineBreakInputFilter new;
			addShortcut: (BlShortcutWithAction new
					name: 'Accept new text';
					description: 'Accept new text and perform preview refactoring';
					combination: BlKeyCombination enter;
					action: [ :anEvent | self onAcceptInputTextShortcutEvent: anEvent ]);
			constraintsDo: [ :c | c padding: (BlInsets top: 0 right: 3 bottom: 0 left: 3) ].

	GtMagritteBuilderUtility styleEditorWidget: inputEditorElement
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializeInputLabelElement [
	inputLabelElement := BrLabel new
			fitContent;
			margin: (BlInsets right: 5);
			aptitude: (BrGlamorousLabelAptitude new foreground: self theme button disabledTextColor);
			text: 'Input:'
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializePreviewButton [
	previewButtonElement := BrButton new
			beFocusable;
			aptitude: BrGlamorousButtonWithIconAptitude new;
			id: GtRefactoringsPreviewAcceptId;
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			label: 'Preview changes';
			margin: (BlInsets
					top: 5
					left: 0
					bottom: 0
					right: 0);
			action: [ :aButtonElement :aButtonModel :anEvent | self onPreviewButtonClick ]
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onAcceptInputTextShortcutEvent: anEvent [
	anEvent consumed: true.
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	self previewRefactoring
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onPreviewButtonClick [
	self previewRefactoring
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInputElement >> onRefactoringsViewModelChanged [
	self updateElement
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> previewRefactoring [
	| aBlock anInput anEvent |
	aBlock := self refactoringsViewModel refactoringBlock.
	anInput := inputEditorElement text asString.
	anEvent := GtRefactoringsPreviewRefactoringsWish new
			refactoringsBlock: [ (aBlock value: anInput) ifNil: [ #() ] ifNotNil: [ :aValue | {aValue} ] ].
	self dispatchEvent: anEvent.

	anEvent isConsumed ifFalse: [ ^ self ].
	previewButtonElement visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateElement [
	inputLabelElement text: self refactoringsViewModel inputLabel.

	inputEditorElement inputFilter: self refactoringsViewModel inputFilter.
	inputEditorElement text: self refactoringsViewModel initialText.
	self refactoringsViewModel isEditorFocused
		ifTrue: [ inputEditorElement requestFocus ].

	self refactoringsViewModel isPreviewButtonFocused
		ifTrue: [ previewButtonElement requestFocus ]
]
