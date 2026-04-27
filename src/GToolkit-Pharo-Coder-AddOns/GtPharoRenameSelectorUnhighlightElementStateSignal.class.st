Class {
	#name : #GtPharoRenameSelectorUnhighlightElementStateSignal,
	#superclass : #GtPharoRenameSelectorElementSignal,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #printing }
GtPharoRenameSelectorUnhighlightElementStateSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPutAll: '- Unhighlight state ';
		print: element
]
