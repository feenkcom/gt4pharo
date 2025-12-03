"
I highlight an interesting interval in a source code.
"
Class {
	#name : #GtPharoInterestingIntervalStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'interval'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Color'
}

{ #category : #comparing }
GtPharoInterestingIntervalStyler >> = anObject [
	^ super = anObject and: [ interval = anObject interval ]
]

{ #category : #'api - styling' }
GtPharoInterestingIntervalStyler >> extraStyle: aText ast: theAst [
	interval ifNil: [ ^ self ].
	aText size < interval last ifTrue: [ ^ self ].
	interval first < 1 ifTrue: [ ^ self ].

	super extraStyle: aText ast: theAst.
	(aText from: interval first to: interval last)
		highlight: BrGlamorousColors debuggerTextHighlightColor
]

{ #category : #comparing }
GtPharoInterestingIntervalStyler >> hash [
	^ super hash bitXor: interval hash
]

{ #category : #accessing }
GtPharoInterestingIntervalStyler >> interval [
	^ interval
]

{ #category : #accessing }
GtPharoInterestingIntervalStyler >> interval: anObject [
	interval := anObject
]
