Extension { #name : #GtProcessCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtProcessCoder >> asCoderUIModel [
	^ GtPharoProcessCoderViewModel new coder: self
]
