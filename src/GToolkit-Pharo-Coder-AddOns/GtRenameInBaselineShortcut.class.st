Class {
	#name : #GtRenameInBaselineShortcut,
	#superclass : #GtSourceCoderInlineRenameShortcut,
	#category : #'GToolkit-Pharo-Coder-AddOns-Rename'
}

{ #category : #accessing }
GtRenameInBaselineShortcut >> description [
	^ 'Performs the rename refactoring of the selected variable/class/method/package.'
]

{ #category : #accessing }
GtRenameInBaselineShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement coderViewModel: aSourceCoderViewModel dueTo: aShortcutEvent [
	| position |
	aBrEditorElement
		selectedStringAndIntervalDo: [ :aSelectedString :aSelectionInterval | position := aSelectionInterval last ]
		orCursorPositionDo: [ :aCursorTextPosition | position := aCursorTextPosition ].
	position notNil
		ifTrue: [ (aSourceCoderViewModel coder
				renamePackageAt: position
				in: aSourceCoderViewModel
				from: aBrEditorElement) ifTrue: [ ^ self ].
			(aSourceCoderViewModel coder
				renameBaselineAt: position
				in: aSourceCoderViewModel
				for: aBrEditorElement) ifTrue: [ ^ self ] ].
	super
		performOnEditor: aBrTextEditor
		element: aBrEditorElement
		coderViewModel: aSourceCoderViewModel
		dueTo: aShortcutEvent
]
