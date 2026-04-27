Class {
	#name : #GtPharoRenameSelectorHighlightElementStateRequestSignal,
	#superclass : #GtPharoRenameSelectorElementSignal,
	#instVars : [
		'isHighlighted'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorHighlightElementStateRequestSignal >> isHighlighted [
	^ isHighlighted
]

{ #category : #accessing }
GtPharoRenameSelectorHighlightElementStateRequestSignal >> isHighlighted: anObject [
	isHighlighted := anObject
]

{ #category : #printing }
GtPharoRenameSelectorHighlightElementStateRequestSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPut: (isHighlighted ifTrue: [ $+ ] ifFalse: [ $- ]);
		nextPutAll: ' Change ';
		print: element
]
