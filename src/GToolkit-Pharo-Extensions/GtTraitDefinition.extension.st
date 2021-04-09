Extension { #name : #GtTraitDefinition }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtTraitDefinition >> gtMethodsFor: aView [
	<gtView>

	methods ifNil: [ ^ aView empty ].
	methods isEmpty ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Methods';
		priority: 2;
		object: [ methods ];
		view: #gtMethodsFor:
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtTraitDefinition >> gtSlotsFor: aView [
	<gtView>

	slots isEmpty ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Slots';
		priority: 2;
		object: [ slots ];
		view: #gtSlotsFor:
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtTraitDefinition >> gtTraitsFor: aView [
	<gtView>
	
	traits isEmpty ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Traits';
		priority: 3;
		object: [ traits ];
		view: #gtTraitsFor:
]
