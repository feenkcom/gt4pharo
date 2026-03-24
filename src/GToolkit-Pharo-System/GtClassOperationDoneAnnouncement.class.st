Class {
	#name : #GtClassOperationDoneAnnouncement,
	#superclass : #SystemAnnouncement,
	#category : #'GToolkit-Pharo-System'
}

{ #category : #accessing }
GtClassOperationDoneAnnouncement >> classAffected [
	self subclassResponsibility
]

{ #category : #printing }
GtClassOperationDoneAnnouncement >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream 
		parenthesize: [
			aStream << self classAffected name ]
]

{ #category : #accessing }
GtClassOperationDoneAnnouncement >> packageAffected [
	^self classAffected package
]

{ #category : #accessing }
GtClassOperationDoneAnnouncement >> packageTagAffected [

	^ self classAffected packageTag
]

{ #category : #accessing }
GtClassOperationDoneAnnouncement >> packageTagsAffected [

	^ { self packageTagAffected }
]

{ #category : #accessing }
GtClassOperationDoneAnnouncement >> packagesAffected [
	^{self packageAffected}
]
