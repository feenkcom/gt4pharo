Class {
	#name : #GtRefactoringsInputElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'inputEditorElement',
		'previewButtonElement',
		'inputLabelElement',
		'titleElement',
		'exceptionElement',
		'toolbarContainer'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement: anAnnouncement [
	self refactoringsViewModel == anAnnouncement refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateEditability ]
]

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
	self initializeExceptionElement.

	inputContainer := BrHorizontalPane new
			alignTopCenter;
			fitContentLimited;
			addChild: inputLabelElement;
			addChild: inputEditorElement as: #refactoringEditor;
			addAptitude: (BrLayoutResizerAptitude new
					hMatchParentToMatchParent: inputEditorElement;
					hExactToMatchParent: inputEditorElement;
					hFitContentToFitContent: inputEditorElement;
					hFitContentLimitedToFitContentLimited: inputEditorElement).

	exceptionElement addAptitude: (BrLayoutResizerAptitude new
		hInherit: [ exceptionElement children ]).
					
	toolbarContainer := BrHorizontalPane new
			margin: (BlInsets top: 5);
			alignCenterLeft;
			fitContentLimited;
			addChild: previewButtonElement as: #refactoringPreviewButton;
			addChild: exceptionElement as: #refactoringException;
			addAptitude: (BrLayoutResizerAptitude new 
					hMatchParentToMatchParent: exceptionElement;
					hExactToMatchParent: exceptionElement;
					hFitContentToFitContent: exceptionElement;
					hFitContentLimitedToFitContentLimited: exceptionElement).

	self addChild: titleElement as: #refactoringTitle.
	self addChild: inputContainer as: #refactoringInputLine.
	self addChild: toolbarContainer as: #refactoringInputToolbar.

	self
		addAptitude: (BrLayoutResizerAptitude new
				matchParentToMatchParent: inputContainer;
				exactToMatchParent: inputContainer;
				fitContentToFitContent: inputContainer;
				fitContentLimitedToFitContentLimited: inputContainer;
				hInherit: toolbarContainer).

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializeExceptionElement [
	exceptionElement := BrFrame new
			visibility: BlVisibility gone;
			hFitContentLimited;
			vFitContent
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializeInputEditorElement [
	inputEditorElement := BrEditor new
			beFocusable;
			hMatchParent;
			vFitContent;
			padding: (BlInsets all: 5);
			aptitude: BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize;
			text: '';
			beMode: BrTextEditorEditableSingleLineMode new;
			inputFilter: BrTextEditorNoLineBreakInputFilter new;
			addShortcut: (BlShortcutWithAction new
					name: 'Accept new text';
					description: 'Accept new text and perform preview refactoring';
					combination: BlKeyCombination enter;
					action: [ :anEvent | self onAcceptInputTextShortcutEvent: anEvent ]).

	inputEditorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onInputTextModifiedEvent: anEvent ].

	GtMagritteBuilderUtility styleEditorWidget: inputEditorElement
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializeInputLabelElement [
	"The top padding is used to center the text with the input editor"

	inputLabelElement := BrLabel new
			fitContent;
			margin: (BlInsets top: 2 right: 5);
			aptitude: BrGlamorousLabelAptitude new glamorousFormLabelStyle;
			text: 'Input:'
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializePreviewButton [
	previewButtonElement := BrButton new
			fitContent;
			beFocusable;
			margin: (BlInsets right: 5);
			aptitude: BrGlamorousButtonWithIconAptitude new;
			id: GtRefactoringsPreviewAcceptId;
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			label: 'Preview changes';
			action: [ :aButtonElement :aButtonModel :anEvent | self onPreviewButtonClick ]
]

{ #category : #initialization }
GtRefactoringsInputElement >> initializeTitleElement [
	titleElement := BrLabel new
			visibility: BlVisibility gone;
			fitContent;
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
GtRefactoringsInputElement >> onGtRefactoringsViewModelExecutedRefactoringsChanged: anAnnouncement [
	self refactoringsViewModel == anAnnouncement refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateElement ]
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onInputTextModifiedEvent: anEvent [
	| aWish isPreviewed |
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	self isEditingEnabled ifFalse: [ ^ self ].
	self refactoringsViewModel canEditInput ifFalse: [ ^ self ].

	self refactoringsViewModel hasPreviewedExecutedRefactorings ifFalse: [ ^ self ].
	
	"Let's hide preview by adding an empty refactorings."
	isPreviewed := self refactoringsViewModel refactorings: [ #() ].

	self flag: 'This part will be removed'.
	aWish := GtRefactoringsPreviewRefactoringsWish new refactoringsBlock: [ #() ].
	self fireEvent: aWish.
	(aWish isConsumed or: [ isPreviewed ]) ifFalse: [ ^ self ].
	previewButtonElement visibility: BlVisibility visible
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onPreviewButtonClick [
	self previewRefactoring
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInputElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> previewRefactoring [
	| anInput aWish aRefactoringsBlock isPreviewed |
	anInput := inputEditorElement text asString.
	isPreviewed := self refactoringsViewModel refactoringsForInput: anInput.

	self flag: 'The rest of the code is going to be removed'.
	aWish := GtRefactoringsPreviewRefactoringsWish new
			refactoringsBlock: aRefactoringsBlock.
	self dispatchEvent: aWish.

	(aWish isConsumed or: [ isPreviewed ]) ifFalse: [ ^ self ].
	previewButtonElement visibility: BlVisibility gone
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInputElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.

	self refactoringsViewModel weak
		when: GtRefactoringsViewModelExecutedRefactoringsChanged
			send: #onGtRefactoringsViewModelExecutedRefactoringsChanged:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement
			send: #GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement:
			to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInputElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.

	self refactoringsViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsDisabledPreviewButton [
	previewButtonElement disable
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsDisplayedToolbarContainer [
	toolbarContainer visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsEditableInputEditor [
	inputEditorElement beMode: BrTextEditorEditableSingleLineMode new
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsEnabledPreviewButton [
	previewButtonElement enable
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsHiddenToolbarContainer [
	toolbarContainer visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsReadOnlyInputEditor [
	inputEditorElement beReadOnlyWithSelection
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsWithException: anException [
	exceptionElement
		visibility: BlVisibility visible;
		removeChildren;
		addChild: anException asDebuggableElement fitContentLimited
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsWithoutExceptions [
	exceptionElement
		visibility: BlVisibility gone;
		removeChildren
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateEditability [
	GtRefactoringsInputElementUpdater new
		forRefactoringsElement: self;
		update
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateElement [
	self updateTitleElement.
	self updateInputLabelElement.
	self updateInputEditorElement.
	self updateEditability.
	self updatePreviewButtonElement.
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateInputEditorElement [
	inputEditorElement inputFilter: self refactoringsViewModel inputFilter.
	inputEditorElement text: self refactoringsViewModel currentText.
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
	aFormatedText := nil.
	self refactoringsViewModel
		refactoringTitleDo: [ :aText | 
			aFormatedText := aText asRopedText glamorousRegularFont.
			self refactoringsViewModel
				targetNameDo: [ :aPreview | 
					aFormatedText
						append: ((' ' , aPreview asString) asRopedText
								glamorousCodeFont;
								foreground: Color gray;
								glamorousCodeTinySize) ] ].

	aFormatedText
		ifNil: [ titleElement
				visibility: BlVisibility gone;
				text: '' ]
		ifNotNil: [ titleElement
				text: aFormatedText;
				visibility: BlVisibility visible ]
]
