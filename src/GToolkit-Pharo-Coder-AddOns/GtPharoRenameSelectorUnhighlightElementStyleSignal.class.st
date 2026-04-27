Class {
	#name : #GtPharoRenameSelectorUnhighlightElementStyleSignal,
	#superclass : #GtPharoRenameSelectorElementSignal,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #printing }
GtPharoRenameSelectorUnhighlightElementStyleSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPutAll: '- Unhighlight ';
		print: element
]
