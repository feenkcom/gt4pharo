"
I am the done-announcement counterpart of {{gtClass:MethodRepackaged}}.

I mirror the role of {{gtClass:MethodRepackaged}} and I am announced after the original announcement when clients need to know that all work related to that method repackaging is finished.

See also {{gtClass:MethodRepackaged}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtMethodRepackagedDone,
	#superclass : #GtMethodAnnouncementDone,
	#instVars : [
		'newPackage',
		'oldPackage'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtMethodRepackagedDone class >> methodRepackaged: aMethod oldPackage: oldPackage newPackage: newPackage [
	^self new
			method: aMethod;
			oldPackage: oldPackage;
			newPackage: newPackage;
			yourself
]

{ #category : #testing }
GtMethodRepackagedDone >> affectsClassExtension [
	^true
]

{ #category : #testing }
GtMethodRepackagedDone >> affectsClassesExtendedInPackage: aPackage [
	^(super affectsClassesExtendedInPackage: aPackage)
		or: [ oldPackage = aPackage ]
]

{ #category : #testing }
GtMethodRepackagedDone >> affectsMethodsDefinedInPackage: aPackage [
	^(super affectsMethodsDefinedInPackage: aPackage)
		or: [ oldPackage = aPackage ]
]

{ #category : #testing }
GtMethodRepackagedDone >> affectsPackage: aPackage [
	^newPackage == aPackage or: [ oldPackage == aPackage ]
]

{ #category : #accessing }
GtMethodRepackagedDone >> methodRepackaged [

	^ method
]

{ #category : #accessing }
GtMethodRepackagedDone >> newPackage [

	^ newPackage
]

{ #category : #accessing }
GtMethodRepackagedDone >> newPackage: anObject [

	newPackage := anObject
]

{ #category : #accessing }
GtMethodRepackagedDone >> oldPackage [

	^ oldPackage
]

{ #category : #accessing }
GtMethodRepackagedDone >> oldPackage: anObject [

	oldPackage := anObject
]

{ #category : #accessing }
GtMethodRepackagedDone >> packagesAffected [
	^{oldPackage. newPackage}
]
