Extension { #name : #ShiftClassBuilder }

{ #category : #'*GToolkit-Pharo-Extensions' }
ShiftClassBuilder >> gtViewChangeComparersFor: aView [
	<gtView>
	
	changeComparers ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Change Comparers';
		object: [ changeComparers ];
		view: #gtItemsFor:
]
