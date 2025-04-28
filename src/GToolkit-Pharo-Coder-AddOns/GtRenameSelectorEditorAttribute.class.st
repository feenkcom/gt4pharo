Class {
	#name : #GtRenameSelectorEditorAttribute,
	#superclass : #GtRenameEditorAttribute,
	#instVars : [
		'focusedIndex',
		'editor'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	editor := super doAffect: aTBrTextEditorTextualPiece in: anEditorElement.
	editor
		when: BlFocusInEvent
		do: [ :event | renameAction focusedIndex: focusedIndex ].
	^ editor
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> focusedIndex [
	^ focusedIndex
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> focusedIndex: anObject [
	focusedIndex := anObject
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> resetText: aString [
	self text: aString.
	editor enqueueTask: (BlTaskAction new action: [ editor text: aString ])
]
