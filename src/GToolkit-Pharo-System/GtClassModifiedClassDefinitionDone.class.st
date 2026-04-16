"
I am the done-announcement counterpart of {{gtClass:ClassModifiedClassDefinition}}.

I mirror the role of {{gtClass:ClassModifiedClassDefinition}} and can be announced after the original announcement when clients need to know that all work related to that class definition modification is finished.

See also {{gtClass:ClassModifiedClassDefinition}} and {{gtMethod:Announcement>>#gtDoneAnnouncementIn:}}.
"
Class {
	#name : #GtClassModifiedClassDefinitionDone,
	#superclass : #GtClassOperationDoneAnnouncement,
	#instVars : [
		'newClassDefinition',
		'oldClassDefinition'
	],
	#category : #'GToolkit-Pharo-System-Announcements'
}

{ #category : #'instance creation' }
GtClassModifiedClassDefinitionDone class >> classDefinitionChangedFrom: oldClass to: newClass [
	^ self new
		oldClassDefinition: oldClass;
		newClassDefinition: newClass;
		yourself
]

{ #category : #accessing }
GtClassModifiedClassDefinitionDone >> classAffected [
	^ self newClassDefinition
]

{ #category : #accessing }
GtClassModifiedClassDefinitionDone >> newClassDefinition [
	^ newClassDefinition
]

{ #category : #accessing }
GtClassModifiedClassDefinitionDone >> newClassDefinition: aClass [
	newClassDefinition := aClass
]

{ #category : #accessing }
GtClassModifiedClassDefinitionDone >> oldClassDefinition [
	^ oldClassDefinition
]

{ #category : #accessing }
GtClassModifiedClassDefinitionDone >> oldClassDefinition: aClass [
	oldClassDefinition := aClass
]

{ #category : #testing }
GtClassModifiedClassDefinitionDone >> shouldBeConsideredByCalypsoEnvironment [
	^ false
]
