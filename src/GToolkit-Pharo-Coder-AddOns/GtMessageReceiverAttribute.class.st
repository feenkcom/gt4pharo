Class {
	#name : #GtMessageReceiverAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'receivers',
		'refactoringController'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtMessageReceiverAttribute >> cancel [
	refactoringController cancelRefactoring
]

{ #category : #accessing }
GtMessageReceiverAttribute >> createDropDown [
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
									refactoringController receiver: each ];
							addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude new glamorousCodeFont glamorousCodeSmallSize;
									text: each;
									yourself);
							yourself ].
				list items: receivers.
				list asScrollableElement ].
	button addAptitude: dropDownLook.
	button
		addAptitude: (BrStyleCommonAptitude new
				default: [ :s | s background: Color transparent ];
				hovered: [ :s | s background: button theme status neutralBackgroundColor darker ]).
	^ button
]

{ #category : #accessing }
GtMessageReceiverAttribute >> createDropDownButton [
	| button |
	button := BrButton new.
	button
		aptitude: BrTextLabelAptitude new glamorousCodeFont glamorousCodeSmallSize
				+ BrGlamorousButtonIconAptitude + BrGlamorousButtonLayoutAptitude.
	button vExact: 20.
	button padding: (BlInsets left: 4 right: 2).
	button label: refactoringController receiver.
	button icon: BrGlamorousVectorIcons downwards.
	button beSmallSize.
	^ button
]

{ #category : #accessing }
GtMessageReceiverAttribute >> createEditableLabelIn: anEditorElement [
	| label |
	label := GtRenameEditor new.
	label
		aptitude: BrGlamorousEditableLabelAptitude new glamorousCodeFont glamorousRegularSmallSize.
	label text: refactoringController receiverClassName.
	label
		padding: (BlInsets
				top: 2
				left: 4
				bottom: 2
				right: 4).
	self setupHandlersFor: label in: anEditorElement.
	(GtCompletionController
		on: label
		strategy: (GtStreamedBlockCompletionStrategy new
				streamingBlock: [ :string | 
					((refactoringController potentialTypes asyncStreamStartingWith: string)
						merge: ((GtPharoIndex current classNameTree asyncWeightedStreamStartingWith: string)
								collect: [ :each | 
									{each.
										each , ' class'} asAsyncStream ]) flatten) withoutDuplicates ]))
		install.
	label
		switchToEditor;
		requestFocus.
	^ label
]

{ #category : #accessing }
GtMessageReceiverAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| element |
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
	element addChild: self createDropDown.
	refactoringController showReceiverType
		ifTrue: [ element
				addChild: (self createEditableLabelIn: anEditorElement)
				as: #editableLabel ].
	^ element
]

{ #category : #accessing }
GtMessageReceiverAttribute >> focusNext: aBoolean in: anEditorElement from: currentEditor [
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
		ifTrue: [ first
				ifNotNil: [ first requestFocus.
					^ true ] ]
		ifFalse: [ last
				ifNotNil: [ last requestFocus.
					^ true ] ].
	^ false
]

{ #category : #accessing }
GtMessageReceiverAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler
]

{ #category : #testing }
GtMessageReceiverAttribute >> isClassName: aSymbol [
	| name |
	name := aSymbol.
	(name endsWith: ' class') ifTrue: [ name := name allButLast: 6 ].
	^ (self class environment bindingOf: name asSymbol) value
		ifNil: [ false ]
		ifNotNil: [ :value | value isBehavior and: [ value name sameContentAs: name ] ]
]

{ #category : #accessing }
GtMessageReceiverAttribute >> receivers [
	^ receivers
]

{ #category : #accessing }
GtMessageReceiverAttribute >> receivers: aCollection [
	receivers := aCollection
]

{ #category : #accessing }
GtMessageReceiverAttribute >> refactoringController [
	^ refactoringController
]

{ #category : #accessing }
GtMessageReceiverAttribute >> refactoringController: aRefactoringController [
	refactoringController := aRefactoringController
]

{ #category : #accessing }
GtMessageReceiverAttribute >> setupHandlersFor: label in: anEditorElement [
	label
		whenKey: BlKeyCombination escape editorDo: [ :aShortcutEvent | self cancel ];
		whenKey: BlKeyCombination builder shift tab build
			editorDo: [ :aShortcutEvent | 
				self
					focusNext: false
					in: anEditorElement
					from: label ];
		whenKey: BlKeyCombination tab
			editorDo: [ :aShortcutEvent | 
				self
					focusNext: true
					in: anEditorElement
					from: label ];
		whenKey: BlKeyCombination enter
			editorDo: [ :aShortcutEvent | 
				self
					focusNext: true
					in: anEditorElement
					from: label ].

	label when: BrEditorCancelWish do: [ :event | self cancel ].

	label
		when: BrEditorAcceptWish
		do: [ :aWish | 
			| className |
			className := aWish text asString trim.
			(self isClassName: className)
				ifTrue: [ refactoringController receiverClassName: className ] ].

	label
		whenKey: BlKeyCombination arrowRight
		editorDo: [ :aShortcutEvent | 
			| cursors editor |
			editor := aShortcutEvent source editor.
			cursors := editor cursors positions.
			(cursors includes: editor text size)
				ifTrue: [ aShortcutEvent
						consumed: (self
								focusNext: true
								in: anEditorElement
								from: label) ]
				ifFalse: [ cursors notEmpty
						ifTrue: [ editor selectNone.
							editor moveCursorTo: cursors first + 1 ] ] ].
	label
		whenKey: BlKeyCombination arrowLeft
		editorDo: [ :aShortcutEvent | 
			| cursors editor |
			editor := aShortcutEvent source editor.
			cursors := editor cursors positions.
			(cursors includes: 0)
				ifTrue: [ aShortcutEvent
						consumed: (self
								focusNext: false
								in: anEditorElement
								from: label) ]
				ifFalse: [ cursors notEmpty
						ifTrue: [ editor selectNone.
							editor moveCursorTo: cursors first - 1 ] ] ].
	label
		whenKey: BlKeyCombination arrowDown
		editorDo: [ :aShortcutEvent | 
			aShortcutEvent
				consumed: (self
						focusNext: true
						in: anEditorElement
						from: label) ].
	label
		whenKey: BlKeyCombination arrowUp
		editorDo: [ :aShortcutEvent | 
			aShortcutEvent
				consumed: (self
						focusNext: false
						in: anEditorElement
						from: label) ]
]
