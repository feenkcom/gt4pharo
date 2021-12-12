Class {
	#name : #GtGenericPharoStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtPharoProgramNodeVisitor',
	#classTraits : 'TGtPharoProgramNodeVisitor classTrait',
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #visiting }
GtGenericPharoStyler >> acceptNode: aSmaCCParseNode [
	<gtIgnoreConstraint: #GtRBAcceptVisitorCalledFromNonVisitingMethods>
	aSmaCCParseNode isNil
		ifTrue: [ ^ nil ].
	
	^ BlTextStylerTelemetry
		time: [ 'Visit ', aSmaCCParseNode class name ]
		during: [	 aSmaCCParseNode acceptVisitor: self ]
]

{ #category : #'api - styling' }
GtGenericPharoStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		on: Error do: [ :e | (GtStylerErrorSignal new signaledError: e) emit ].
	text := nil.
]
