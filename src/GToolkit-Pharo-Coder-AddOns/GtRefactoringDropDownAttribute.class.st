Class {
	#name : #GtRefactoringDropDownAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoringController',
		'selected',
		'focusOnFirstShow',
		'items'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRefactoringDropDownAttribute >> buttonId [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> buttonLabel [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> cancel [
	refactoringController cancelRefactoring
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> createDropDown [
	| button dropDownLook |
	button := self createDropDownButton.
	dropDownLook := BrGlamorousWithExplicitDropdownAptitude
			handle: [ self createDropDownButton ]
			content: [ | list selection |
				list := BrSimpleList new.
				list id: self listId.
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
									self select: each ];
							addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude new glamorousCodeFont glamorousCodeSmallSize;
									text: each;
									yourself);
							yourself ].
				list items: items.
				selection := (items indexOf: self currentSelection) max: 1.
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
										self select: cls ] ]).
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
				action: [ :anEvent :aShortcut | self cancel ]);
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination arrowDown;
				action: [ :anEvent :aShortcut | dropDownLook show ]).
	button id: self buttonId.
	button beFocusable.
	button userData at: #isRefactoringEditor put: true.
	button
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle background: button theme status neutralBackgroundColor ];
				hovered: [ :aStyle | aStyle background: button theme status neutralBackgroundColor darker ];
				focused: [ :aStyle | aStyle background: button theme editor focusedBorderColor lighter lighter ]).
	button
		addAptitude: (BrStyleCommonAptitude new
				// #label;
				default: [ :aStyle | aStyle foreground: Color black ];
				focused: [ :aStyle | aStyle foreground: Color white ]).
	^ button
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> createDropDownButton [
	| button |
	button := BrButton new.
	button
		aptitude: BrTextLabelAptitude new glamorousCodeFont glamorousCodeSmallSize
				+ BrGlamorousButtonIconAptitude + BrGlamorousButtonLayoutAptitude.
	button vExact: 20.
	button padding: (BlInsets left: 4 right: 2).
	button label: self buttonLabel.
	button icon: BrGlamorousVectorIcons downwards.
	button beSmallSize.
	^ button
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> currentSelection [
	^ nil
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| dropdown handlers element |
	element := BrHorizontalPane new.
	element fitContent.
	element margin: (BlInsets all: 3).
	element
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
					aStyle background: element theme status neutralBackgroundColor.
					aStyle border: BlBorder empty ];
				hovered: [ :aStyle | aStyle background: element theme status neutralBackgroundColor darker ]).
	dropdown := self createDropDown.
	dropdown
		addShortcut: (BlShortcutWithAction new
				combination: (BlKeyCombination tab or: BlKeyCombination return);
				action: [ :anEvent :aShortcut | 
					(self
						focusNext: true
						in: anEditorElement
						from: dropdown) ifFalse: [ refactoringController openRefactoringPreview ] ]).
	focusOnFirstShow
		ifTrue: [ dropdown
				enqueueTask: [ focusOnFirstShow := false.
					dropdown requestFocus ] asBlTask ].
	handlers := {BrTextEditorDeletedEvent.
			BrTextEditorInsertedEvent}
			collect: [ :each | BlEventHandler on: each do: [ :event | self cancel ] ].
	dropdown
		when: BlElementAddedToSceneGraphEvent
			do: [ :anEvent | handlers do: [ :each | anEditorElement editor addEventHandler: each ] ];
		when: BlElementRemovedFromSceneGraphEvent
			do: [ :anEvent | handlers do: [ :each | anEditorElement editor removeEventHandler: each ] ].
	element addChild: dropdown.
	^ element
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> focusNext: aBoolean in: anEditorElement from: currentEditor [
	| first last previous |
	anEditorElement
		allChildrenBreadthFirstDo: [ :each | 
			(each userData at: #isRefactoringEditor ifAbsent: [ false ])
				ifTrue: [ first ifNil: [ first := each ].
					last := each.
					(aBoolean not and: [ each == currentEditor and: [ previous notNil ] ])
						ifTrue: [ previous requestFocus.
							^ true ].
					(aBoolean and: [ previous == currentEditor ])
						ifTrue: [ each requestFocus.
							^ true ].
					previous := each ] ].
	aBoolean
		ifTrue: [ (first notNil and: [ first ~~ currentEditor ])
				ifTrue: [ first requestFocus.
					^ true ] ]
		ifFalse: [ (last notNil and: [ last ~~ currentEditor ])
				ifTrue: [ last requestFocus.
					^ true ] ].
	^ false
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> focusOnFirstShow [
	^ focusOnFirstShow
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> focusOnFirstShow: aBoolean [
	focusOnFirstShow := aBoolean
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler.
	self beAppend.
	focusOnFirstShow := true
]

{ #category : #testing }
GtRefactoringDropDownAttribute >> isFocusable [
	^ true
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> items [
	^ items
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> items: anObject [
	items := anObject
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> listId [
	^ #list
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> refactoringController [
	^ refactoringController
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> refactoringController: anObject [
	refactoringController := anObject
]

{ #category : #private }
GtRefactoringDropDownAttribute >> select: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
GtRefactoringDropDownAttribute >> selected: anObject [
	selected := anObject
]
