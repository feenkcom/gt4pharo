Class {
	#name : #GtSourceCoderFormatPositionMap,
	#superclass : #Object,
	#instVars : [
		'tokenMappings',
		'originalSource',
		'formattedSource'
	],
	#category : #'GToolkit-Pharo-Coder-Method'
}

{ #category : #'instance creation' }
GtSourceCoderFormatPositionMap class >> tokenMappings: aCollection originalSource: anOriginalString formattedSource: aFormattedString [
	^ self new
		setTokenMappings: aCollection
		originalSource: anOriginalString
		formattedSource: aFormattedString
]

{ #category : #mapping }
GtSourceCoderFormatPositionMap >> mapPosition: anOriginalPosition [
	tokenMappings
		reverseDo: [ :mapping | 
			(mapping includesOriginalPosition: anOriginalPosition)
				ifTrue: [ ^ mapping
						mapPosition: anOriginalPosition
						inOriginalSource: originalSource
						formattedSource: formattedSource ] ].
	tokenMappings
		reverseDo: [ :mapping | mapping originalStop < anOriginalPosition ifTrue: [ ^ mapping formattedStop ] ].
	^ anOriginalPosition
]

{ #category : #mapping }
GtSourceCoderFormatPositionMap >> mapRange: anInterval [
	| mappedStart mappedEnd |
	mappedStart := self mapPosition: anInterval first.
	mappedEnd := self mapPosition: anInterval last.
	^mappedStart to: mappedEnd
]

{ #category : #private }
GtSourceCoderFormatPositionMap >> setTokenMappings: aCollection originalSource: anOriginalString formattedSource: aFormattedString [
	tokenMappings := aCollection.
	originalSource := anOriginalString.
	formattedSource := aFormattedString
]

{ #category : #accessing }
GtSourceCoderFormatPositionMap >> size [
	^tokenMappings size
]

{ #category : #accessing }
GtSourceCoderFormatPositionMap >> tokenMappings [
	^tokenMappings
]
