"
I am the done-announcement counterpart of {{gtClass:GtMethodRecompiled}}.

I mirror the role of {{gtClass:GtMethodRecompiled}} and I am announced after the original announcement when clients need to know that all work related to that method recompilation is finished.

See also {{gtClass:GtMethodRecompiled}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtMethodRecompiledDone,
	#superclass : #GtMethodAnnouncementDone,
	#instVars : [
		'oldMethod'
	],
	#category : #'GToolkit-Pharo-Index-Announcements'
}

{ #category : #'instance creation' }
GtMethodRecompiledDone class >> methodChangedFrom: oldMethod to: newMethod [
	^ self new
		method: newMethod;
		oldMethod: oldMethod;
		yourself
]

{ #category : #accessing }
GtMethodRecompiledDone >> newMethod [
	^ self method
]

{ #category : #accessing }
GtMethodRecompiledDone >> oldMethod [
	^ oldMethod
]

{ #category : #accessing }
GtMethodRecompiledDone >> oldMethod: anObject [
	oldMethod := anObject
]
