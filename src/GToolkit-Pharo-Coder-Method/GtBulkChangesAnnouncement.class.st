Class {
	#name : #GtBulkChangesAnnouncement,
	#superclass : #SystemAnnouncement,
	#instVars : [
		'changes'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Announcements'
}

{ #category : #accessing }
GtBulkChangesAnnouncement >> changes [
	^ changes
]

{ #category : #accessing }
GtBulkChangesAnnouncement >> changes: anObject [
	changes := anObject
]
