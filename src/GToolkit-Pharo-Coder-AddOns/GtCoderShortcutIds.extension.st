Extension { #name : #GtCoderShortcutIds }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtCoderShortcutIds >> fixItShortcutId [
	^ self shortcutIdForIdentifier: #CoderFixIt
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtCoderShortcutIds >> renameInBaselineShortcutId [
	^ self shortcutIdForIdentifier: #CoderRenameInBaseline
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtCoderShortcutIds >> snippetCoderExtractMethodShortcutId [
	^ self shortcutIdForIdentifier: #CoderSnippetExtractMethod
]
