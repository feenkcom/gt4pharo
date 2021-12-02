Extension { #name : #GtPharoMethodContextCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodContextCoder >> asCoderUIModel [
	^ (GtPharoMethodContextCoderViewModel new coder: self)
		selfObject: self context receiver
]
