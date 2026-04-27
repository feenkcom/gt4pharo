Class {
	#name : #GtPharoRenameSelectorHighlightElementStyleSignal,
	#superclass : #GtPharoRenameSelectorElementSignal,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #printing }
GtPharoRenameSelectorHighlightElementStyleSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPutAll: '+ Highlight style ';
		print: element
]
