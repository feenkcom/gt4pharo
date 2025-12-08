Class {
	#name : #GtBinaryCompletionAction,
	#superclass : #GtParenthesizedMessageCompletionAction,
	#category : #'GToolkit-Pharo-Completer-Completion'
}

{ #category : #enumerating }
GtBinaryCompletionAction >> messageAndArgumentNamesDo: aBlock [
	aBlock value: text value: '_'
]
