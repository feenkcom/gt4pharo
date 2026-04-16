"
I am the done-announcement counterpart of {{gtClass:GtReflectiveMethodInstalled}}.

I mirror the role of {{gtClass:GtReflectiveMethodInstalled}} and can be announced after the original announcement when clients need to know that all work related to that reflective method installation is finished.

See also {{gtClass:GtReflectiveMethodInstalled}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtReflectiveMethodInstalledDone,
	#superclass : #Announcement,
	#instVars : [
		'oldMethod',
		'newMethod'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #testing }
GtReflectiveMethodInstalledDone >> affectsMethod: aMethod [
	^ self newMethod == aMethod or: [ self oldMethod == aMethod ]
]

{ #category : #testing }
GtReflectiveMethodInstalledDone >> affectsMethodsDefinedInClass: aClass [
	^ self newMethod methodClass = aClass
		or: [ self oldMethod methodClass = aClass ]
]

{ #category : #accessing }
GtReflectiveMethodInstalledDone >> newMethod [
	^ newMethod
]

{ #category : #accessing }
GtReflectiveMethodInstalledDone >> newMethod: anObject [
	newMethod := anObject
]

{ #category : #accessing }
GtReflectiveMethodInstalledDone >> oldMethod [
	^ oldMethod
]

{ #category : #accessing }
GtReflectiveMethodInstalledDone >> oldMethod: anObject [
	oldMethod := anObject
]
