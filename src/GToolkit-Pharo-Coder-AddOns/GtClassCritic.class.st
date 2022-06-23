Class {
	#name : #GtClassCritic,
	#superclass : #GtCritic,
	#classVars : [
		'ActiveCritics'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtClassCritic class >> activeCritics [
	^ ActiveCritics
		ifNil: [ (self withAllSubclasses
				select: [ :each | each isAbstract not and: [ each isDefault ] ])
				collect: [ :each | each new ] ]
]

{ #category : #accessing }
GtClassCritic class >> gtClassesFor: aView [
	<gtClassView>
	self isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Issues';
		priority: 20;
		object: [ GtSearchClassCriticFilter new
				critic: self new;
				yourself ];
		view: #gtItemsFor:
]

{ #category : #testing }
GtClassCritic class >> isAbstract [
	^ self == GtClassCritic
]
