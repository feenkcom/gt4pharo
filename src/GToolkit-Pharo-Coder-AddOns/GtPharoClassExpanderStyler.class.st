"
I expand direct class references
"
Class {
	#name : #GtPharoClassExpanderStyler,
	#superclass : #GtGenericPharoStyler,
	#category : 'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable: aNamedVariable [
	(self class environment at: aNamedVariable variableName) isBehavior
		ifFalse: [ ^ self ].
	text
		attribute: (GtPharoClassExpanderAttribute
				forClass: (self class environment at: aNamedVariable variableName))
		from: aNamedVariable stopPosition
		to: aNamedVariable stopPosition
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitNamedVariable: aNamedVariable [
	super visitNamedVariable: aNamedVariable.
	(self coderViewModel hasDeclaredGlobalNamed: aNamedVariable variableName)
		ifTrue: [ ^ self visitDeclaredGlobalVariable: aNamedVariable ]
]
