Extension { #name : 'GtSearchInstanceSlotReferenceFilter' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtSearchInstanceSlotReferenceFilter >> highlighter [
	^ GtPharoVariableReferenceHighlighter forVariableName: variableName
]
