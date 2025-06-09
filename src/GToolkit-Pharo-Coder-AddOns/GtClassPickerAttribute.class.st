Class {
	#name : #GtClassPickerAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoringController',
		'classes',
		'selected',
		'focusOnFirstShow'
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
			content: [ | list selection |
				list := BrSimpleList new.
				list id: #classList.
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
									selected: [ :s | s background: BrGlamorousColors selectedListItemColor ];
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
				selection := (classes indexOf: refactoringController implementor) max: 1.
				list selectOne: selection.
				list
					addShortcut: (BlShortcutWithAction new
							combination: BlKeyCombination return;
							action: [ :anEvent :aShortcut | 
								list selectedItems
									ifNotEmpty: [ :selections | 
										| cls |
										cls := selections anyOne.
										anEvent consumed: true.
										button label: cls.
										anEvent currentTarget fireEvent: BrDropdownHideWish new.
										refactoringController selectClass: cls  ] ]).
				list asScrollableElement
					when: BrPopoverGainFocusWish
						do: [ :anEvent | 
							anEvent consumed: true.
							list requestFocus ];
					yourself ].
	dropDownLook withGainFocusOnShow.
	button addAptitude: dropDownLook.
	button
		addAptitude: (BrStyleCommonAptitude new
				default: [ :s | s background: Color transparent ];
				hovered: [ :s | s background: button theme status neutralBackgroundColor darker ]).
	button
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination escape;
				action: [ :anEvent :aShortcut | refactoringController cancelRefactoring ]);
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination return;
				action: [ :anEvent :aShortcut | dropDownLook show ]);
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination arrowDown;
				action: [ :anEvent :aShortcut | dropDownLook show ]).
	button id: #classPicker.
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
	| element handlers |
	element := self createDropDown.
	element
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
					aStyle background: element theme status neutralBackgroundColor.
					aStyle border: BlBorder empty ];
				hovered: [ :aStyle | aStyle background: element theme status neutralBackgroundColor darker ]).
	focusOnFirstShow
		ifTrue: [ element beFocusable.
			element
				enqueueTask: [ focusOnFirstShow := false.
					element requestFocus ] asBlTask ].
	handlers := {BrTextEditorDeletedEvent.
			BrTextEditorInsertedEvent}
			collect: [ :each | BlEventHandler on: each do: [ :event | refactoringController cancelRefactoring ] ].
	element
		when: BlElementAddedToSceneGraphEvent
			do: [ :anEvent | handlers do: [ :each | anEditorElement editor addEventHandler: each ] ];
		when: BlElementRemovedFromSceneGraphEvent
			do: [ :anEvent | handlers do: [ :each | anEditorElement editor removeEventHandler: each ] ].
	^ element
]

{ #category : #accessing }
GtClassPickerAttribute >> focusOnFirstShow [
	^ focusOnFirstShow
]

{ #category : #accessing }
GtClassPickerAttribute >> focusOnFirstShow: aBoolean [
	focusOnFirstShow := aBoolean
]

{ #category : #accessing }
GtClassPickerAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler.
	self beAppend.
	focusOnFirstShow := true
]

{ #category : #'as yet unclassified' }
GtClassPickerAttribute >> isFocusable [
	^ true
]

{ #category : #initialization }
GtClassPickerAttribute >> refactoringController: anObject [
	refactoringController := anObject
]

{ #category : #accessing }
GtClassPickerAttribute >> selected: aClass [
	selected := aClass
]
