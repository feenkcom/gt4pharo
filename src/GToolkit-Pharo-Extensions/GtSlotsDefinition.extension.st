Extension { #name : 'GtSlotsDefinition' }

{ #category : '*GToolkit-Pharo-Extensions' }
GtSlotsDefinition >> gtSlotsFor: aView [
	<gtView>
	
	self isEmpty
		ifTrue: [ ^ aView empty ].

	^ aView columnedList
		title: 'Slots';
		priority: 1;
		items: [ definitions ];
		column: 'Name' text: [ :eachSlot | eachSlot name ];
		column: 'Type' text: [ :eachSlot | eachSlot type ]
]
