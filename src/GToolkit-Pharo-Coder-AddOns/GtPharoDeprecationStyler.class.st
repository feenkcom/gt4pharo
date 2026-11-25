Class {
	#name : #GtPharoDeprecationStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Deprecation'
}

{ #category : #generated }
GtPharoDeprecationStyler >> visitNamedVariable: aNamedVariable [
	super visitNamedVariable: aNamedVariable.

	(self coderViewModel isDeprecatedGlobalNamed: aNamedVariable variableName)
		ifFalse: [ ^ self ].

	self
		attribute: (BlTextDecorationAttribute new lineThrough
				color: self theme editor pharoDeclaredVariableForeground)
		from: aNamedVariable name startPosition
		to: aNamedVariable name stopPosition
]
