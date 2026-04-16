"
I am the done-announcement counterpart of {{gtClass:ClassCommented}}.

I mirror the role of {{gtClass:ClassCommented}} and can be announced after the original announcement when clients need to know that all work related to that class comment change is finished.

See also {{gtClass:ClassCommented}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtClassCommentedDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'newStamp',
		'newComment',
		'classCommented',
		'oldComment',
		'oldStamp'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtClassCommentedDone class >> class: aClass oldComment: oldComment newComment: newComment oldStamp: oldStamp newStamp: newStamp [
	^ self new
		classCommented: aClass;
		oldComment: oldComment;
		oldStamp: oldStamp;
		newComment: newComment;
		newStamp: newStamp;
		yourself
]

{ #category : #'instance creation' }
GtClassCommentedDone class >> classCommented: aClass [
	self flag: #pharoFixMe.
	^ self class: aClass oldComment: nil newComment: nil oldStamp: nil newStamp: nil
]

{ #category : #accessing }
GtClassCommentedDone >> classAffected [
	^ self classCommented
]

{ #category : #accessing }
GtClassCommentedDone >> classCommented [
	^ classCommented
]

{ #category : #accessing }
GtClassCommentedDone >> classCommented: aClass [
	classCommented := aClass
]

{ #category : #accessing }
GtClassCommentedDone >> newComment [
	^ newComment
]

{ #category : #accessing }
GtClassCommentedDone >> newComment: aNewComment [
	newComment := aNewComment
]

{ #category : #accessing }
GtClassCommentedDone >> newStamp [
	^ newStamp
]

{ #category : #accessing }
GtClassCommentedDone >> newStamp: aNewStamp [
	newStamp := aNewStamp
]

{ #category : #accessing }
GtClassCommentedDone >> oldComment [
	^ oldComment
]

{ #category : #accessing }
GtClassCommentedDone >> oldComment: anOldComment [
	oldComment := anOldComment
]

{ #category : #accessing }
GtClassCommentedDone >> oldStamp [
	^ oldStamp
]

{ #category : #accessing }
GtClassCommentedDone >> oldStamp: anOldStamp [
	oldStamp := anOldStamp
]
