Class {
	#name : #GtGenericPharoStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtPharoProgramNodeVisitor',
	#classTraits : 'TGtPharoProgramNodeVisitor classTrait',
	#category : #'GToolkit-Pharo-Coder-Styler'
}

{ #category : #visiting }
GtGenericPharoStyler >> acceptNode: aSmaCCParseNode [
	<gtIgnoreConstraint: #GtRBAcceptVisitorCalledFromNonVisitingMethods>
	aSmaCCParseNode isNil
		ifTrue: [ ^ nil ].
	
	^ BlTextStylerTelemetry
		timeSync: [ 'Visit ', aSmaCCParseNode class name ]
		during: [	 aSmaCCParseNode acceptVisitor: self ]
]

{ #category : #'api - styling' }
GtGenericPharoStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]
