Class {
	#name : #GtCreateClassExpanderAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'action',
		'definition'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtCreateClassExpanderAttribute >> action [
	^ action
]

{ #category : #accessing }
GtCreateClassExpanderAttribute >> action: createClassAction [
	action := createClassAction
]

{ #category : #accessing }
GtCreateClassExpanderAttribute >> buildClassDefinition [
	| element |
	element := BrHorizontalGrid new
			hMatchParent;
			vFitContent;
			columnCount: 2;
			background: Color white;
			padding: (BlInsets all: 4);
			aptitude: BrShadowAptitude;
			addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
							foreground: Color gray;
							fontSize: 12);
					text: 'Superclass:';
					focusability: BlFocusability none;
					margin: (BlInsets top: 5 right: 2);
					constraintsDo: [ :c | c grid horizontal alignLeft ]);
			addChild: (GtCodeDefinitionSingleEditor new
					definition: definition superclass;
					title: 'Superclass';
					getSelector: #name;
					setSelector: #name:;
					renameEvent: GtBehaviorSuperclassRenamed;
					aptitude: [ BrGlamorousEditableLabelAptitude new
							glamorousCodeFont;
							defaultForeground: Color black;
							fontSize: 10 ];
					margin: (BlInsets
							top: 3
							left: 0
							bottom: 3
							right: 5)) asElement;
			addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
							foreground: Color gray;
							fontSize: 12);
					text: 'Package:';
					focusability: BlFocusability none;
					margin: (BlInsets top: 5 right: 2);
					constraintsDo: [ :c | c grid horizontal alignLeft ]);
			addChild: definition category categoryEditor asElement;
			yourself.
	definition superclass
		when: GtBehaviorSuperclassRenamed
		do: [ :event | action updateSuperclass: definition superclass name ].
	definition category package
		when: GtBehaviorPackageRenamed
		do: [ :event | action updatePackage: definition category package name ].
	definition category tag
		when: GtBehaviorTagRenamed
		do: [ :event | action updatePackageTag: definition category tag name ].
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 5);
		margin: (BlInsets all: 3);
		addChild: element;
		yourself
]

{ #category : #accessing }
GtCreateClassExpanderAttribute >> initialize [
	super initialize.
	definition := GtClassDefinition forNew.
	definition superclass name: #Object.
	self beNotOverwritableByStyler.
	self
		attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ self buildClassDefinition ] ]
]

{ #category : #accessing }
GtCreateClassExpanderAttribute >> setPackage: packageName andTag: tagName [
	definition category package name: packageName.
	definition category tag name: (tagName ifNil: [ '' ])
]
