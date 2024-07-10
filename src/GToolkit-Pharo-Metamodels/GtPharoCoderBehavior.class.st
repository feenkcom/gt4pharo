Class {
	#name : #GtPharoCoderBehavior,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #'instance creation' }
GtPharoCoderBehavior class >> explicit: aBehavior [
	^ GtPharoCoderExplicitBehavior new behavior: aBehavior
]

{ #category : #'instance creation' }
GtPharoCoderBehavior class >> from: subclass to: implementingClass [
	(subclass == implementingClass
		or: [ subclass == UndefinedObject or: [ subclass == UndefinedObject class ] ])
		ifTrue: [ ^ self explicit: implementingClass ].
	^ GtPharoCoderSubclassBehavior new
		subclassBehavior: (self explicit: subclass);
		coderBehavior: (self explicit: implementingClass);
		yourself
]

{ #category : #'instance creation' }
GtPharoCoderBehavior class >> named: aBehaviorName [
	^ GtPharoCoderNamedBehavior new behaviorName: aBehaviorName
]

{ #category : #'instance creation' }
GtPharoCoderBehavior class >> unspecified [
	^ GtPharoCoderUnspecifiedBehavior new
]

{ #category : #transformation }
GtPharoCoderBehavior >> affectByClassAdded: aClassAddedAnnouncement [
	^ self subclassResponsibility
]

{ #category : #transformation }
GtPharoCoderBehavior >> affectByClassRemoved: aClassRemovedAnnouncement [
	^ self subclassResponsibility
]

{ #category : #transformation }
GtPharoCoderBehavior >> affectByClassRenamed: aClassRenamedAnnouncement [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoCoderBehavior >> affectedByClassAdded: aClassAddedAnnouncement [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoCoderBehavior >> affectedByClassRemoved: aClassRemovedAnnouncement [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoCoderBehavior >> affectedByClassRenamed: aClassRenamedAnnouncement [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoCoderBehavior >> asyncSubclasses [
	^ #() asAsyncStream
]

{ #category : #accessing }
GtPharoCoderBehavior >> behaviorNameDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoCoderBehavior >> behaviorNameDo: aBlock ifAbsent: anAbsentBlock [
	self behaviorNameDo: [ :aBehavior | ^ aBlock value: aBehavior ].
	^ anAbsentBlock value
]

{ #category : #testing }
GtPharoCoderBehavior >> exists [
	"Return true if there is a real Behavior in the system corresponding to my definition"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoCoderBehavior >> realBehaviorDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoCoderBehavior >> realBehaviorDo: aBlock ifAbsent: anAbsentBlock [
	self realBehaviorDo: [ :aBehavior | ^ aBlock value: aBehavior ].
	^ anAbsentBlock value
]
