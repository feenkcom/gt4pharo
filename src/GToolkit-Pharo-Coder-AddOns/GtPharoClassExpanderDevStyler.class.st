Class {
	#name : #GtPharoClassExpanderDevStyler,
	#superclass : #GtPharoClassExpanderStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #'as yet unclassified' }
GtPharoClassExpanderDevStyler >> visitDeclaredGlobalVariable: aNamedVariable [
	^ self visitDeclaredGlobalVariable_06_extraCache: aNamedVariable
]
