Extension { #name : #GtSearchFilterCreationCode }

{ #category : #'*GToolkit-Pharo-SearchFilters-UI' }
GtSearchFilterCreationCode >> gtViewFilterCreationCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Code';
		priority: 90;
		object: [ LePharoSnippet code: codeString ];
		view: #gtLiveFor:
]
