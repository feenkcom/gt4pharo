"
I am the done-announcement counterpart of {{gtClass:ClassRemoved}}.

I mirror the role of {{gtClass:ClassRemoved}} and can be announced after the original announcement when clients need to know that all work related to that class removal is finished.

See also {{gtClass:ClassRemoved}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtClassRemovedDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'classRemoved'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtClassRemovedDone class >> class: aClass [
	^ self new
		classRemoved: aClass;
		yourself
]

{ #category : #testing }
GtClassRemovedDone >> affectsMethod: aMethod [
	^ classRemoved == aMethod origin
]

{ #category : #testing }
GtClassRemovedDone >> affectsMethods [
	^ true
]

{ #category : #testing }
GtClassRemovedDone >> affectsMethodsDefinedInClass: aClass [
	^ classRemoved == aClass
]

{ #category : #testing }
GtClassRemovedDone >> affectsMethodsDefinedInPackage: aPackage [
	^ self packageAffected == aPackage
]

{ #category : #testing }
GtClassRemovedDone >> affectsMethodsInProtocol: protocol [
	^ classRemoved protocolNames includes: protocol
]

{ #category : #testing }
GtClassRemovedDone >> canAffectResultOfMethodQuery: aMethodQuery [
	^ true
]

{ #category : #accessing }
GtClassRemovedDone >> categoryName [
	self deprecated: 'Use package and tag instead of the category.'.
	^ self packageTagAffected categoryName
]

{ #category : #accessing }
GtClassRemovedDone >> classAffected [
	^ self classRemoved
]

{ #category : #accessing }
GtClassRemovedDone >> classRemoved [
	^ classRemoved
]

{ #category : #accessing }
GtClassRemovedDone >> classRemoved: aClass [
	classRemoved := aClass
]

{ #category : #accessing }
GtClassRemovedDone >> packageTag [
	self deprecated: 'Use #packageTagAffected instead.' transformWith: '`@rcv packageTag' -> '`@rcv packageTagAffected'.
	^ self packageTagAffected
]

{ #category : #accessing }
GtClassRemovedDone >> packagesAffected [
	^ self classRemoved packages
]
