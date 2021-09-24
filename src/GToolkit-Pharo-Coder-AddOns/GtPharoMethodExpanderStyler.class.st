Class {
	#name : 'GtPharoMethodExpanderStyler',
	#superclass : 'GtGenericPharoStyler',
	#instVars : [
		'variableBindings'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : 'api - styling' }
GtPharoMethodExpanderStyler >> style: aText ast: theAst [
	variableBindings := self coderViewModel compositeVariableBindings.
	[ super style: aText ast: theAst ]
		ensure: [ variableBindings := nil ]
]

{ #category : 'visiting' }
GtPharoMethodExpanderStyler >> visitMessageSend: aMessageNode [
	| aMethodClass |

	self visitValue: aMessageNode.

	aMethodClass := GtPharoProgramNode
		typeOf: aMessageNode receiver
		in: (self coderViewModel selfObject
			ifNil: [ self coderViewModel coderModel behavior ]
			ifNotNil: [ :aSelfObject | aSelfObject class ])
		bindings: variableBindings.

	aMethodClass
		ifNil: [ ^ self ].

	(aMethodClass canUnderstand: aMessageNode selector)
		ifFalse: [ ^ self ].

	text
		attribute: (GtPharoMethodExpanderAttribute
			forClass: aMethodClass
			andSelector: aMessageNode selector)
		from: aMessageNode selectorParts last stopPosition
		to: aMessageNode selectorParts last stopPosition
]
