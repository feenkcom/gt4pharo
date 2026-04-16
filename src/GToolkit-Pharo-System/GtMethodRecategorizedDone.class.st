"
I am the done-announcement counterpart of {{gtClass:MethodRecategorized}}.

I mirror the role of {{gtClass:MethodRecategorized}} and I am announced after the original announcement when clients need to know that all work related to that method recategorization is finished.

See also {{gtClass:MethodRecategorized}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtMethodRecategorizedDone,
	#superclass : #GtMethodAnnouncementDone,
	#instVars : [
		'oldProtocol'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtMethodRecategorizedDone class >> method: aCompiledMethod oldProtocol: anOldProtocol [

	^self new
		method: aCompiledMethod;
		oldProtocol: anOldProtocol;
		yourself
]

{ #category : #testing }
GtMethodRecategorizedDone >> affectsMethodsInProtocol: protocol [

	^ (super affectsMethodsInProtocol: protocol) or: [ self oldProtocol name = protocol ]
]

{ #category : #accessing }
GtMethodRecategorizedDone >> methodRecategorized [

	^ method
]

{ #category : #accessing }
GtMethodRecategorizedDone >> newProtocol [

	^ self protocol
]

{ #category : #accessing }
GtMethodRecategorizedDone >> oldProtocol [

	^ oldProtocol
]

{ #category : #accessing }
GtMethodRecategorizedDone >> oldProtocol: anObject [

	oldProtocol := anObject
]

{ #category : #accessing }
GtMethodRecategorizedDone >> protocolsAffected [
	^{self newProtocol. self oldProtocol}
]

{ #category : #testing }
GtMethodRecategorizedDone >> shouldBeConsideredByCalypsoEnvironment [
	oldProtocol isSymbol
		ifTrue: [ ^ false ].
	^ (oldProtocol isExtensionProtocol and: [ self newProtocol isNotNil and: [ self newProtocol isUnclassifiedProtocol ] ]) not
]
