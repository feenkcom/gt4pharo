Class {
	#name : #GtPharoSuiteStateId,
	#superclass : #BlElementId,
	#instVars : [
		'state'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-Element ID'
}

{ #category : #comparing }
GtPharoSuiteStateId >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self state = anObject state
]

{ #category : #accessing }
GtPharoSuiteStateId >> asSymbol [
	^ Symbol
		streamContents: [ :aStream | 
			aStream
				nextPutAll: 'coder--suite--state-';
				nextPutAll: (self state
						ifNotNil: [ :aState | aState label asString asLowercase ]
						ifNil: #asString) ]
]

{ #category : #comparing }
GtPharoSuiteStateId >> hash [
	^ self state hash
]

{ #category : #accessing }
GtPharoSuiteStateId >> state [

	^ state
]

{ #category : #accessing }
GtPharoSuiteStateId >> state: anObject [

	state := anObject
]
