Class {
	#name : #GtPharoLiteralValueHighlighter,
	#superclass : #GtPharoCodeHighlighter,
	#instVars : [
		'literalValue'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Highlighter'
}

{ #category : #'instance creation' }
GtPharoLiteralValueHighlighter class >> literalValue: aLiteralValue [
	^ self new
		literalValue: aLiteralValue
		yourself
]

{ #category : #accessing }
GtPharoLiteralValueHighlighter >> literalValue [
	^ literalValue
]

{ #category : #accessing }
GtPharoLiteralValueHighlighter >> literalValue: aLiteralValue [
	literalValue := aLiteralValue
]

{ #category : #visiting }
GtPharoLiteralValueHighlighter >> visitLiteral: aLiteralNode [	
	(literalValue = aLiteralNode literalValue)
		ifTrue: [ stream nextPut: (aLiteralNode startPosition 
			to: aLiteralNode stopPosition) ]
		ifFalse: [ super visitSmaCCParseNode: aLiteralNode ]
]
