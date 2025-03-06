Class {
	#name : #GtClassPickerAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoringController',
		'classes',
		'selected'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtClassPickerAttribute >> classes: aCollection [
	classes := aCollection
]

{ #category : #accessing }
GtClassPickerAttribute >> createDropDown [
	| button dropDownLook |
	button := self createDropDownButton.
	dropDownLook := BrGlamorousWithExplicitDropdownAptitude
			handle: [ self createDropDownButton ]
			content: [ | list |
				list := BrSimpleList new.
				list fitContent.
				list
					stencil: [ :each | 
						BrHorizontalPane new
							hMatchParent;
							vFitContent;
							padding: (BlInsets all: 5);
							aptitude: (BrStyleCommonAptitude new
									default: [ :s | s background: Color transparent ];
									hovered: [ :s | s background: button theme button defaultBorderColor ];
									yourself);
							when: BlClickEvent
								do: [ :anEvent | 
									anEvent consumed: true.
									button label: each.
									anEvent currentTarget fireEvent: BrDropdownHideWish new.
									refactoringController selectClass: each ];
							addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude new glamorousCodeFont glamorousCodeSmallSize;
									text: each;
									yourself);
							yourself ].
				list items: classes.
				list asScrollableElement ].
	button addAptitude: dropDownLook.
	button
		addAptitude: (BrStyleCommonAptitude new
				default: [ :s | s background: Color transparent ];
				hovered: [ :s | s background: button theme status neutralBackgroundColor darker ]).
	^ button
]

{ #category : #accessing }
GtClassPickerAttribute >> createDropDownButton [
	| button |
	button := BrButton new.
	button
		aptitude: BrTextLabelAptitude new glamorousCodeFont glamorousCodeSmallSize
				+ BrGlamorousButtonIconAptitude + BrGlamorousButtonLayoutAptitude.
	button vExact: 20.
	button padding: (BlInsets left: 4 right: 2).
	button label: selected name.
	button icon: BrGlamorousVectorIcons downwards.
	button beSmallSize.
	^ button
]

{ #category : #accessing }
GtClassPickerAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| element |
	element := self createDropDown.
	^ element
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
					aStyle background: element theme status neutralBackgroundColor.
					aStyle border: BlBorder empty ];
				hovered: [ :aStyle | aStyle background: element theme status neutralBackgroundColor darker ]);
		yourself
]

{ #category : #accessing }
GtClassPickerAttribute >> initialize [
	super initialize.
	self beAppend
]

{ #category : #initialization }
GtClassPickerAttribute >> refactoringController: anObject [
	refactoringController := anObject
]

{ #category : #accessing }
GtClassPickerAttribute >> selected: aClass [
	selected := aClass
]
