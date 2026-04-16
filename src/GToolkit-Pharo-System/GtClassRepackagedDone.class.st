"
I am the done-announcement counterpart of {{gtClass:ClassRepackaged}}.

I mirror the role of {{gtClass:ClassRepackaged}} and can be announced after the original announcement when clients need to know that all work related to that class repackaging is finished.

See also {{gtClass:ClassRepackaged}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtClassRepackagedDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'classRepackaged',
		'oldTag',
		'newTag'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtClassRepackagedDone class >> classRepackaged: aClass oldTag: oldTag newTag: newTag [
	^ self new
		classRepackaged: aClass;
		oldTag: oldTag;
		newTag: newTag;
		yourself
]

{ #category : #testing }
GtClassRepackagedDone >> affectsMethods [
	^ true
]

{ #category : #testing }
GtClassRepackagedDone >> affectsMethodsDefinedInClass: aClass [
	^ classRepackaged == aClass
]

{ #category : #testing }
GtClassRepackagedDone >> affectsMethodsDefinedInPackage: aPackage [
	^ self oldPackage == aPackage or: [ self newPackage == aPackage ]
]

{ #category : #testing }
GtClassRepackagedDone >> affectsMethodsInProtocol: protocol [
	^ classRepackaged protocolNames includes: protocol
]

{ #category : #testing }
GtClassRepackagedDone >> canAffectResultOfMethodQuery: aMethodQuery [
	^ true
]

{ #category : #accessing }
GtClassRepackagedDone >> classAffected [
	^ classRepackaged
]

{ #category : #accessing }
GtClassRepackagedDone >> classRecategorized [
	self deprecated: 'Use #classRepackaged instead.' transformWith: '`@rcv classRecategorized' -> '`@rcv classRepackaged'.
	^ self classRepackaged
]

{ #category : #accessing }
GtClassRepackagedDone >> classRepackaged [
	^ classRepackaged
]

{ #category : #accessing }
GtClassRepackagedDone >> classRepackaged: anObject [
	classRepackaged := anObject
]

{ #category : #accessing }
GtClassRepackagedDone >> newCategory [
	self deprecated: 'Manipulated the tag and not the category.'.
	^ self newTag categoryName
]

{ #category : #accessing }
GtClassRepackagedDone >> newPackage [
	^ self newTag package
]

{ #category : #accessing }
GtClassRepackagedDone >> newTag [
	^ newTag
]

{ #category : #accessing }
GtClassRepackagedDone >> newTag: anObject [
	newTag := anObject
]

{ #category : #accessing }
GtClassRepackagedDone >> oldCategory [
	self deprecated: 'Manipulated the tag and not the category.'.
	^ self oldTag categoryName
]

{ #category : #accessing }
GtClassRepackagedDone >> oldPackage [
	^ self oldTag package
]

{ #category : #accessing }
GtClassRepackagedDone >> oldTag [
	^ oldTag
]

{ #category : #accessing }
GtClassRepackagedDone >> oldTag: anObject [
	oldTag := anObject
]

{ #category : #accessing }
GtClassRepackagedDone >> packageTagsAffected [
	^ { self newTag. self oldTag }
]

{ #category : #testing }
GtClassRepackagedDone >> packagedChanged [
	^ self oldPackage ~= self newPackage
]

{ #category : #accessing }
GtClassRepackagedDone >> packagesAffected [
	^ { self oldPackage. self newPackage }
]
