Extension { #name : #GtPharoBehaviorDefinitionCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoBehaviorDefinitionCoder >> asCoderViewModel [
	^ GtBehaviorDefinitionCoderUIModel new coder: self
]
