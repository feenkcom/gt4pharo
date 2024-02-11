"
nil
"
Class {
	#name : #GtRefactoringsPreviewButton,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'executedRefactorings',
		'cancelBlock',
		'refactoringsComputation',
		'notificationMessages',
		'errorMessages'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsPreviewButton >> beMiniSize [
	self childrenDo: #beMiniSize
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildAcceptForButton: aButton andElement: theRefactoringsElement [
	| applyAction anAcceptButton |
	applyAction := [ 
		aButton fireEvent: BrDropdownHideWish new.
		theRefactoringsElement applyRefactorings
			then: [ :ignore | self dispatchEvent: GtRefactoringsAppliedEvent new ] ].

	anAcceptButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude new;
			id: GtRefactoringsPreviewAcceptId;
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			requestFocus;
			label: 'Save';
			margin: (BlInsets
					top: 0
					left: 10
					bottom: 10
					right: 0);
			action: applyAction;
			yourself.

	^ anAcceptButton
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildAsyncPreviewForButton: previewButton [
	^ BrAsyncWidget new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c vertical exact: 50.
			c horizontal exact: self previewWidth ];
		postAction: [ :theLazyElement | theLazyElement constraintsDo: [ :c | c vertical fitContentLimited ] ];
		stencil: [ self buildRefactoringsPreviewForButton: previewButton ]
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildCancelButton [
	| cancelAction |
	cancelAction := [ self removeFromParent.
		cancelBlock value ].

	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons cancel;
		beSmallSize;
		alignCenterLeft;
		label: 'Cancel';
		margin: (BlInsets left: 5);
		action: cancelAction;
		yourself
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildPreviewForButton: previewButton [
	^ self buildAsyncPreviewForButton: previewButton
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildRefactoringsPreviewForButton: aButton [
	| theRefactoringsElement anAcceptButton aContainer label refactoringsOrChanges |
	refactoringsOrChanges := self executedRefactorings.
	theRefactoringsElement := GtRefactoringsElement new
			hExact: self previewWidth * 1.25;
			vFitContentLimited.
	(refactoringsOrChanges allSatisfy: [ :each | each isKindOf: RBRefactoring ])
		ifTrue: [ theRefactoringsElement refactorings: refactoringsOrChanges ]
		ifFalse: [ | change |
			change := RBCompositeRefactoryChange named: 'Changes'.
			refactoringsOrChanges do: [ :each | change addChange: each ].
			theRefactoringsElement changes: change ].
	anAcceptButton := self
			buildAcceptForButton: aButton
			andElement: theRefactoringsElement.
	aContainer := BlElement new
			layout: BlLinearLayout vertical;
			when: GtPhlowObjectToSpawn
				do: [ :anEvent | anEvent target phlow spawnObject: anEvent object ];
			constraintsDo: [ :c1 | 
				c1 horizontal exact: self previewWidth.
				c1 vertical fitContentLimited ].
	self errorMessages isEmpty
		ifTrue: [ self notificationMessages
				do: [ :each | 
					| element |
					element := each cull: aButton.
					element
						margin: (BlInsets
								top: 10
								left: 10
								bottom: 0
								right: 10).
					aContainer addChild: element ].
			aContainer
				addChild: ((theRefactoringsElement asScalableElement
						width: self previewWidth;
						fitWidth;
						constraintsDo: [ :c | c vertical fitContentLimited ]) asScrollableElement
						constraintsDo: [ :c | c vertical fitContentLimited ]).
			aContainer addChild: anAcceptButton.
			anAcceptButton beFocusable.
			self shouldFocusAcceptButton
				ifTrue: [ anAcceptButton
						enqueueTask: (BlTaskAction new action: [ anAcceptButton requestFocus ]) ] ]
		ifFalse: [ self errorMessages
				do: [ :each | 
					label := BrLabel new
							fitContent;
							aptitude: BrGlamorousLabelAptitude new;
							padding: (BlInsets all: 5);
							text: each asRopedText glamorousRegularFontAndSize.
					aContainer background: BrGlamorousColors errorBackgroundColor.
					aContainer addChild: label ] ].
	^ aContainer
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> cancelBlock: aBlock [
	cancelBlock := aBlock.
	cancelBlock notNil ifTrue: [ self addChild: self buildCancelButton ]
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> errorMessages [
	errorMessages ifNil: [ self executeRefactorings ].
	^ errorMessages
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> executeRefactorings [
	errorMessages := OrderedCollection new.
	notificationMessages := OrderedCollection new.
	executedRefactorings := self refactorings.
	executedRefactorings
		do: [ :each | 
			(each isKindOf: RBRefactoring) ifTrue: [ each model name: each printString ].
			[ [ each primitiveExecute ]
				on: GtRefactoringNotification
				do: [ :ex | 
					notificationMessages add: ex tag.
					ex pass ] ]
				on: RBRefactoringError
				do: [ :ex | 
					errorMessages add: ex messageText.
					ex return ] ]
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> executedRefactorings [
	^ executedRefactorings
		ifNil: [ self executeRefactorings.
			executedRefactorings ]
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> initialize [
	| previewButton |
	super initialize.

	self
		fitContent;
		alignCenterLeft.

	refactoringsComputation := [ #() ].

	previewButton := BrButton new.
	previewButton
		icon: BrGlamorousVectorIcons accept;
		id: #previewCheckButton;
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAptitude new
				+ ((BrGlamorousWithDropdownAptitude
						handle: [ BrButton new
								icon: BrGlamorousIcons empty;
								beSmallSize;
								aptitude: BrGlamorousButtonRectangularAptitude new + BrGlamorousButtonIconAptitude new ]
						content: [ self buildPreviewForButton: previewButton ])
						preferredExtent: self previewWidth @ 50);
		label: 'Preview'.

	previewButton
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination enter;
				action: [ self openPreview ]).

	self addChild: previewButton
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> notificationMessages [
	notificationMessages ifNil: [ self executeRefactorings ].
	^ notificationMessages
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> openPreview [
	^ self previewButton
		fireEvent: (BrDropdownShowWish new anchor: self previewButton)
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> previewButton [
	^ self childAt: 1
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> previewWidth [
	^ self isAttachedToSceneGraph
		ifTrue: [ (self topMostParent extent / 2.0) x ]
		ifFalse: [ 500 ]
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> refactorings [
	^ refactoringsComputation value
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> refactorings: aBlock [
	refactoringsComputation := aBlock
]

{ #category : #testing }
GtRefactoringsPreviewButton >> shouldFocusAcceptButton [
	^ true
]
