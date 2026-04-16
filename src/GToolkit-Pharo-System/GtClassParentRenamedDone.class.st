"
I am the done-announcement counterpart of {{gtClass:ClassParentRenamed}}.

I mirror the role of {{gtClass:ClassParentRenamed}} and can be announced after the original announcement when clients need to know that all work related to that parent rename is finished.

See also {{gtClass:ClassParentRenamed}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtClassParentRenamedDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'classAffected',
		'parentOldName',
		'parentNewName'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtClassParentRenamedDone class >> classParentOf: aClass renamedFrom: oldName to: newName [
	^ self new
		parentOldName: oldName;
		parentNewName: newName;
		classAffected: aClass;
		yourself
]

{ #category : #accessing }
GtClassParentRenamedDone >> classAffected [
	^ classAffected
]

{ #category : #accessing }
GtClassParentRenamedDone >> classAffected: anObject [
	classAffected := anObject
]

{ #category : #accessing }
GtClassParentRenamedDone >> parentNewName [
	^ parentNewName
]

{ #category : #accessing }
GtClassParentRenamedDone >> parentNewName: anObject [
	parentNewName := anObject
]

{ #category : #accessing }
GtClassParentRenamedDone >> parentOldName [
	^ parentOldName
]

{ #category : #accessing }
GtClassParentRenamedDone >> parentOldName: anObject [
	parentOldName := anObject
]
