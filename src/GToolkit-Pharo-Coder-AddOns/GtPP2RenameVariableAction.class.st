Class {
	#name : #GtPP2RenameVariableAction,
	#superclass : #GtCoderViewModelRenameAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtPP2RenameVariableAction >> accept [
]

{ #category : #accessing }
GtPP2RenameVariableAction >> processReturnFor: renameEditor in: anEditorElement [
	| lastWasEditor first |
	lastWasEditor := false.
	anEditorElement
		allChildrenBreadthFirstDo: [ :each | 
			(lastWasEditor and: [ each isKindOf: GtRefactoringsPreviewButton ])
				ifTrue: [ ^ each openPreview ].
			(each isKindOf: GtRenameEditor)
				ifTrue: [ first ifNil: [ first := each ].
					lastWasEditor ifTrue: [ ^ each requestFocus ].
					lastWasEditor := each == renameEditor ] ].
	first ifNotNil: [ ^ first requestFocus ]
]
