Class {
	#name : #GtSourceCoderFormatPositionMap,
	#superclass : #Object,
	#instVars : [
		'tokenMappings'
	],
	#category : #'GToolkit-Pharo-Coder-Method'
}

{ #category : #'instance creation' }
GtSourceCoderFormatPositionMap class >> tokenMappings: aCollection [
	^self new setTokenMappings: aCollection
]

{ #category : #mapping }
GtSourceCoderFormatPositionMap >> mapPosition: anOriginalPosition [
	tokenMappings reverseDo: 
			[:mapping |
			(mapping includesOriginalPosition: anOriginalPosition)
				ifTrue: [^mapping mapPosition: anOriginalPosition]].
	tokenMappings reverseDo: 
			[:mapping |
			mapping originalStop < anOriginalPosition
				ifTrue: [^anOriginalPosition + mapping offset]].
	^anOriginalPosition
]

{ #category : #mapping }
GtSourceCoderFormatPositionMap >> mapRange: anInterval [
	| mappedStart mappedEnd |
	mappedStart := self mapPosition: anInterval first.
	mappedEnd := self mapPosition: anInterval last.
	^mappedStart to: mappedEnd
]

{ #category : #private }
GtSourceCoderFormatPositionMap >> setTokenMappings: aCollection [
	tokenMappings := aCollection
]

{ #category : #accessing }
GtSourceCoderFormatPositionMap >> size [
	^tokenMappings size
]

{ #category : #accessing }
GtSourceCoderFormatPositionMap >> tokenMappings [
	^tokenMappings
]
