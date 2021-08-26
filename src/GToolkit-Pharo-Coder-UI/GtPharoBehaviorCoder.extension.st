Extension { #name : 'GtPharoBehaviorCoder' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtPharoBehaviorCoder >> asCardElement [
	^ GtClassCardElement new coder: self
]

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtPharoBehaviorCoder >> asCoderUIModel [
	^ GtPharoBehaviorCoderViewModel new coder: self
]
