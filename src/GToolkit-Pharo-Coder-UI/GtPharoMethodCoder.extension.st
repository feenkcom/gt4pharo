Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoMethodCoder >> asCoderUIModel [
	^ GtPharoMethodCoderViewModel new coder: self
]
