"
I expand direct class references
"
Class {
	#name : #GtPharoClassExpanderStyler,
	#superclass : #GtPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable: aNamedVariable [
	super visitDeclaredGlobalVariable: aNamedVariable.
	text attribute: (GtPharoClassExpanderAttribute forClass: (self class environment at: aNamedVariable variableName))
		from: aNamedVariable startPosition 
		to: aNamedVariable stopPosition
]
