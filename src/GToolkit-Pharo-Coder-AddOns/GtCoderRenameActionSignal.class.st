Class {
	#name : #GtCoderRenameActionSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'action'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtCoderRenameActionSignal >> action [
	^ action
]

{ #category : #accessing }
GtCoderRenameActionSignal >> action: anObject [
	action := anObject
]
