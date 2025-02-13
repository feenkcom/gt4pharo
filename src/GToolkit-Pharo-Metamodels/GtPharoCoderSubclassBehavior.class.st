Class {
	#name : #GtPharoCoderSubclassBehavior,
	#superclass : #GtPharoCoderBehavior,
	#instVars : [
		'coderBehavior',
		'subclassBehavior'
	],
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #comparing }
GtPharoCoderSubclassBehavior >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ subclassBehavior = anObject subclassBehavior and: [ coderBehavior = anObject coderBehavior ]
]

{ #category : #transformation }
GtPharoCoderSubclassBehavior >> affectByClassAdded: aClassAddedAnnouncement [
	^ (self affectedByClassAdded: aClassAddedAnnouncement)
		ifTrue: [ self class new
				subclassBehavior: (subclassBehavior affectByClassAdded: aClassAddedAnnouncement);
				coderBehavior: (coderBehavior affectByClassAdded: aClassAddedAnnouncement);
				yourself ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderSubclassBehavior >> affectByClassRemoved: aClassRemovedAnnouncement [
	^ (self affectedByClassRemoved: aClassRemovedAnnouncement)
		ifTrue: [ self class new
				subclassBehavior: (subclassBehavior affectByClassRemoved: aClassRemovedAnnouncement);
				coderBehavior: (coderBehavior affectByClassRemoved: aClassRemovedAnnouncement);
				yourself ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderSubclassBehavior >> affectByClassRenamed: aClassRenamedAnnouncement [
	^ (self affectedByClassRenamed: aClassRenamedAnnouncement)
		ifTrue: [ self class new
				subclassBehavior: (subclassBehavior affectByClassRenamed: aClassRenamedAnnouncement);
				coderBehavior: (coderBehavior affectByClassRenamed: aClassRenamedAnnouncement);
				yourself ]
		ifFalse: [ self ]
]

{ #category : #testing }
GtPharoCoderSubclassBehavior >> affectedByClassAdded: aClassRemovedAnnouncement [
	^ (subclassBehavior affectedByClassAdded: aClassRemovedAnnouncement)
		or: [ coderBehavior affectedByClassAdded: aClassRemovedAnnouncement ]
]

{ #category : #testing }
GtPharoCoderSubclassBehavior >> affectedByClassRemoved: aClassRemovedAnnouncement [
	^ (subclassBehavior affectedByClassRemoved: aClassRemovedAnnouncement)
		or: [ coderBehavior affectedByClassRemoved: aClassRemovedAnnouncement ]
]

{ #category : #testing }
GtPharoCoderSubclassBehavior >> affectedByClassRenamed: aClassRenamedAnnouncement [
	^ (subclassBehavior affectedByClassRenamed: aClassRenamedAnnouncement)
		or: [ coderBehavior affectedByClassRenamed: aClassRenamedAnnouncement ]
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> asyncSubclasses [
	subclassBehavior
		realBehaviorDo: [ :cls | 
			| upTo |
			coderBehavior realBehaviorDo: [ :spr | upTo := spr ].
			^ AsyncDepthFirstTraversalStream
				root: cls
				children: [ :each | 
					(each superclass isNil or: [ each superclass == upTo ])
						ifTrue: [ #() ]
						ifFalse: [ {each superclass} ] ] ].
	^ super asyncSubclasses
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> behavior [
	^ coderBehavior behavior
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> behaviorNameDo: aBlock [
	^ coderBehavior behaviorNameDo: aBlock
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> coderBehavior [
	^ coderBehavior
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> coderBehavior: anObject [
	coderBehavior := anObject
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> exists [
	^ coderBehavior exists
]

{ #category : #comparing }
GtPharoCoderSubclassBehavior >> hash [
	^ subclassBehavior hash hashMultiply bitXor: coderBehavior hash
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> realBehaviorDo: aBlock [
	coderBehavior realBehaviorDo: aBlock
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> realSubclassBehaviorDo: aBlock [
	subclassBehavior realSubclassBehaviorDo: aBlock
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> subclassBehavior [
	^ subclassBehavior
]

{ #category : #accessing }
GtPharoCoderSubclassBehavior >> subclassBehavior: anObject [
	subclassBehavior := anObject
]
