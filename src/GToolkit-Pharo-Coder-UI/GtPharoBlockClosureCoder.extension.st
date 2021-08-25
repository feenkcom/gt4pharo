Extension { #name : 'GtPharoBlockClosureCoder' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtPharoBlockClosureCoder >> asCoderUIModel [
	^ GtSourceCoderViewModel new coder: self
]

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtPharoBlockClosureCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.
	
	addOns addShortcut: GtSourceCoderFormatShortcut new
]
