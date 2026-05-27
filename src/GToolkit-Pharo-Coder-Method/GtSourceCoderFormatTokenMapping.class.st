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
