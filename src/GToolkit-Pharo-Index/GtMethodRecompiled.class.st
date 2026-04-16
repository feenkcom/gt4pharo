Class {
	#name : #GtMethodRecompiled,
	#superclass : #MethodAnnouncement,
	#instVars : [
		'oldMethod'
	],
	#category : #'GToolkit-Pharo-Index-Announcements'
}

{ #category : #'instance creation' }
GtMethodRecompiled class >> methodChangedFrom: oldMethod to: newMethod [
	^ self new
		method: newMethod;
		oldMethod: oldMethod;
		yourself
]

{ #category : #'done announcements' }
GtMethodRecompiled >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodRecompiledDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass methodChangedFrom: self oldMethod to: self newMethod) ]
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
