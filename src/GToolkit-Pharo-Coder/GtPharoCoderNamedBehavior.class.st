Class {
	#name : #GtPharoCoderNamedBehavior,
	#superclass : #GtPharoCoderBehavior,
	#instVars : [
		'behaviorName',
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Meta'
}

{ #category : #comparing }
GtPharoCoderNamedBehavior >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ behaviorName = anObject behaviorName
]

{ #category : #transformation }
GtPharoCoderNamedBehavior >> affectByClassAdded: aClassAddedAnnouncement [
	^ behaviorName = aClassAddedAnnouncement classAdded name
		ifTrue: [ self class explicit: aClassAddedAnnouncement classAdded ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderNamedBehavior >> affectByClassRemoved: aClassRemovedAnnouncement [
	^ behavior = aClassRemovedAnnouncement classRemoved
		ifTrue: [ self ]
		ifFalse: [ self class new behaviorName: behaviorName ]
]

{ #category : #transformation }
GtPharoCoderNamedBehavior >> affectByClassRenamed: aClassRenamedAnnouncement [
	^ aClassRenamedAnnouncement oldName = self behaviorName
		ifTrue: [ self class new behaviorName: aClassRenamedAnnouncement newName ]
		ifFalse: [ self ]
]

{ #category : #testing }
GtPharoCoderNamedBehavior >> affectedByClassAdded: aClassAddedAnnouncement [
	^ self behaviorName = aClassAddedAnnouncement classAdded name
]

{ #category : #testing }
GtPharoCoderNamedBehavior >> affectedByClassRemoved: aClassRemovedAnnouncement [
	^ behavior
		ifNil: [ false ]
		ifNotNil: [ behavior = aClassRemovedAnnouncement classRemoved ]
]

{ #category : #testing }
GtPharoCoderNamedBehavior >> affectedByClassRenamed: aClassRenamedAnnouncement [
	^ self behaviorName = aClassRenamedAnnouncement oldName
]

{ #category : #accessing }
GtPharoCoderNamedBehavior >> behavior [
	^ behavior
]

{ #category : #accessing }
GtPharoCoderNamedBehavior >> behaviorName [
	^ behaviorName
]

{ #category : #accessing }
GtPharoCoderNamedBehavior >> behaviorName: aBehaviorName [
	self
		assert: [ behaviorName isNil ]
		description: [ 'I am immutable and can not be changed' ].

	behaviorName := aBehaviorName asSymbol.
	
	behavior := self class environment
		at: behaviorName
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPharoCoderNamedBehavior >> behaviorNameDo: aBlock [
	^ aBlock value: self behaviorName
]

{ #category : #testing }
GtPharoCoderNamedBehavior >> exists [
	"Return true if there is a real Behavior in the system corresponding to my definition"
	<return: #Boolean>
	
	^ self class environment includesKey: self behaviorName
]

{ #category : #comparing }
GtPharoCoderNamedBehavior >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ behaviorName hash
]

{ #category : #accessing }
GtPharoCoderNamedBehavior >> realBehaviorDo: aBlock [
	^ self class environment
		at: self behaviorName
		ifPresent: aBlock
		ifAbsent: [ nil ]
]
