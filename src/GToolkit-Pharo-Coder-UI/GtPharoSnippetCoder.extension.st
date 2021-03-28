Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoSnippetCoder >> asCoderUIModel [
	^ GtPharoSnippetCoderViewModel new coder: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoSnippetCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new;
		addShortcut: GtSourceCoderPrintItShortcut new;
		addShortcut: GtSourceCoderInlineRenameShortcut new
]
