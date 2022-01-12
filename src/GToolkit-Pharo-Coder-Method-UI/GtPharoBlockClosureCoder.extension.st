Extension { #name : #GtPharoBlockClosureCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoBlockClosureCoder >> asCoderViewModel [
	^ GtSourceCoderViewModel new coder: self
]
