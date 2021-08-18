Class {
	#name : 'GtPharoCoderUnspecifiedBehavior',
	#superclass : 'GtPharoCoderBehavior',
	#category : 'GToolkit-Pharo-Coder-Meta'
}

{ #category : 'comparing' }
GtPharoCoderUnspecifiedBehavior >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : 'transformation' }
GtPharoCoderUnspecifiedBehavior >> affectByClassAdded: aClassAddedAnnouncement [
	^ self
]

{ #category : 'transformation' }
GtPharoCoderUnspecifiedBehavior >> affectByClassRemoved: aClassRemovedAnnouncement [
	^ self
]

{ #category : 'transformation' }
GtPharoCoderUnspecifiedBehavior >> affectByClassRenamed: aClassRenamedAnnouncement [
	^ self
]

{ #category : 'testing' }
GtPharoCoderUnspecifiedBehavior >> affectedByClassAdded: aClassAddedAnnouncement [
	^ false
]

{ #category : 'testing' }
GtPharoCoderUnspecifiedBehavior >> affectedByClassRemoved: aClassRemovedAnnouncement [
	^ false
]

{ #category : 'testing' }
GtPharoCoderUnspecifiedBehavior >> affectedByClassRenamed: aClassRenamedAnnouncement [
	^ false
]

{ #category : 'accessing' }
GtPharoCoderUnspecifiedBehavior >> behaviorNameDo: aBlock [
	^ nil
]

{ #category : 'testing' }
GtPharoCoderUnspecifiedBehavior >> exists [
	"Return true if there is a real Behavior in the system corresponding to my definition"
	<return: #Boolean>
	
	^ false
]

{ #category : 'comparing' }
GtPharoCoderUnspecifiedBehavior >> hash [
	^ self class hash
]

{ #category : 'accessing' }
GtPharoCoderUnspecifiedBehavior >> realBehaviorDo: aBlock [
	^ nil
]
