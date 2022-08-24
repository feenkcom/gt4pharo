Class {
	#name : #GtRenamePackageInBaselineShortcut,
	#superclass : #GtSourceCoderInlineRenameShortcut,
	#category : #'GToolkit-Pharo-Coder-Method-Rename'
}

{ #category : #accessing }
GtRenamePackageInBaselineShortcut >> description [
	^ 'Performs the rename refactoring of the selected variable/class/method/package.'
]

{ #category : #accessing }
GtRenamePackageInBaselineShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement coderViewModel: aSourceCoderViewModel dueTo: aShortcutEvent [
	| position |
	self
		forEditor: aBrTextEditor
		selectionIntervalDo: [ :aSelectionInterval | position := aSelectionInterval last ]
		orCursorStringPositionDo: [ :aCursorTextPosition | position := aCursorTextPosition ].
	(position notNil
		and: [ aSourceCoderViewModel coder
				renamePackageAt: position
				in: aSourceCoderViewModel ])
		ifFalse: [ super
				performOnEditor: aBrTextEditor
				element: aBrEditorElement
				coderViewModel: aSourceCoderViewModel
				dueTo: aShortcutEvent ]
]
