Extension { #name : #GtPharoSourceCoderViewModel }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoderViewModel >> renameLocalVariableAt: aTextIndex [
	GtCoderViewModelRenameAction
		pharoRenameLocalVariableAt: aTextIndex
		textualCoderViewModel: self
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoderViewModel >> renameLocalVariableAtCursor [
	self cursors do: [ :aCursor |
		^ GtCoderViewModelRenameAction
			pharoRenameLocalVariableAt: aCursor position
			textualCoderViewModel: self ]
]
