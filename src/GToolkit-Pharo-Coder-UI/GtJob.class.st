Class {
	#name : #GtJob,
	#superclass : #Job,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtJob >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]
