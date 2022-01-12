Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodCoder >> asCoderViewModel [
	^ GtPharoMethodCoderViewModel new coder: self
]
