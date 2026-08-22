Extension { #name : #GtSearchFilter }

{ #category : #'*GToolkit-Pharo-SearchFilters-UI' }
GtSearchFilter >> gtViewFilterCreationCodeFor: aView [
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
					spawnObject: (GtSearchFilterCreationCodeBuilder forSearchFilter: self) ]
]
