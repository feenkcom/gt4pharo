Class {
	#name : #GtPharoRenameSelectorPartEditorAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'selectorModel',
		'selectorPartModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	"GtRenameSelectorEditorAttribute"

	| renameEditor |
	renameEditor := GtRenameEditor new
			fitContent;
			aptitude: (BrGlamorousEditableLabelAptitude new
					defaultBackground: Color transparent;
					defaultBorder: (BlBorder paint: BrGlamorousColors editorBorderColor);
					minWidth: 0);
			padding: (BlInsets left: 2 right: 2);
			margin: (BlInsets
					top: 0
					left: -2
					bottom: 0
					right: -2);
			text: selectorPartModel currentName.


	selectorPartModel originalIndex = 1
		ifTrue: [ renameEditor
				switchToEditor;
				requestFocus ]
		ifFalse: [ renameEditor switchToLabel ].

	selectorPartModel styler ifNotNil: [ :aStyler | renameEditor styler: aStyler ].

	renameEditor
		whenKey: BlKeyCombination escape
			editorDo: [ :aShortcutEvent | self onEscapeShortcut: aShortcutEvent editorElement: anEditorElement ];
		whenKey: BlKeyCombination tab
			editorDo: [ :aShortcutEvent | self onTabShortcut: aShortcutEvent editorElement: anEditorElement ];
		whenKey: BlKeyCombination builder shift tab build
			editorDo: [ :aShortcutEvent | self onShiftTabShortcut: aShortcutEvent editorElement: anEditorElement ];
		whenKey: BlKeyCombination enter
			editorDo: [ :aShortcutEvent | self onEnterShortcut: aShortcutEvent editorElement: anEditorElement ].

	GtPharoRenameSelectorPartEditorAnnouncementHandler new
		editor: renameEditor;
		selectorPartModel: selectorPartModel;
		install.

	^ renameEditor
]

{ #category : #printing }
GtPharoRenameSelectorPartEditorAttribute >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Selector part: ';
		nextPutAll: (self selectorPartModel ifNotNil: #currentName) asString
]

{ #category : #initialization }
GtPharoRenameSelectorPartEditorAttribute >> initialize [
	super initialize.

	self beReplace.
	self beNotOverwritableByStyler
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> onEnterShortcut: aShortcutEvent editorElement: anEditorElement [ 
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> onEscapeShortcut: aShortcutEvent editorElement: anEditorElement [ 
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> onShiftTabShortcut: aShortcutEvent editorElement: anEditorElement [
	selectorModel focusPreviousSelectorPart: selectorPartModel originalIndex
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> onTabShortcut: aShortcutEvent editorElement: anEditorElement [
	selectorModel focusNextSelectorPart: selectorPartModel originalIndex
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorModel: anObject [
	selectorModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorPartModel [
	^ selectorPartModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorPartModel: anObject [
	selectorPartModel := anObject
]
