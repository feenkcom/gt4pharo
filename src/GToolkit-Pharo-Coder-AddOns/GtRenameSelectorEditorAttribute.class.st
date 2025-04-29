Class {
	#name : #GtRenameSelectorEditorAttribute,
	#superclass : #GtRenameEditorAttribute,
	#instVars : [
		'focusedIndex',
		'highlighted'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	super doAffect: aTBrTextEditorTextualPiece in: anEditorElement.
	renameEditor
		when: BlFocusInEvent do: [ :event | renameAction focusedIndex: focusedIndex ];
		whenKey: BlKeyCombination builder primary arrowUp build
			editorDo: [ :aShortcutEvent | 
				renameAction
					announce: (GtRenameSelectorMoved new
							keyword: focusedIndex;
							forward: false) ];
		whenKey: BlKeyCombination builder primary arrowDown build
			editorDo: [ :aShortcutEvent | 
				renameAction
					announce: (GtRenameSelectorMoved new
							keyword: focusedIndex;
							forward: true) ].
	^ renameEditor
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> focusedIndex [
	^ focusedIndex
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> focusedIndex: anInteger [
	focusedIndex := anInteger
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> highlight [
	^ highlighted
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> highlight: aBoolean [
	aBoolean = highlighted ifTrue: [ ^ self ].
	highlighted := aBoolean.
	renameEditor
		border: (BlBorder
				paint: (highlighted
						ifTrue: [ BrGlamorousColors textHighlightColor ]
						ifFalse: [ renameEditor isFocused
								ifTrue: [ BrGlamorousColors focusedEditorBorderColor ]
								ifFalse: [ BrGlamorousColors editorBorderColor ] ]))
]

{ #category : #'as yet unclassified' }
GtRenameSelectorEditorAttribute >> initialize [
	super initialize.
	highlighted := false
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> resetText: aString [
	self text: aString.
	renameEditor enqueueTask: (BlTaskAction new action: [ renameEditor text: aString ])
]

{ #category : #'as yet unclassified' }
GtRenameSelectorEditorAttribute >> selectAllOnCreate [
	^ super selectAllOnCreate and: [ self requestInitialFocus ]
]
