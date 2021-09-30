Extension { #name : #GtSearchReferencesFilter }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSearchReferencesFilter >> highlighter [
	((self object isKindOf: Association) and: [ self object key isSymbol ])
		ifTrue: [ ^ GtPharoVariableReferenceHighlighter forVariableName: self object key ].
	(self object isKindOf: Variable) 
		ifTrue: [ ^ GtPharoVariableReferenceHighlighter forVariableName: self object name ].
	self object isLiteral ifTrue: [ ^ GtPharoSelectorReferenceAndLiteralHighlighter forSelector: self object ].
	^ nil
]
