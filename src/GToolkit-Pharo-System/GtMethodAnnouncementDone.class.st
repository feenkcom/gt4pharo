"
I am the done-announcement counterpart of {{gtClass:MethodAnnouncement}}.

I mirror the role of {{gtClass:MethodAnnouncement}} and exist so clients can announce me after the original announcement when they need to know that all work triggered by the original announcement is finished.

See also {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtMethodAnnouncementDone,
	#superclass : #SystemAnnouncement,
	#instVars : [
		'method'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #testing }
GtMethodAnnouncementDone >> affectsClassExtension [
	^self methodAffected isExtension
]

{ #category : #testing }
GtMethodAnnouncementDone >> affectsClassesExtendedInPackage: aPackage [
	^ self isProvidedByExtension and: [ self affectsMethodsDefinedInPackage: aPackage ]
]

{ #category : #testing }
GtMethodAnnouncementDone >> affectsMethod: aMethod [
	^self methodAffected == aMethod
]

{ #category : #testing }
GtMethodAnnouncementDone >> affectsMethods [
	^true
]

{ #category : #testing }
GtMethodAnnouncementDone >> affectsMethodsDefinedInClass: aClass [
	^ self classAffected == aClass
]

{ #category : #testing }
GtMethodAnnouncementDone >> affectsMethodsDefinedInPackage: aPackage [
	^self methodPackage == aPackage or: [ self methodAffected package == aPackage ]
]

{ #category : #testing }
GtMethodAnnouncementDone >> affectsMethodsInProtocol: protocol [

	^ method protocolName == protocol
]

{ #category : #testing }
GtMethodAnnouncementDone >> affectsPackages [
	^true
]

{ #category : #testing }
GtMethodAnnouncementDone >> canAffectResultOfMethodQuery: aMethodQuery [

	^aMethodQuery isAffectedByChangedMethod: self methodAffected
]

{ #category : #accessing }
GtMethodAnnouncementDone >> classAffected [
	^ self methodOrigin
]

{ #category : #testing }
GtMethodAnnouncementDone >> isProvidedByExtension [
	^self methodOrigin package ~= self methodPackage
]

{ #category : #accessing }
GtMethodAnnouncementDone >> method [

	^ method
]

{ #category : #accessing }
GtMethodAnnouncementDone >> method: aCompiledMethod [
	method := aCompiledMethod
]

{ #category : #accessing }
GtMethodAnnouncementDone >> methodAffected [
	^self method
]

{ #category : #accessing }
GtMethodAnnouncementDone >> methodClass [
	^ method methodClass
]

{ #category : #accessing }
GtMethodAnnouncementDone >> methodOrigin [
	^ method origin
]

{ #category : #accessing }
GtMethodAnnouncementDone >> methodPackage [

	^ method package
]

{ #category : #accessing }
GtMethodAnnouncementDone >> packagesAffected [
	^{self methodPackage}
]

{ #category : #accessing }
GtMethodAnnouncementDone >> protocol [

	^ method protocol
]

{ #category : #accessing }
GtMethodAnnouncementDone >> protocolsAffected [
	^{self protocol}
]

{ #category : #accessing }
GtMethodAnnouncementDone >> selector [

	^ method selector
]
