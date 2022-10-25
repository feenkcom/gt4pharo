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
GtMessageReceiverAttribute >> createDropDown [
	| button dropDownLook |
	button := self createDropDownButton.
	dropDownLook := BrGlamorousWithDropdownAptitude
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
GtMessageReceiverAttribute >> createEditableLabel [
	| label |
	label := BrEditableLabel new.
	label
		aptitude: BrGlamorousEditableLabelAptitude new glamorousCodeFont glamorousRegularSmallSize.
	label text: refactoringController receiverClassName.
	label
		padding: (BlInsets
				top: 2
				left: 4
				bottom: 2
				right: 4).
	label
		when: BrEditorAcceptWish
		do: [ :aWish | 
			| className |
			className := aWish text asString trim.
			(self isClassName: className)
				ifTrue: [ refactoringController receiverClassName: className ] ].

	(GtCompletionController
		on: label
		strategy: (GtStreamedBlockCompletionStrategy new
				streamingBlock: [ :string | 
					(refactoringController potentialTypes asyncStreamStartingWith: string)
						merge: ((GtPharoIndex current globalCache asyncWeightedStreamStartingWith: string)
								collect: [ :each | 
									{each.
										each , ' class'} asAsyncStream ]) flatten ])) install.

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
		ifTrue: [ element addChild: self createEditableLabel as: #editableLabel ].
	^ element
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
		ifNotNil: [ :value | value isBehavior and: [ value name = name ] ]
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
