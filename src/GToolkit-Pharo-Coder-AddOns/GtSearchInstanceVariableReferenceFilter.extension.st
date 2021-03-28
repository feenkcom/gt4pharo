Extension { #name : #GtSearchInstanceVariableReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSearchInstanceVariableReferenceFilter >> highlighter [
	^ GtPharoVariableReferenceHighlighter forVariableName: variableName
]
