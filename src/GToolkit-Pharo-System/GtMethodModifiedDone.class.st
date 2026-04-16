"
I am the done-announcement counterpart of {{gtClass:MethodModified}}.

I mirror the role of {{gtClass:MethodModified}} and I am announced after the original announcement when clients need to know that all work related to that method modification is finished.

See also {{gtClass:MethodModified}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtMethodModifiedDone,
	#superclass : #GtMethodAnnouncementDone,
	#instVars : [
		'oldMethod',
		'oldProtocol',
		'cachedNewSourceCode',
		'cachedOldSourceCode'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtMethodModifiedDone class >> methodChangedFrom: oldMethod to: newMethod oldProtocol: oldProtocol [
	^ self new
		method: newMethod;
		oldMethod: oldMethod;
		oldProtocol: oldProtocol;
		yourself
]

{ #category : #testing }
GtMethodModifiedDone >> affectsMethod: aMethod [
	^(super affectsMethod: aMethod) or: [oldMethod == aMethod]
]

{ #category : #testing }
GtMethodModifiedDone >> affectsMethodsDefinedInPackage: aPackage [

	^(super affectsMethodsDefinedInPackage: aPackage) or: [
		oldMethod package == aPackage ]
]

{ #category : #testing }
GtMethodModifiedDone >> affectsMethodsInProtocol: protocol [

	^ (super affectsMethodsInProtocol: protocol) or: [ self oldProtocol name = protocol ]
]

{ #category : #accessing }
GtMethodModifiedDone >> cachedNewSourceCode [
	^ cachedNewSourceCode ifNil: [
		cachedNewSourceCode := self newMethod sourceCode ]
]

{ #category : #accessing }
GtMethodModifiedDone >> cachedOldSourceCode [
	^ cachedOldSourceCode ifNil: [
		cachedOldSourceCode := self oldMethod sourceCode]
]

{ #category : #testing }
GtMethodModifiedDone >> canAffectResultOfMethodQuery: aMethodQuery [

	^(aMethodQuery isAffectedByChangedMethod: self oldMethod)
		or: [ aMethodQuery isAffectedByChangedMethod: self newMethod]
]

{ #category : #accessing }
GtMethodModifiedDone >> newMethod [

	^ method
]

{ #category : #accessing }
GtMethodModifiedDone >> newProtocol [

	^ self protocol
]

{ #category : #accessing }
GtMethodModifiedDone >> oldMethod [
	^ oldMethod
]

{ #category : #accessing }
GtMethodModifiedDone >> oldMethod: aCompiledMethod [
	oldMethod := aCompiledMethod
]

{ #category : #accessing }
GtMethodModifiedDone >> oldProtocol [

	^ oldProtocol
]

{ #category : #accessing }
GtMethodModifiedDone >> oldProtocol: anObject [

	oldProtocol := anObject
]
