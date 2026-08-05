Class {
	#name : #GtSourceCoderFormatTokenMapping,
	#superclass : #Object,
	#instVars : [
		'originalStart',
		'originalStop',
		'formattedStart',
		'formattedStop'
	],
	#category : #'GToolkit-Pharo-Coder-Method'
}

{ #category : #'instance creation' }
GtSourceCoderFormatTokenMapping class >> originalStart: aStart originalStop: aStop formattedStart: aFmtStart formattedStop: aFmtStop [
	^self new
		setOriginalStart: aStart
		originalStop: aStop
		formattedStart: aFmtStart
		formattedStop: aFmtStop
]

{ #category : #accessing }
GtSourceCoderFormatTokenMapping >> formattedStart [
	^formattedStart
]

{ #category : #accessing }
GtSourceCoderFormatTokenMapping >> formattedStop [
	^formattedStop
]

{ #category : #testing }
GtSourceCoderFormatTokenMapping >> includesOriginalPosition: aPosition [
	^originalStart <= aPosition and: [originalStop >= aPosition]
]

{ #category : #mapping }
GtSourceCoderFormatTokenMapping >> mapPosition: anOriginalPosition [
	^formattedStart + (anOriginalPosition - originalStart)
]

{ #category : #mapping }
GtSourceCoderFormatTokenMapping >> mapPosition: anOriginalPosition inOriginalSource: anOriginalString formattedSource: aFormattedString [
	| origSize fmtSize |
	origSize := originalStop - originalStart + 1.
	fmtSize := formattedStop - formattedStart + 1.
	(origSize = fmtSize or: [ anOriginalString isNil ])
		ifTrue: [ ^ self mapPosition: anOriginalPosition ].
	^ self
		mapPositionByCharacterMatch: anOriginalPosition
		inOriginalSource: anOriginalString
		formattedSource: aFormattedString
]

{ #category : #mapping }
GtSourceCoderFormatTokenMapping >> mapPositionByCharacterMatch: anOriginalPosition inOriginalSource: anOriginalString formattedSource: aFormattedString [
	| char occurrence fmtTokenStr idx searchFrom |
	char := anOriginalString at: anOriginalPosition.
	occurrence := 0.
	originalStart
		to: anOriginalPosition
		do: [ :i | (anOriginalString at: i) = char ifTrue: [ occurrence := occurrence + 1 ] ].
	fmtTokenStr := aFormattedString copyFrom: formattedStart to: formattedStop.
	idx := 0.
	searchFrom := 0.
	1
		to: occurrence
		do: [ :o | 
			idx := fmtTokenStr indexOf: char startingAt: searchFrom + 1.
			idx > 0 ifTrue: [ searchFrom := idx ] ].
	idx > 0
		ifTrue: [ ^ formattedStart + idx - 1 ]
		ifFalse: [ ^ self mapPosition: anOriginalPosition ]
]

{ #category : #accessing }
GtSourceCoderFormatTokenMapping >> offset [
	^formattedStart - originalStart
]

{ #category : #accessing }
GtSourceCoderFormatTokenMapping >> originalStart [
	^originalStart
]

{ #category : #accessing }
GtSourceCoderFormatTokenMapping >> originalStop [
	^originalStop
]

{ #category : #printing }
GtSourceCoderFormatTokenMapping >> printOn: aStream [
	aStream
		nextPutAll: '[';
		print: originalStart;
		nextPut: $-;
		print: originalStop;
		nextPutAll: ' | ';
		print: formattedStart;
		nextPut: $-;
		print: formattedStop;
		nextPut: $]
]

{ #category : #private }
GtSourceCoderFormatTokenMapping >> setOriginalStart: aStart originalStop: aStop formattedStart: aFmtStart formattedStop: aFmtStop [
	originalStart := aStart.
	originalStop := aStop.
	formattedStart := aFmtStart.
	formattedStop := aFmtStop
]
