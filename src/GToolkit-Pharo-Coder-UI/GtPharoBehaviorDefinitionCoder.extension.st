Extension { #name : #GtPharoBehaviorDefinitionCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoBehaviorDefinitionCoder >> asCoderViewModel [
	^ GtBehaviorDefinitionCoderViewModel new coder: self
]
