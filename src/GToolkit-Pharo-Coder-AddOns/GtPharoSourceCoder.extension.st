Extension { #name : 'GtPharoSourceCoder' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> colorAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoColorStyler new.
	coderAddOns addStyler: GtPharoGlamorousColorStyler new.
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> glamorousIconsAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoGlamorousIconStyler new.
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> haltAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 20>
	coderAddOns addStyler: GtPharoHaltStyler new
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> zincAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoZincStyler new.
	coderAddOns addStyler: GtPharoZincApplicationFormUrlEncodedEntityStyler new.
]
