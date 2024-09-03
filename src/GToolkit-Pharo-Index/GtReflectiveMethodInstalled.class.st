Class {
	#name : #GtReflectiveMethodInstalled,
	#superclass : #Announcement,
	#instVars : [
		'oldMethod',
		'newMethod'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtReflectiveMethodInstalled >> newMethod [
	^ newMethod
]

{ #category : #accessing }
GtReflectiveMethodInstalled >> newMethod: anObject [
	newMethod := anObject
]

{ #category : #accessing }
GtReflectiveMethodInstalled >> oldMethod [
	^ oldMethod
]

{ #category : #accessing }
GtReflectiveMethodInstalled >> oldMethod: anObject [
	oldMethod := anObject
]
