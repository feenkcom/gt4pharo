Class {
	#name : #GtMethodRecompiled,
	#superclass : #MethodAnnouncement,
	#instVars : [
		'oldMethod'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #'instance creation' }
GtMethodRecompiled class >> methodChangedFrom: oldMethod to: newMethod [
	^ self new
		method: newMethod;
		oldMethod: oldMethod;
		yourself
]

{ #category : #accessing }
GtMethodRecompiled >> newMethod [
	^ self method
]

{ #category : #accessing }
GtMethodRecompiled >> oldMethod [
	^ oldMethod
]

{ #category : #accessing }
GtMethodRecompiled >> oldMethod: anObject [
	oldMethod := anObject
]
