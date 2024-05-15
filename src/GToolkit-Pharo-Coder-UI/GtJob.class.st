Class {
	#name : #GtJob,
	#superclass : #Job,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtJob >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtJob >> announcer: anAnnouncer [ 
	announcer := anAnnouncer
]
