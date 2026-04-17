"
I am the done-announcement counterpart of {{gtClass:MethodAdded}}.

I mirror the role of {{gtClass:MethodAdded}} and I am announced after the original announcement when clients need to know that all work related to that method addition is finished.

See also {{gtClass:MethodAdded}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtMethodAddedDone,
	#superclass : #GtMethodAnnouncementDone,
	#instVars : [
		'cachedNewSourceCode'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtMethodAddedDone class >> method: aCompiledMethod [
	^self new
		method: aCompiledMethod;
		yourself
]

{ #category : #accessing }
GtMethodAddedDone >> cachedNewSourceCode [
	^ cachedNewSourceCode ifNil: [
		cachedNewSourceCode := self methodAdded sourceCode ]
]

{ #category : #accessing }
GtMethodAddedDone >> methodAdded [
	^ method
]
