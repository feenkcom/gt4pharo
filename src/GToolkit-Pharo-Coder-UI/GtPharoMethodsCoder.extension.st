Extension { #name : 'GtPharoMethodsCoder' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtPharoMethodsCoder >> asCoderUIModel [
	^ GtPharoMethodsCoderViewModel new coder: self
]
