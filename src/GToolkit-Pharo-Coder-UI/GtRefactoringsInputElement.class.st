Class {
	#name : #GtRefactoringsInputElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'inputEditorElement',
		'inputLabelElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsInputElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #'focus requesting' }
GtRefactoringsInputElement >> focusTarget [
	^ inputEditorElement
]

{ #category : #initialization }
GtRefactoringsInputElement >> initialize [
	super initialize.

	self initializeInputLabelElement.
	self initializeInputEditorElement.

	self
		addChild: inputLabelElement as: #refactoringInputLabel;
		addChild: inputEditorElement as: #refactoringEditor.

	self
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: inputEditorElement;
				hExactToMatchParent: inputEditorElement;
				hFitContentToFitContent: inputEditorElement;
				hFitContentLimitedToFitContentLimited: inputEditorElement).

	self fitContentLimited
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
					action: [ :anEvent | self onAcceptInputTextShortcutEvent: anEvent ]);
			withAsyncFutureDo: [ :anElementFuture | 
				anElementFuture
					executionConfiguration: GtRefactoringsConstants futureExecutionConfiguration;
					whenPending: [ :anElement | self onFuturePending ];
					whenError: [ :anElement :anError | self onFutureError: anError ];
					whenSuccess: [ :anElement :aResult | self onFutureSuccess: aResult ] ].

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

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onAcceptInputTextShortcutEvent: anEvent [
	anEvent consumed: true.
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	self previewRefactoring
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onFutureError: anError [
	| aCopyError |
	self hasRefactoringsViewModel ifFalse: [ ^ self ].

	aCopyError := GtSystemUtility freeze: anError.
	self refactoringsViewModel notifyComputingRefactoringsFailed: aCopyError
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onFuturePending [
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onFutureSuccess: aResult [
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onGtRefactoringsViewModelExecutedRefactoringsChanged: anAnnouncement [
	self refactoringsViewModel == anAnnouncement refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateEditability ]
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onGtRefactoringsViewModelExecutedRefactoringsStateAnnouncement: anAnnouncement [
	self refactoringsViewModel == anAnnouncement refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self updateEditability ]
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onGtRefactoringsViewModelSubmitExecutedRefactoringsRequested: anAnnouncement [
	self refactoringsViewModel == anAnnouncement refactoringsViewModel
		ifFalse: [ ^ self ].

	BlTaskAction enqueueElement: self action: [ self previewRefactoring ]
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> onInputTextModifiedEvent: anEvent [
	self hasRefactoringsViewModel ifFalse: [ ^ self ].
	self refactoringsViewModel canEditInput ifFalse: [ ^ self ].

	self refactoringsViewModel hasPreviewedExecutedRefactorings ifFalse: [ ^ self ].
	
	"Let's hide preview by adding an empty refactorings."
	self refactoringsViewModel refactorings: [ #() ].
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInputElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement
]

{ #category : #'private - event handling' }
GtRefactoringsInputElement >> previewRefactoring [
	| anInput |
	anInput := inputEditorElement text asString.
	inputEditorElement asyncFuture future: [ self refactoringsViewModel refactoringsForInput: anInput ] asAsyncFuture.
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInputElement >> subscribeToRefactoringsViewModel [
	super subscribeToRefactoringsViewModel.

	self refactoringsViewModel weak
		when: GtRefactoringsViewModelExecutedRefactoringsChanged
			send: #onGtRefactoringsViewModelExecutedRefactoringsChanged:
			to: self;
		when: GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement
			send: #onGtRefactoringsViewModelExecutedRefactoringsStateAnnouncement:
			to: self;
		when: GtRefactoringsViewModelSubmitExecutedRefactoringsRequested
			send: #onGtRefactoringsViewModelSubmitExecutedRefactoringsRequested:
			to: self
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsInputElement >> unsubscribeFromRefactoringsViewModel [
	super unsubscribeFromRefactoringsViewModel.

	self refactoringsViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsEditableInputEditor [
	inputEditorElement beMode: BrTextEditorEditableSingleLineMode new
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateAsReadOnlyInputEditor [
	inputEditorElement beReadOnlyWithSelection
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateEditability [
	GtRefactoringsInputElementUpdater new
		forRefactoringsElement: self;
		update
]

{ #category : #'private - updating' }
GtRefactoringsInputElement >> updateElement [
	self updateInputLabelElement.
	self updateInputEditorElement.
	self updateEditability.
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
