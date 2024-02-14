Class {
	#name : #GtPharoMethodExpanderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'variableBindings',
		'lastIndex',
		'evaluationContext'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #initialization }
GtPharoMethodExpanderStyler >> initialize [
	super initialize.
	
	lastIndex := 0.
]

{ #category : #private }
GtPharoMethodExpanderStyler >> nextIndex [
	^ lastIndex := (lastIndex ifNil: [ 0 ]) + 1
]

{ #category : #'api - styling' }
GtPharoMethodExpanderStyler >> style: aText ast: theAst [
	variableBindings := self coderViewModel compositeVariableBindingsForStyling.
	evaluationContext := self coderViewModel evaluationContext.
	[ super style: aText ast: theAst ]
		ensure: [ 
			variableBindings := nil.
			evaluationContext := nil ]
]

{ #category : #visiting }
GtPharoMethodExpanderStyler >> visitMessage: aMessage [
	| aMethodClass anAttribute aBuilder aClass |
	self visitProgram: aMessage.
	aMessage parent isNil ifTrue: [ ^ self ].
	aClass := self coderViewModel selfObject
			ifNil: [ self coderViewModel coderModel behavior ]
			ifNotNil: [ :aSelfObject | aSelfObject class ].
	aMethodClass := GtPharoProgramNode
			typeOf: aMessage parent receiver
			in: aClass
			bindings: variableBindings.

	aMethodClass ifNil: [ ^ self ].
	(aMethodClass canUnderstand: aMessage selector) ifFalse: [ ^ self ].

	anAttribute := GtPharoMethodExpanderAttribute
			forClass: aMethodClass
			andSelector: aMessage selector.
	anAttribute id: (GtPharoMethodExpanderId indexed: self nextIndex).
	aBuilder := GtPharoReceiverAndArgumentBindingsBuilder new
			evaluationContext: evaluationContext;
			parentMessage: aMessage.
	anAttribute argumentBindingsBuilder: aBuilder.
	text
		attribute: anAttribute
		from: aMessage selectorParts last stopPosition
		to: aMessage selectorParts last stopPosition
]
