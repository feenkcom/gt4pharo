Class {
	#name : #GtSourceCoderFormattedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'originalSource',
		'formattedSource',
		'positionMap'
	],
	#category : #'GToolkit-Pharo-Coder-Method'
}

{ #category : #'instance creation' }
GtSourceCoderFormattedEvent class >> originalSource: anOriginalString formattedSource: aFormattedString positionMap: aPositionMap [
	^(self new)
		originalSource: anOriginalString;
		formattedSource: aFormattedString;
		positionMap: aPositionMap
]

{ #category : #accessing }
GtSourceCoderFormattedEvent >> charactersAdded [
	^formattedSource size - originalSource size
]

{ #category : #accessing }
GtSourceCoderFormattedEvent >> formattedSource [
	^formattedSource
]

{ #category : #accessing }
GtSourceCoderFormattedEvent >> formattedSource: aString [
	formattedSource := aString
]

{ #category : #mapping }
GtSourceCoderFormattedEvent >> mapPosition: anOriginalPosition [
	^positionMap mapPosition: anOriginalPosition
]

{ #category : #accessing }
GtSourceCoderFormattedEvent >> originalSource [
	^originalSource
]

{ #category : #accessing }
GtSourceCoderFormattedEvent >> originalSource: aString [
	originalSource := aString
]

{ #category : #accessing }
GtSourceCoderFormattedEvent >> positionMap [
	^positionMap
]

{ #category : #accessing }
GtSourceCoderFormattedEvent >> positionMap: aGtSourceCoderFormatPositionMap [
	positionMap := aGtSourceCoderFormatPositionMap
]
