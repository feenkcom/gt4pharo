Class {
	#name : #GtPharoMethodExpanderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'variableBindings'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #'api - styling' }
GtPharoMethodExpanderStyler >> style: aText ast: theAst [
	variableBindings := self coderViewModel compositeVariableBindings.
	[ super style: aText ast: theAst ]
		ensure: [ variableBindings := nil ]
]

{ #category : #visiting }
GtPharoMethodExpanderStyler >> visitMessage: aMessage [
	| aMethodClass |
	self visitProgram: aMessage.
	aMessage parent isNil ifTrue: [ ^ self ].
	aMethodClass := GtPharoProgramNode
		typeOf: aMessage parent receiver
		in:
			(self coderViewModel selfObject
				ifNil: [ self coderViewModel coderModel behavior ]
				ifNotNil: [ :aSelfObject | aSelfObject class ])
		bindings: variableBindings.
	aMethodClass ifNil: [ ^ self ].
	(aMethodClass canUnderstand: aMessage selector) ifFalse: [ ^ self ].
	text
		attribute: (GtPharoMethodExpanderAttribute forClass: aMethodClass andSelector: aMessage selector)
		from: aMessage selectorParts last stopPosition
		to: aMessage selectorParts last stopPosition
]
