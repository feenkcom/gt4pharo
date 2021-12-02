Extension { #name : #GtPharoBlockClosureCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoBlockClosureCoder >> asCoderUIModel [
	^ GtSourceCoderViewModel new coder: self
]
