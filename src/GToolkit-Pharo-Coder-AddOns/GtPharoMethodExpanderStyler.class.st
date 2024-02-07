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
GtPharoMethodExpanderStyler >> method: aMessage parameterBindingsIntoAttribute: anAttribute [
	| aLocalBindings |
	aMessage arguments ifEmpty: [ ^ self ].
	aLocalBindings := GtLocalVariablesBindings new.

	aMessage arguments
		doWithIndex: [ :anArgument :anIndex | 
			anArgument isVariable
				ifTrue: [ evaluationContext
						variableValueOf: anArgument variableName
						ifPresent: [ :aValue | 
							| aNewName |
							aNewName := anAttribute compiledMethod argumentNames at: anIndex.
							aLocalBindings localAt: aNewName put: aValue ]
						ifAbsent: [  "ignore" ] ] ].

	aLocalBindings bindings ifEmpty: [ ^ self ].

	anAttribute localBindings: aLocalBindings
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
	self coderViewModel selfObject
		ifNotNil: [ :aSelfObject | anAttribute selfObject: aSelfObject ].
	self method: aMessage parameterBindingsIntoAttribute: anAttribute.
	text
		attribute: anAttribute
		from: aMessage selectorParts last stopPosition
		to: aMessage selectorParts last stopPosition
]
