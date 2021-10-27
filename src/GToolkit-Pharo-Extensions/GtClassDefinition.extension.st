Extension { #name : #GtClassDefinition }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtClassDefinition >> gtMethodsFor: aView [
	<gtView>

	^ aView forward
		title: 'Methods';
		priority: 5;
		object: [ methods ];
		view: #gtMethodsFor:
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtClassDefinition >> gtSlotsFor: aView [
	<gtView>

	^ aView forward
		title: 'Slots';
		priority: 2;
		object: [ slots ];
		view: #gtSlotsFor:
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtClassDefinition >> gtTraitsFor: aView [
	<gtView>

	^ aView forward
		title: 'Traits';
		priority: 3;
		object: [ traits ];
		view: #gtTraitsFor:
]
