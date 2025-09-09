Class {
	#name : #GtRefactoringsInputElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'inputEditorElement',
		'previewButtonElement',
		'inputLabelElement',
		'titleElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #initialization }
GtRefactoringsInputElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #'api - hooks' }
GtRefactoringsInputElement >> disableEditing [
	"Ensure that it is not possible to edit or trigger a new editing"
	
	inputEditorElement beReadOnlyWithSelection.
	previewButtonElement disable
]

{ #category : #'api - hooks' }
GtRefactoringsInputElement >> enableEditing [
	"Ensure that it is possible to edit or trigger a new editing"
	
	inputEditorElement beMode: BrTextEditorEditableSingleLineMode new.
	previewButtonElement enable
]

{ #category : #'focus requesting' }
GtRefactoringsInputElement >> focusTarget [
	^ inputEditorElement
]

{ #category : #initialization }
GtRefactoringsInputElement >> initialize [
	| inputContainer |
	super initialize.

	self initializeTitleElement.
	self initializeInputLabelElement.
	self initializeInputEditorElement.
	self initializePreviewButton.

	inputContainer := BrHorizontalPane new
			alignTopCenter;
			hMatchParent;
			vFitContent;
			margin: (BlInsets top: 5);
			addChild: inputLabelElement;
			addChild: inputEditorElement as: #refactoringEditor;
			addAptitude: (BrLayoutResizerAptitude new
					hMatchParentToMatchParent: inputEditorElement;
					hExactToMatchParent: inputEditorElement;
					hFitContentToFitContent: inputEditorElement;
					hFitContentLimitedToFitContentLimited: inputEditorElement).

	self addChild: titleElement.
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
			aptitude: BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize;
			text: '';
			beMode: BrTextEditorEditableSingleLineMode new;
			inputFilter: BrTextEditorNoLineBreakInputFilter new;
			addShortcut: (BlShortcutWithAction new
					name: 'Accept new text';
					description: 'Accept new text and perform preview refactoring';
					combination: BlKeyCombination enter;
					action: [ :anEvent | self onAcceptInputTextShortcutEvent: anEvent ]);
			constraintsDo: [ :c | c padding: (BlInsets all: 5) ].

	inputEditorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onInputTextModifiedEvent: anEvent ].

	GtMagritteBuilderUtility styleEditorWidget: inputEditorElement
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializeInputLabelElement [
	inputLabelElement := BrLabel new
			fitContent;
			margin: (BlInsets top: 2 right: 5);
			aptitude: BrGlamorousLabelAptitude new glamorousFormLabelStyle;
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
			margin: (BlInsets top: 5);
			action: [ :aButtonElement :aButtonModel :anEvent | self onPreviewButtonClick ]
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializeTitleElement [
	titleElement := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: self theme button disabledTextColor);
			text: ''
]

{ #category : #'api - hooks' }
GtRefactoringsInputElement >> isEditingEnabled [
	^ (previewButtonElement states hasState: BlElementState disabled) not
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onAcceptInputTextShortcutEvent: anEvent [
	anEvent consumed: true.
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	self previewRefactoring
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onInputTextModifiedEvent: anEvent [
	| aWish |
	self isEditingEnabled ifFalse: [ ^ self ].
	aWish := GtRefactoringsPreviewRefactoringsWish new refactoringsBlock: [ #() ].

	self fireEvent: aWish.
	aWish isConsumed ifFalse: [ ^ self ].
	previewButtonElement visibility: BlVisibility visible
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
	self updateTitleElement.
	self updateInputLabelElement.
	self updateInputEditorElement.
	self updatePreviewButtonElement
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateInputEditorElement [
	inputEditorElement inputFilter: self refactoringsViewModel inputFilter.
	inputEditorElement text: self refactoringsViewModel initialText.
	self refactoringsViewModel isEditorFocused
		ifTrue: [ inputEditorElement requestFocus ]
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateInputLabelElement [
	inputLabelElement text: self refactoringsViewModel inputLabel
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updatePreviewButtonElement [
	self refactoringsViewModel isPreviewButtonFocused
		ifTrue: [ previewButtonElement requestFocus ]
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateTitleElement [
	| aFormatedText |
	aFormatedText := ''.
	self refactoringsViewModel refactoringTitleDo: [ :aText | 
		aFormatedText := aText asRopedText glamorousRegularFont.
		self refactoringsViewModel targetNameDo: [ :aPreview | 
		aFormatedText append: ((' ' , aPreview asString) asRopedText
			glamorousCodeFont;
			foreground: Color gray;
			glamorousCodeTinySize) ] ].
	
	titleElement text: aFormatedText
]
