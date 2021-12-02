Extension { #name : #GtPharoSourceCoderViewModel }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoderViewModel >> renameLocalVariableAt: aTextIndex [
	GtRenameAction2
		pharoRenameLocalVariableAt: aTextIndex
		textualCoderViewModel: self
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoderViewModel >> renameLocalVariableAtCursor [
	self cursors do: [ :aCursor |
		^ GtRenameAction2
			pharoRenameLocalVariableAt: aCursor position
			textualCoderViewModel: self ]
]
