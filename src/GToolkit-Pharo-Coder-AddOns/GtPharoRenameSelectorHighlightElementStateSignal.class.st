Class {
	#name : #GtPharoRenameSelectorHighlightElementStateSignal,
	#superclass : #GtPharoRenameSelectorElementSignal,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #printing }
GtPharoRenameSelectorHighlightElementStateSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPutAll: '+ Highlight state ';
		print: element
]
