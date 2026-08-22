Extension { #name : #GtSearchFilterCreationCodeBuilder }

{ #category : #'*GToolkit-Pharo-SearchFilters-UI' }
GtSearchFilterCreationCodeBuilder >> gtViewFilterCreationCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Creation code';
		priority: 90;
		object: [ self creationCode ];
		view: #gtViewFilterCreationCodeFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect code builder' 
			action: [ :aButton |
				aButton phlow 
					spawnObject: (self creationCode) ]
]
