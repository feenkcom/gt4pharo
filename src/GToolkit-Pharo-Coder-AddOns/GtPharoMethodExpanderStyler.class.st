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
GtPharoMethodExpanderStyler >> method: aMessage argumentBindingsIntoAttribute: anAttribute [
	| aBuilder |
	aBuilder := GtPharoArgumentBindingsBuilder new
		evaluationContext: evaluationContext;
		parentMessage: aMessage.
	
	anAttribute argumentBindingsBuilder: aBuilder
]

{ #category : #private }
GtPharoMethodExpanderStyler >> nextIndex [
	^ lastIndex := (lastIndex ifNil: [ 0 ]) + 1
]

{ #category : #'api - styling' }
GtPharoMethodExpanderStyler >> style: aText ast: theAst [
	variableBindings := self coderViewModel compositeVariableBindings.
	evaluationContext := self coderViewModel evaluationContext.
	[ super style: aText ast: theAst ]
		ensure: [ 
			variableBindings := nil.
			evaluationContext := nil ]
]

{ #category : #visiting }
GtPharoMethodExpanderStyler >> visitMessage: aMessage [
	| aMethodClass anAttribute |
	self visitProgram: aMessage.
	aMessage parent isNil ifTrue: [ ^ self ].
	aMethodClass := GtPharoProgramNode
			typeOf: aMessage parent receiver
			in: (self coderViewModel selfObject
					ifNil: [ self coderViewModel coderModel behavior ]
					ifNotNil: [ :aSelfObject | aSelfObject class ])
			bindings: variableBindings.
	aMethodClass ifNil: [ ^ self ].
	(aMethodClass canUnderstand: aMessage selector) ifFalse: [ ^ self ].
	
	anAttribute := GtPharoMethodExpanderAttribute
			forClass: aMethodClass
			andSelector: aMessage selector.
	anAttribute id: (GtPharoMethodExpanderId indexed: self nextIndex).
	self method: aMessage argumentBindingsIntoAttribute: anAttribute.
	text
		attribute: anAttribute
		from: aMessage selectorParts last stopPosition
		to: aMessage selectorParts last stopPosition
]
