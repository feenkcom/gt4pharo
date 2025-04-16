Class {
	#name : #GtBulkChangesAnnouncement,
	#superclass : #SystemAnnouncement,
	#instVars : [
		'changes'
	],
	#category : #'GToolkit-Pharo-Coder-Announcements'
}

{ #category : #accessing }
GtBulkChangesAnnouncement >> changes [
	^ changes
]

{ #category : #accessing }
GtBulkChangesAnnouncement >> changes: anObject [
	changes := anObject
]
