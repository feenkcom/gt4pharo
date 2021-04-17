Class {
	#name : #GtPharoTemplateStyler,
	#superclass : #GtPharoStyler,
	#category : #'GToolkit-Pharo-Coder-Styler'
}

{ #category : #'visiting - variables' }
GtPharoTemplateStyler >> visitUndeclaredVariable: aVariableNode [

	(aVariableNode name value isKindOf: GtPharoTemplateNode)
		ifFalse: [
			aVariableNode allParents
				detect: [ :each | each isKindOf: GtPharoTemplateNode ]
				ifNone: [ ^ super visitUndeclaredVariable: aVariableNode ] ].
	
	self
		attributes: {
			BlTextForegroundAttribute color: Color green muchDarker.
			BlFontEmphasisAttribute italic
		}
		from: aVariableNode name startPosition
		to: aVariableNode name stopPosition
]
