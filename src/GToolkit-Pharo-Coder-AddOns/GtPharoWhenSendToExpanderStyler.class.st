"
I expand the second argument of {{gtMethod:Announcer>>#when:send:to:}}.
I expand it when the third argument is `self`, the second argument is a symbol, and the symbol is a name of an existing method of the class where it is defined.
#Example
{{gtExample:GtPharoWhenSendToExpanderStylerExamples>>#whenSendToSubscription}}

"
Class {
	#name : #GtPharoWhenSendToExpanderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'variableBindings'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #'api - styling' }
GtPharoWhenSendToExpanderStyler >> style: aText ast: theAst [
	variableBindings := self coderViewModel compositeVariableBindings.
	[ super style: aText ast: theAst ]
		ensure: [ variableBindings := nil ]
]

{ #category : #visiting }
GtPharoWhenSendToExpanderStyler >> visitKeywordMessage: aMessageNode [

	| aMethodClass aSelector aSelectorNode |
	super visitKeywordMessage: aMessageNode.

	aMessageNode selector = #when:send:to: ifFalse: [ ^ self ].

	aMethodClass := self coderViewModel 
		ifSelfObject: #class 
		ifNone: [ self coderViewModel behavior ].
	
	aMethodClass ifNil: [ ^ self ].

	aMessageNode arguments third isSelf ifFalse: [ ^ self ].

	aSelectorNode := aMessageNode arguments second.
	aSelectorNode isLiteral ifFalse: [ ^ self ].
	aSelectorNode isSymbol ifFalse: [ ^ self ].
	aSelector := aSelectorNode symbol.

	(aMethodClass canUnderstand: aSelector) ifFalse: [ ^ self ].

	text
		attribute: (GtPharoMethodExpanderAttribute
				 forClass: aMethodClass
				 andSelector: aSelector)
		from: aSelectorNode stopPosition
		to: aSelectorNode stopPosition
]
