Class {
	#name : #GtCreateClassExpanderAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'action',
		'definition',
		'showSuperclass'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
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
	element := BrHorizontalGrid new.
	element hMatchParent.
	element vFitContent.
	element columnCount: 2.
	element background: Color white.
	element padding: (BlInsets all: 4).
	element aptitude: BrShadowAptitude.
	showSuperclass
		ifTrue: [ element
				addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
								foreground: Color gray;
								fontSize: 12);
						text: 'Superclass:';
						focusability: BlFocusability none;
						margin: (BlInsets top: 5 right: 2);
						constraintsDo: [ :c | c grid horizontal alignLeft ]).
			element
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
								right: 5)) asElement ].
	element
		addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
						foreground: Color gray;
						fontSize: 12);
				text: 'Package:';
				focusability: BlFocusability none;
				margin: (BlInsets top: 5 right: 2);
				constraintsDo: [ :c | c grid horizontal alignLeft ]).
	element addChild: definition category categoryEditor asElement.
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

{ #category : #initialization }
GtCreateClassExpanderAttribute >> hideSuperclass [
	showSuperclass := false
]

{ #category : #initialization }
GtCreateClassExpanderAttribute >> initialize [
	super initialize.
	showSuperclass := true.
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
