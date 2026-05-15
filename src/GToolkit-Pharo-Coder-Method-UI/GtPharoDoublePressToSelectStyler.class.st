Class {
	#name : #GtPharoDoublePressToSelectStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #'as yet unclassified' }
GtPharoDoublePressToSelectStyler >> visitArray: anArray [
	| start end |
	super visitArray: anArray.
	
	start := anArray leftBrace stopPosition + 1.
	end := anArray rightBrace startPosition - 1.
	
	(self from: start to: end)
		doublePressToSelectAtBoundary
]

{ #category : #'as yet unclassified' }
GtPharoDoublePressToSelectStyler >> visitBlock: aBlock [
	| start end |
	super visitBlock: aBlock.

	start := aBlock leftBracket stopPosition + 1.
	end := aBlock rightBracket startPosition - 1.

	(self from: start to: end)
		doublePressToSelectAtBoundary
]

{ #category : #'as yet unclassified' }
GtPharoDoublePressToSelectStyler >> visitCommentFrom: aCommentStart to: aCommentEnd [
	(self
		from: aCommentStart + 1
		to: aCommentEnd - 1) doublePressToSelectAtBoundary
]

{ #category : #'as yet unclassified' }
GtPharoDoublePressToSelectStyler >> visitSmaCCParseNode: aSmaCCParseNode [
	super visitSmaCCParseNode: aSmaCCParseNode.

	aSmaCCParseNode comments ifNotNil: [ :theComments |
		theComments do: [ :eachComment |
			self visitCommentFrom: eachComment first to: eachComment second ] ]
]

{ #category : #'as yet unclassified' }
GtPharoDoublePressToSelectStyler >> visitSymbolLiteral: aSymbolLiteral [
	super visitSymbolLiteral: aSymbolLiteral.
	
	(self
		from: aSymbolLiteral value startPosition
		to: aSymbolLiteral value stopPosition)
			doublePressToSelect
]

{ #category : #'as yet unclassified' }
GtPharoDoublePressToSelectStyler >> visitValue: aValue [
	super visitValue: aValue.

	aValue leftParens doWithIndex: [ :leftParen :i |
		| rightParen start end |
		
		rightParen := aValue rightParens at: (aValue rightParens size - i + 1).
		start := leftParen stopPosition + 1.
		end := rightParen startPosition - 1.
	
		(self from: start to: end)
			doublePressToSelectAtBoundary
	].
]
