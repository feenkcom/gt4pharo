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
		'errorMessages',
		'focusAction',
		'runningElement',
		'running'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsPreviewButton >> beMiniSize [
	self childrenDo: #beMiniSize
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildAcceptFor: theRefactoringsElement progressContainer: progressContainer [
	| applyAction anAcceptButton progress |
	(running and: [ runningElement notNil ])
		ifTrue: [ progressContainer
				enqueueTask: [ runningElement ifNotNil: [ runningElement removeFromParent ].
					progressContainer addChild: runningElement ] asBlTask ].
	applyAction := [ :theAcceptButton | 
		running
			ifFalse: [ | promise topElement |
				running := true.
				theAcceptButton disable.
				theRefactoringsElement changesSize > 1
					ifTrue: [ progress := self newProgressElement.
						progressContainer addChild: progress after: theAcceptButton.
						progress fraction: 0.
						runningElement := progress ].
				topElement := theAcceptButton topMostParent.
				self
					dispatchEvent: (GtRefactoringsAboutToApplyEvent new refactorings: executedRefactorings).
				theRefactoringsElement
					fireEvent: (GtRefactoringsAboutToApplyEvent new refactorings: executedRefactorings).
				promise := (theRefactoringsElement
						applyRefactoringWithProgress: [ :fraction | 
							progress
								ifNotNil: [ progress
										enqueueTask: (BlTaskAction new action: [ progress fraction: fraction ]) ] ])
						then: [ :ignore | 
							running := false.

							self
										dispatchEvent: (GtRefactoringsAppliedEvent new refactorings: executedRefactorings).
										
							BlTaskAction
								enqueueElement: theRefactoringsElement
								action: [ 
									theRefactoringsElement
										fireEvent: (GtRefactoringsAppliedEvent new refactorings: executedRefactorings).
									theAcceptButton enable.
									theAcceptButton fireEvent: BrDropdownHideWish new ] ]
						otherwise: [ :anError | 
							| aDebugElement |
							running := false.
							aDebugElement := anError asDebuggableElement
									margin: (BlInsets
											top: 5
											left: 10
											bottom: 15
											right: 10).
							runningElement := aDebugElement.
							progressContainer
								enqueueTask: [ progress ifNotNil: [ progress removeFromParent ].
									progressContainer addChild: aDebugElement.
									self
										dispatchEvent: (GtRefactoringsFailedEvent new refactorings: executedRefactorings).
									theRefactoringsElement
										fireEvent: (GtRefactoringsFailedEvent new refactorings: executedRefactorings) ]
										asBlTask ].
				topElement enqueueTask: (BlPromiseTask new promise: promise) ] ].
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
	running ifTrue: [ anAcceptButton disable ].
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
	| theRefactoringsElement anAcceptButton aContainer refactoringsOrChanges aToolbarElement |
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
	aContainer := BlElement new
			layout: BlLinearLayout vertical;
			when: GtPhlowObjectToSpawn
				do: [ :anEvent | anEvent target phlow spawnPreviousEvent: anEvent ];
			constraintsDo: [ :c1 | 
				c1 horizontal exact: self previewWidth.
				c1 vertical fitContentLimited ].
	aToolbarElement := BrHorizontalPane new
			vFitContent;
			hMatchParent.
	anAcceptButton := self
			buildAcceptFor: theRefactoringsElement
			progressContainer: aToolbarElement.
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

			aToolbarElement addChild: anAcceptButton.
			aContainer addChild: aToolbarElement.
			anAcceptButton beFocusable ]
		ifFalse: [ self errorMessages
				do: [ :each | 
					| element |
					element := each cull: aButton.
					element padding: (BlInsets all: 5).
					aContainer background: BrGlamorousColors errorBackgroundColor.
					aContainer addChild: element ] ].
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
			(each isKindOf: RBRefactoring)
				ifTrue: [ each model
						name: ([ each gtDescription asString ]
								on: Error
								do: [ :ex | ex return: each printString ]) ].
			[ [ each primitiveExecute ]
				on: GtRefactoringNotification
				do: [ :ex | 
					notificationMessages add: ex messageBlock.
					ex pass ] ]
				on: RBRefactoringError
				do: [ :ex | 
					errorMessages add: ex messageBlock.
					ex return ] ]
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> executedRefactorings [
	^ executedRefactorings
		ifNil: [ self executeRefactorings.
			executedRefactorings ]
]

{ #category : #actions }
GtRefactoringsPreviewButton >> focusAcceptButton: aContainer [
	self shouldFocusAcceptButton
		ifTrue: [ aContainer
				childWithId: GtRefactoringsPreviewAcceptId
				ifFound: [ :button | button enqueueTask: (BlTaskAction new action: [ button requestFocus ]) ] ]
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> focusAction [
	^ focusAction
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> focusAction: anObject [
	focusAction := anObject
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
		beTinySize;
		aptitude: BrGlamorousButtonWithIconAptitude new
				+ ((BrGlamorousWithExplicitDropdownAptitude
						handle: [ BrButton new
								icon: BrGlamorousVectorIcons empty;
								beTinySize;
								aptitude: BrGlamorousButtonRectangularAptitude new + BrGlamorousButtonIconAptitude new ]
						content: [ | element |
							element := self buildPreviewForButton: previewButton.
							focusAction cull: element cull: self.
							element ]));
		label: 'Preview'.

	previewButton
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination enter;
				action: [ self openPreview ]).

	self addChild: previewButton.

	focusAction := [ :container | self focusAcceptButton: container ].
	running := false
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> newProgressElement [
	| progress |
	progress := BrProgress new.
	progress aptitude: BrGlamorousProgressBarAptitude.
	progress
		margin: (BlInsets
				top: 5
				left: 10
				bottom: 15
				right: 10).
	progress
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	^ progress
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
