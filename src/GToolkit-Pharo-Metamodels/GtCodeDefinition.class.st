Class {
	#name : #GtCodeDefinition,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'parent',
		'environment'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'announcer - subscription' }
GtCodeDefinition >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #converting }
GtCodeDefinition >> asDefinitionString [
	^ ''
]

{ #category : #accessing }
GtCodeDefinition >> definition [
	^ self
]

{ #category : #'api - accepting' }
GtCodeDefinition >> differenceWith: aGtCodeDefinition [
	<return: #GtCodeDefinitionDifference>

	^ GtNoDefinitionDifference new
]

{ #category : #'announcer - subscription' }
GtCodeDefinition >> dispatchEvent: anEvent [
	self announcer announce: anEvent.
	parent notNil ifTrue: [ parent dispatchEvent: anEvent ]
]

{ #category : #accessing }
GtCodeDefinition >> environment [
	^ self hasParent
		ifTrue: [ self parent environment ]
		ifFalse: [ environment ifNil: [ GtPharoReadOnlyImageEnvironment uniqueInstance ] ]
]

{ #category : #accessing }
GtCodeDefinition >> environment: anEnvironment [
	self
		assert: [ anEnvironment notNil ]
		description: [ 'Environment must not be nil' ].
		
	self
		assert: [ anEnvironment isKindOf: GtPharoEnvironment ]
		description: [ 'Environment must be a pharo environment' ].

	environment := anEnvironment
]

{ #category : #testing }
GtCodeDefinition >> hasParent [
	<return: #Boolean>

	^ parent isNotNil
]

{ #category : #accessing }
GtCodeDefinition >> name [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtCodeDefinition >> parent [
	^ parent
]

{ #category : #accessing }
GtCodeDefinition >> parent: anObject [
	parent := anObject.
	environment := nil
]

{ #category : #accessing }
GtCodeDefinition >> topMostParent [
	^ self hasParent
		ifTrue: [ self parent topMostParent ]
		ifFalse: [ self ]
]

{ #category : #'announcer - subscription' }
GtCodeDefinition >> when: anEventClass do: aBlock [
	self announcer when: anEventClass do: aBlock
]

{ #category : #'announcer - subscription' }
GtCodeDefinition >> when: anEventClass do: aBlock for: aSubscriber [
	self announcer when: anEventClass do: aBlock for: aSubscriber
]
