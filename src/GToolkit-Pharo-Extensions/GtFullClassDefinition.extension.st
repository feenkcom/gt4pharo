Extension { #name : #GtFullClassDefinition }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtFullClassDefinition >> gtMethodsFor: aView [
	<gtView>

	^ aView forward
		title: 'Inst. Methods';
		priority: 4;
		object: [ instanceSideDefinition ];
		view: #gtMethodsFor:
]
