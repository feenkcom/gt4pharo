Extension { #name : #GtCoderKeymapRegistry }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtCoderKeymapRegistry >> initializeFixItShortcutCombination [
	<gtKeymapRegistration>
	self 
		initializeShortcut: GtCoderShortcutIds default fixItShortcutId
		with: BlKeyCombination primaryT
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtCoderKeymapRegistry >> initializeRenameInBaselineShortcutCombination [
	<gtKeymapRegistration>
	self 
		initializeShortcut: GtCoderShortcutIds default renameInBaselineShortcutId
		with: BlKeyCombination primaryR
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtCoderKeymapRegistry >> initializeSnippetCoderExtractMethodShortcutCombination [
	<gtKeymapRegistration>
	self 
		initializeShortcut: GtCoderShortcutIds default snippetCoderExtractMethodShortcutId
		with: BlKeyCombination primaryE
]
