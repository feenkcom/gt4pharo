Class {
	#name : #GtPharoCoderExplicitBehavior,
	#superclass : #GtPharoCoderBehavior,
	#instVars : [
		'behavior',
		'behaviorName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #comparing }
GtPharoCoderExplicitBehavior >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ behavior = anObject behavior
]

{ #category : #transformation }
GtPharoCoderExplicitBehavior >> affectByClassAdded: aClassAddedAnnouncement [
	^ (self affectedByClassAdded: aClassAddedAnnouncement)
		ifTrue: [ self class new behavior: aClassAddedAnnouncement classAdded ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderExplicitBehavior >> affectByClassRemoved: aClassRemovedAnnouncement [
	^ (self behavior = aClassRemovedAnnouncement classRemoved
		or: [ self behavior = aClassRemovedAnnouncement classRemoved class ])
		ifTrue: [ self class named: behaviorName ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderExplicitBehavior >> affectByClassRenamed: aClassRenamedAnnouncement [
	^ self behavior = aClassRenamedAnnouncement classRenamed
		ifTrue: [ self class new behavior: aClassRenamedAnnouncement classRenamed ]
		ifFalse: [ self ]
]

{ #category : #testing }
GtPharoCoderExplicitBehavior >> affectedByClassAdded: aClassRemovedAnnouncement [
	^ self behavior = aClassRemovedAnnouncement classAdded
		or: [ self behaviorName = aClassRemovedAnnouncement classAdded name ]
]

{ #category : #testing }
GtPharoCoderExplicitBehavior >> affectedByClassRemoved: aClassRemovedAnnouncement [
	^ self behavior = aClassRemovedAnnouncement classRemoved
		or: [ self behavior = aClassRemovedAnnouncement classRemoved class ]
]

{ #category : #testing }
GtPharoCoderExplicitBehavior >> affectedByClassRenamed: aClassRenamedAnnouncement [
	^ self behavior = aClassRenamedAnnouncement classRenamed
]

{ #category : #accessing }
GtPharoCoderExplicitBehavior >> behavior [
	^ behavior
]

{ #category : #accessing }
GtPharoCoderExplicitBehavior >> behavior: aBehavior [
	self
		assert: [ behavior isNil ]
		description: [ 'I am immutable and can not be changed' ].

	behavior := aBehavior.
	aBehavior ifNotNil: [ behaviorName := aBehavior name ]
]

{ #category : #accessing }
GtPharoCoderExplicitBehavior >> behaviorName [
	^ behaviorName
]

{ #category : #accessing }
GtPharoCoderExplicitBehavior >> behaviorNameDo: aBlock [
	^ self exists
		ifTrue: [ aBlock value: behavior name ]
		ifFalse: [
			behaviorName
				ifNotNil: [ :aName | aBlock value: aName ]
				ifNil: [ nil ] ]
]

{ #category : #testing }
GtPharoCoderExplicitBehavior >> exists [
	"Return true if there is a real Behavior in the system corresponding to my definition"
	<return: #Boolean>
	
	^ self behavior notNil and: [ self behavior isObsolete not ]
]

{ #category : #comparing }
GtPharoCoderExplicitBehavior >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ behavior hash
]

{ #category : #accessing }
GtPharoCoderExplicitBehavior >> realBehaviorDo: aBlock [
	^ self exists
		ifTrue: [ aBlock value: self behavior ]
		ifFalse: [ nil ]
]
