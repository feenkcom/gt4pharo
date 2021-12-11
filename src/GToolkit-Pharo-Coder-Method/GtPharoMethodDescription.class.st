Class {
	#name : #GtPharoMethodDescription,
	#superclass : #Object,
	#instVars : [
		'behavior',
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #accessing }
GtPharoMethodDescription class >> forCompiledMethod: aCompiledMethod [
	^ self new
		behavior: aCompiledMethod methodClass;
		selector: aCompiledMethod selector
]

{ #category : #comparing }
GtPharoMethodDescription >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self behavior = anObject behavior
		and: [ self selector = anObject selector ]
]

{ #category : #accessing }
GtPharoMethodDescription >> behavior [

	^ behavior
]

{ #category : #accessing }
GtPharoMethodDescription >> behavior: anObject [

	behavior := anObject
]

{ #category : #comparing }
GtPharoMethodDescription >> hash [
	^ self behavior hash
		bitXor: (self selector hash)
]

{ #category : #printing }
GtPharoMethodDescription >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		print: behavior;
		space;
		nextPutAll: '>>';
		space;
		nextPut: $#;
		nextPutAll: selector
]

{ #category : #accessing }
GtPharoMethodDescription >> selector [

	^ selector
]

{ #category : #accessing }
GtPharoMethodDescription >> selector: anObject [

	selector := anObject
]
