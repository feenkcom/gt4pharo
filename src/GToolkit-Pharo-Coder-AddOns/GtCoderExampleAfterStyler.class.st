Class {
	#name : #GtCoderExampleAfterStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'variableBindings'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #visiting }
GtCoderExampleAfterStyler >> visitPragma: aPragmaNode [

	| aMethodClass aSelectorNode aSelector |
	super visitPragma: aPragmaNode.

	aPragmaNode selector = #after: ifFalse: [ ^ self ].

	aMethodClass := self coderViewModel
		ifSelfObject: [ :aSelfObject | aSelfObject class ]
		ifNone: [ self coderViewModel behavior ].
	
	aMethodClass ifNil: [ ^ self ].

	aSelectorNode := aPragmaNode values first.
	aSelector := aSelectorNode symbol.
	
	(aMethodClass canUnderstand: aSelector) ifFalse: [ ^ self ].

	text
		attribute: (GtPharoMethodExpanderAttribute
				 forClass: aMethodClass
				 andSelector: aSelector)
		from: aSelectorNode stopPosition
		to: aSelectorNode stopPosition
]
