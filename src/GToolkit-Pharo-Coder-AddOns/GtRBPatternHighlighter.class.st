Class {
	#name : #GtRBPatternHighlighter,
	#superclass : #GtPharoCodeHighlighter,
	#instVars : [
		'ast'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Highlighter'
}

{ #category : #accessing }
GtRBPatternHighlighter >> ast [
	^ ast
]

{ #category : #accessing }
GtRBPatternHighlighter >> ast: aRBProgramNode [
	ast := aRBProgramNode
]

{ #category : #'api - styling' }
GtRBPatternHighlighter >> style: aText ast: theAst [
	| tree intervals |
	tree := theAst
		        attributeNamed: #rbAST
		        ifAbsentPut: [ RBParser parseFaultyMethod: aText asString ].
	intervals := OrderedCollection new.
	tree nodesDo: [ :each | 
		(ast match: each inContext: Dictionary new) ifTrue: [ 
			intervals addAll: each gtInterestingHighlightingIntervals ] ].
	self style: aText intervals: intervals.
	^ aText
]
