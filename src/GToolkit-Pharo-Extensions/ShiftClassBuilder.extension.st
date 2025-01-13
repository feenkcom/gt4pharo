Extension { #name : #ShiftClassBuilder }

{ #category : #'*GToolkit-Pharo-Extensions' }
ShiftClassBuilder >> gtFillFor: aClass [
	self
		superclass: aClass superclass;
		name: aClass getName;
		layoutClass: aClass classLayout class;
		slots: (aClass localSlots collect: [:var | var copy]);
		classSlots: (aClass class localSlots collect: [:var | var copy]);
		sharedVariables: (aClass classVariables collect: [:var | var copy]);
		sharedPools: aClass sharedPoolsString;
		category: aClass category;
		environment: aClass environment;
		oldClass: aClass.

	self builderEnhancer fillBuilder: self from: aClass
]

{ #category : #'*GToolkit-Pharo-Extensions' }
ShiftClassBuilder >> gtViewChangeComparersFor: aView [
	<gtView>
	
	changeComparers ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Change Comparers';
		object: [ changeComparers ];
		view: #gtItemsFor:
]
