Extension { #name : #GtPharoSourceCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> haltAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 20>
	coderAddOns addStyler: GtCoderHaltStyler new
]
