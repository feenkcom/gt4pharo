Class {
	#name : #GtPharoVariableReferenceHighlighter,
	#superclass : #GtPharoCodeHighlighter,
	#instVars : [
		'variableName',
		'searchSymbols'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Highlighter'
}

{ #category : #'instance creation' }
GtPharoVariableReferenceHighlighter class >> forSymbolAndVariableName: aString [
	^ self new
		variableName: aString;
		includeSymbols;
		yourself
]

{ #category : #'instance creation' }
GtPharoVariableReferenceHighlighter class >> forVariableName: aString [
	^ self new
		variableName: aString;
		yourself
]

{ #category : #initialization }
GtPharoVariableReferenceHighlighter >> includeSymbols [
	searchSymbols := true
]

{ #category : #initialization }
GtPharoVariableReferenceHighlighter >> initialize [
	super initialize.
	searchSymbols := false
]

{ #category : #accessing }
GtPharoVariableReferenceHighlighter >> variableName [
	^ variableName
]

{ #category : #accessing }
GtPharoVariableReferenceHighlighter >> variableName: anObject [
	variableName := anObject
]

{ #category : #visiting }
GtPharoVariableReferenceHighlighter >> visitSymbolLiteral: aNode [
	super visitSymbolLiteral: aNode.
	searchSymbols ifFalse: [ ^ self ].
	(aNode symbol sameContentAs: variableName)
		ifTrue: [ stream nextPut: (aNode startPosition to: aNode stopPosition) ]
]

{ #category : #visiting }
GtPharoVariableReferenceHighlighter >> visitVariable: aVariableNode [
	super visitVariable: aVariableNode.

	(aVariableNode variableName sameContentAs: variableName)
		ifTrue: [ stream
				nextPut: (aVariableNode name startPosition to: aVariableNode name stopPosition) ]
]
