"
I am the done-announcement counterpart of {{gtClass:GtClassRecompiled}}.

I mirror the role of {{gtClass:GtClassRecompiled}} and can be announced after the original announcement when clients need to know that all work related to that class recompilation is finished.

See also {{gtClass:GtClassRecompiled}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtClassRecompiledDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'classAffected'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #accessing }
GtClassRecompiledDone >> classAffected [
	^ classAffected
]

{ #category : #accessing }
GtClassRecompiledDone >> classAffected: aClass [
	classAffected := aClass
]
