Class {
	#name : #GtPharoSymbolLiteralNode,
	#superclass : #GtPharoLiteralNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoSymbolLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSymbolLiteral: self
]

{ #category : #accessing }
GtPharoSymbolLiteralNode >> asSymbol [
	| name |
	name := self value source.
	name first = $#
		ifTrue: [ name := name copyFrom: 2 to: name size ].
	name first = $'
		ifTrue: [ name := (name copyFrom: 2 to: name size - 1) copyReplaceAll: '''''' with: '''' ].
	^ name asSymbol
]

{ #category : #accessing }
GtPharoSymbolLiteralNode >> guessType: completionStrategy [
	^ Symbol
]

{ #category : #accessing }
GtPharoSymbolLiteralNode >> literalValue [
	^ self symbol
]

{ #category : #generated }
GtPharoSymbolLiteralNode >> otherVariables [
	^ #(#value)
]

{ #category : #accessing }
GtPharoSymbolLiteralNode >> symbol [
	^ self asSymbol
]

{ #category : #generated }
GtPharoSymbolLiteralNode >> value [
	^ value
]

{ #category : #generated }
GtPharoSymbolLiteralNode >> value: anObject [
	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]
