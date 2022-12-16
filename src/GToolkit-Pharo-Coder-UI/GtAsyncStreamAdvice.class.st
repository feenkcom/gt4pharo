Class {
	#name : #GtAsyncStreamAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'compute',
		'stream'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Object Advices'
}

{ #category : #accessing }
GtAsyncStreamAdvice >> compute [
	^ compute
]

{ #category : #accessing }
GtAsyncStreamAdvice >> compute: aBlock [
	compute := aBlock
]

{ #category : #testing }
GtAsyncStreamAdvice >> hasAdvice [
	^ self result hasNext wait
]

{ #category : #initialization }
GtAsyncStreamAdvice >> initialize [
	super initialize.
	compute := [ #() asAsyncStream ]
]

{ #category : #accessing }
GtAsyncStreamAdvice >> result [
	stream ifNil: [ stream := compute value cached ].
	^ stream asyncSimilarCopy
]

{ #category : #enumerating }
GtAsyncStreamAdvice >> resultsDo: aBlock [
	(self result do: aBlock) wait
]
