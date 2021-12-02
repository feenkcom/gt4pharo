Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodCoder >> asCoderUIModel [
	^ GtPharoMethodCoderViewModel new coder: self
]
