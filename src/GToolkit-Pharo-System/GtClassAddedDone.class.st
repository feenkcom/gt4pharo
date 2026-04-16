"
I am the done-announcement counterpart of {{gtClass:ClassAdded}}.

I mirror the role of {{gtClass:ClassAdded}} and can be announced after the original announcement when clients need to know that all work related to that class addition is finished.

See also {{gtClass:ClassAdded}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtClassAddedDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'classAdded'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtClassAddedDone class >> class: aClass [
	^ self new
		classAdded: aClass;
		yourself
]

{ #category : #accessing }
GtClassAddedDone >> classAdded [
	^ classAdded
]

{ #category : #accessing }
GtClassAddedDone >> classAdded: aClass [
	classAdded := aClass
]

{ #category : #accessing }
GtClassAddedDone >> classAffected [
	^ self classAdded
]

{ #category : #accessing }
GtClassAddedDone >> classCategory [
	self deprecated: 'We should not rely on class categories anymore but asking the class for its #package or #packageTag instead.'.
	^ self classAffected category
]
