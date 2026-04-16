"
I am the done-announcement counterpart of {{gtClass:MethodRemoved}}.

I mirror the role of {{gtClass:MethodRemoved}} and I am announced after the original announcement when clients need to know that all work related to that method removal is finished.

See also {{gtClass:MethodRemoved}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtMethodRemovedDone,
	#superclass : #GtMethodAnnouncementDone,
	#instVars : [
		'methodOrigin'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtMethodRemovedDone class >> methodRemoved: aCompiledMethod origin: aBehavior [

	^ self new
		  method: aCompiledMethod;
		  methodOrigin: aBehavior;
		  yourself
]

{ #category : #accessing }
GtMethodRemovedDone >> methodOrigin [
	^ methodOrigin
]

{ #category : #accessing }
GtMethodRemovedDone >> methodOrigin: anObject [
	methodOrigin := anObject
]

{ #category : #accessing }
GtMethodRemovedDone >> methodRemoved [

	^ method
]
