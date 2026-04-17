"
I am the done-announcement counterpart of {{gtClass:ClassModificationApplied}}.

I mirror the role of {{gtClass:ClassModificationApplied}} and can be announced after the original announcement when clients need to know that all work related to that applied class modification is finished.

See also {{gtClass:ClassModificationApplied}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtClassModificationAppliedDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'modifiedClass'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtClassModificationAppliedDone class >> toClass: aClassOrTrait [
	^ self new
		modifiedClass: aClassOrTrait
]

{ #category : #testing }
GtClassModificationAppliedDone >> affectsMethod: aMethod [
	^ self classAffected == aMethod origin
]

{ #category : #testing }
GtClassModificationAppliedDone >> affectsVariablesOf: aClass [
	aClass instanceSide = modifiedClass instanceSide ifTrue: [ ^ true ].
	^ false
]

{ #category : #accessing }
GtClassModificationAppliedDone >> classAffected [
	^ modifiedClass
]

{ #category : #accessing }
GtClassModificationAppliedDone >> modifiedClass: anObject [
	modifiedClass := anObject
]
