Class {
	#name : #GtClassRenamedDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'classRenamed',
		'newName',
		'oldName'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #'instance creation' }
GtClassRenamedDone class >> class: aClass oldName: anOldClassName newName: aNewClassName [

	^ self new
		  classRenamed: aClass;
		  oldName: anOldClassName;
		  newName: aNewClassName;
		  yourself
]

{ #category : #accessing }
GtClassRenamedDone >> classAffected [
	^self classRenamed
]

{ #category : #accessing }
GtClassRenamedDone >> classRenamed [

	^ classRenamed
]

{ #category : #accessing }
GtClassRenamedDone >> classRenamed: anObject [

	classRenamed := anObject
]

{ #category : #accessing }
GtClassRenamedDone >> newName [
	^newName
]

{ #category : #accessing }
GtClassRenamedDone >> newName: anObject [

	newName := anObject
]

{ #category : #accessing }
GtClassRenamedDone >> oldName [
	^oldName
]

{ #category : #accessing }
GtClassRenamedDone >> oldName: anObject [

	oldName := anObject
]

{ #category : #accessing }
GtClassRenamedDone >> packagesAffected [
	^ self classAffected packages
]
