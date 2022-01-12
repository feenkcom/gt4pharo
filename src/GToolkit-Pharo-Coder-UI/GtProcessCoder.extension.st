Extension { #name : #GtProcessCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtProcessCoder >> asCoderViewModel [
	^ GtPharoProcessCoderViewModel new coder: self
]
