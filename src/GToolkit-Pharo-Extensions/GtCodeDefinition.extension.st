Extension { #name : #GtCodeDefinition }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtCodeDefinition >> gtDefinitionFor: aView [
	<gtView>

	^ aView textEditor
		title: 'Definition';
		priority: 1;
		text: [ self asDefinitionString ]
]
