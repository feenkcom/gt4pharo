Class {
	#name : #GtRenameSelectorMoved,
	#superclass : #Announcement,
	#instVars : [
		'keyword',
		'forward'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRenameSelectorMoved >> forward [
	^ forward
]

{ #category : #accessing }
GtRenameSelectorMoved >> forward: aBoolean [
	forward := aBoolean
]

{ #category : #accessing }
GtRenameSelectorMoved >> keyword [
	^ keyword
]

{ #category : #accessing }
GtRenameSelectorMoved >> keyword: anInteger [
	keyword := anInteger
]
