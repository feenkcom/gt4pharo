Class {
	#name : #GtPharoRenameVariableEditorElement,
	#superclass : #BlElement,
	#instVars : [
		'variableModel',
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameVariableEditorElement >> editorElement [
	^ editorElement
]

{ #category : #initialization }
GtPharoRenameVariableEditorElement >> fitContent [
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #accessing }
GtPharoRenameVariableEditorElement >> focusTarget [
	^ editorElement
]

{ #category : #initialization }
GtPharoRenameVariableEditorElement >> initialize [
	super initialize.

	self layout: BlFrameLayout new.
	self fitContent.
	self initializeEditorElement.
	self addChild: editorElement as: #editorElement
]

{ #category : #initialization }
GtPharoRenameVariableEditorElement >> initializeEditorElement [
	editorElement := BrEditableLabel new
			fitContent;
			aptitude: (BrGlamorousEditableLabelAptitude new
					defaultBackground: Color transparent;
					defaultBorder: (BlBorder paint: BrGlamorousColors editorBorderColor);
					minWidth: 5);
			padding: (BlInsets left: 2 right: 2).

	editorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onBrTextEditorModifiedEvent: anEvent ].
	editorElement
		whenKey: BlKeyCombination escape
			editorDo: [ :aShortcutEvent | self onEscapeShortcut: aShortcutEvent ];
		whenKey: BlKeyCombination enter
			editorDo: [ :aShortcutEvent | self onEnterShortcut: aShortcutEvent ].
	editorElement
		addAptitude: (BrLazyStyleCommonAptitude new
				focused: [ :aStyle | aStyle do: [ :aWidget | aWidget switchToEditor ] ];
				unfocused: [ :aStyle | aStyle do: [ :aWidget | aWidget switchToLabel ] ])
]

{ #category : #'event handling' }
GtPharoRenameVariableEditorElement >> onBrTextEditorModifiedEvent: anEvent [
	variableModel ifNil: [ ^ self ].
	variableModel updateCurrentName: anEvent text asString source: self
]

{ #category : #'event handling' }
GtPharoRenameVariableEditorElement >> onEnterShortcut: aShortcutEvent [
	aShortcutEvent consumed: true.
	variableModel requestRefactoringsPreviewSource: self
]

{ #category : #'event handling' }
GtPharoRenameVariableEditorElement >> onEscapeShortcut: aShortcutEvent [
	aShortcutEvent consumed: true.
	variableModel requestCancelSource: self
]

{ #category : #'event handling' }
GtPharoRenameVariableEditorElement >> onGtPharoRenameVariableNameChanged: anAnnouncement [
	anAnnouncement variableModel = variableModel ifFalse: [ ^ self ].
	anAnnouncement source == self ifTrue: [ ^ self ].
	editorElement text: anAnnouncement currentName
]

{ #category : #accessing }
GtPharoRenameVariableEditorElement >> variableModel [
	^ variableModel
]

{ #category : #accessing }
GtPharoRenameVariableEditorElement >> variableModel: aVariableModel [
	"The model is assigned only once."

	self assert: [ aVariableModel isNotNil ].
	self assert: [ variableModel isNil ].

	variableModel := aVariableModel.
	editorElement text: variableModel currentName.
	variableModel announcer weak
		when: GtPharoRenameVariableNameChanged
		send: #onGtPharoRenameVariableNameChanged:
		to: self
]
