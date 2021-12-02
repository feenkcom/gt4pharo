Extension { #name : #GtPharoMethodContextCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodContextCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.
	
	addOns addShortcut: GtSourceCoderPrintItShortcut new
]
