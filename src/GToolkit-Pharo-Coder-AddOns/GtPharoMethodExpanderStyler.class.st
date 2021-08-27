Class {
	#name : 'GtPharoMethodExpanderStyler',
	#superclass : 'GtGenericPharoStyler',
	#category : 'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : 'visiting' }
GtPharoMethodExpanderStyler >> visitMessageSend: aMessageNode [
	| aMethodClass |

	self visitValue: aMessageNode.

	aMethodClass := GtPharoProgramNode
		typeOf: aMessageNode receiver
		in: (self coderViewModel selfObject
			ifNil: [ self coderViewModel coderModel behavior ]
			ifNotNil: [ :aSelfObject | aSelfObject class ])
		bindings: self coderViewModel.

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
