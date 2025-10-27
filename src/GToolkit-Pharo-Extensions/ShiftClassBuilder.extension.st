Extension { #name : #ShiftClassBuilder }

{ #category : #'*GToolkit-Pharo-Extensions' }
ShiftClassBuilder >> asRingDefinition [
	| ast  rgDefinition |

	rgDefinition := self build asRingDefinition.
	ast := RBParser parseExpression: rgDefinition definitionSource.
	self package ifNotNil: [ :packageName |
		rgDefinition package: (RGPackageDefinition named: packageName).
		ast allChildren detect: [ :child |
				child isMessage and:
				[ child selector = #package: ] ]
			ifFound: [ :child |
				child arguments: { (RBLiteralValueNode value: packageName) } ] ].
	self tag ifNotNil: [ :tagName |
		rgDefinition packageTag: tagName.
		ast allChildren detect: [ :child |
				child isMessage and:
				[ child selector = #tag: ] ]
			ifFound: [ :child |
				child arguments: { (RBLiteralValueNode value: tagName) } ] ].
	rgDefinition definitionSource: ast formattedCode.
	^ rgDefinition
]

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
