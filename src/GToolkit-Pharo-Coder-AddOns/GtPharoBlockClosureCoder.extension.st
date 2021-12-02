Extension { #name : #GtPharoBlockClosureCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBlockClosureCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoDynamicHighlightStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBlockClosureCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.
	
	addOns addShortcut: GtSourceCoderFormatShortcut new
]
