Extension { #name : #GtPharoBehaviorDefinitionSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> addEvaluateAddonsTo: anAst to: coderAddOns [
	<gtCoderContextMenuAddOns>
	(self
		addContextMenuItemFrom: GtSourceCoderCompileItShortcut new
		group: BrMenuItemGroupConfiguration evaluation
		withId: GtSourceCoderDoItActionId
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 800 ].
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> addRenameMethodAst: anAst to: coderAddOns from: aCoderViewModel [
	"Disable addOns"

	<gtCoderContextMenuAddOns>
	^ self
]
