Class {
	#name : #GtPharoCoderNamedClassBehavior,
	#superclass : #GtPharoCoderBehavior,
	#instVars : [
		'behaviorName',
		'behavior'
	],
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #comparing }
GtPharoCoderNamedClassBehavior >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ behaviorName = anObject behaviorName
]

{ #category : #transformation }
GtPharoCoderNamedClassBehavior >> affectByClassAdded: aClassAddedAnnouncement [
	^ behaviorName = aClassAddedAnnouncement classAdded name
		ifTrue: [ self class explicit: aClassAddedAnnouncement classAdded class ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderNamedClassBehavior >> affectByClassRemoved: aClassRemovedAnnouncement [
	^ behavior = aClassRemovedAnnouncement classRemoved
		ifTrue: [ self ]
		ifFalse: [ self class new behaviorName: behaviorName ]
]

{ #category : #transformation }
GtPharoCoderNamedClassBehavior >> affectByClassRenamed: aClassRenamedAnnouncement [
	^ aClassRenamedAnnouncement oldName = self behaviorName
		ifTrue: [ self class new behaviorName: aClassRenamedAnnouncement newName ]
		ifFalse: [ self ]
]

{ #category : #testing }
GtPharoCoderNamedClassBehavior >> affectedByClassAdded: aClassAddedAnnouncement [
	^ self behaviorName = aClassAddedAnnouncement classAdded name
]

{ #category : #testing }
GtPharoCoderNamedClassBehavior >> affectedByClassRemoved: aClassRemovedAnnouncement [
	^ behavior
		ifNil: [ false ]
		ifNotNil: [ behavior = aClassRemovedAnnouncement classRemoved ]
]

{ #category : #testing }
GtPharoCoderNamedClassBehavior >> affectedByClassRenamed: aClassRenamedAnnouncement [
	^ self behaviorName = aClassRenamedAnnouncement oldName
]

{ #category : #accessing }
GtPharoCoderNamedClassBehavior >> behavior [
	^ behavior
]

{ #category : #accessing }
GtPharoCoderNamedClassBehavior >> behaviorName [
	^ behaviorName
]

{ #category : #accessing }
GtPharoCoderNamedClassBehavior >> behaviorName: aBehaviorName [
	self
		assert: [ behaviorName isNil ]
		description: [ 'I am immutable and can not be changed' ].

	behaviorName := aBehaviorName asSymbol.
	
	behavior := self class environment
		at: behaviorName
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPharoCoderNamedClassBehavior >> behaviorNameDo: aBlock [
	^ aBlock value: self behaviorName, ' class'
]

{ #category : #testing }
GtPharoCoderNamedClassBehavior >> exists [
	"Return true if there is a real Behavior in the system corresponding to my definition"
	<return: #Boolean>
	
	^ self class environment includesKey: self behaviorName
]

{ #category : #comparing }
GtPharoCoderNamedClassBehavior >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ behaviorName hash
]

{ #category : #accessing }
GtPharoCoderNamedClassBehavior >> realBehaviorDo: aBlock [
	^ self class environment
		at: self behaviorName
		ifPresent: [ :aClass | aBlock value: aClass class ]
		ifAbsent: [ nil ]
]
