Class {
	#name : #GtAdvice,
	#superclass : #Object,
	#instVars : [
		'priorAdvice',
		'creator',
		'name',
		'description',
		'priority',
		'actions'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Object Advices'
}

{ #category : #accessing }
GtAdvice class >> adviceFor: anObject [
	| pragmas |
	pragmas := self advicePragmasFor: anObject.
	^ ((pragmas collect: [ :each | each methodSelector ]) asSet
		collect: [ :each | anObject perform: each with: self none ])
		asSortedCollection: [ :a :b | a priority < b priority ]
]

{ #category : #accessing }
GtAdvice class >> adviceForClass: aClass [
	| advice |
	advice := self adviceFor: aClass instanceSide.
	advice addAll: (self adviceFor: aClass classSide).
	^ advice
]

{ #category : #accessing }
GtAdvice class >> advicePragmasFor: anObject [
	^ Pragma
		allNamed: #gtAdvice
		from: anObject class
		to: ProtoObject
]

{ #category : #'instance creation' }
GtAdvice class >> none [
	^ GtNoAdvice new
]

{ #category : #'instance creation' }
GtAdvice class >> on: aGtAdvice [
	^ self new
		priorAdvice: aGtAdvice;
		yourself
]

{ #category : #accessing }
GtAdvice >> action: aBlock [
	self
		actions: [ :each | (aBlock cull: each) ifNil: [ #() ] ifNotNil: [ :item | {item} ] ]
]

{ #category : #accessing }
GtAdvice >> actions [
	^ actions
]

{ #category : #accessing }
GtAdvice >> actions: aBlock [
	actions := aBlock
]

{ #category : #advice }
GtAdvice >> asyncStream [
	^ GtAsyncStreamAdvice on: self
]

{ #category : #ui }
GtAdvice >> buildActions: adviceActions in: anElement for: aButton [
	adviceActions isEmpty ifTrue: [ ^ self ].
	anElement
		addChild: (BrSimpleList new
				stencil: [ :each | 
					| element |
					element := BrHorizontalPane new
							hMatchParent;
							vFitContent;
							addAptitude: (BrStyleCommonAptitude new
									hovered: [ :aStyle | aStyle background: aButton theme button defaultBorderColor ]);
							padding: (BlInsets all: 5);
							when: BlClickEvent
								do: [ :anEvent | 
									anEvent consumed: true.
									each executeOn: aButton.
									aButton fireEvent: BrDropdownHideWish new.
									aButton fireEvent: BrContextMenuHideWish new ];
							addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude;
									text: each title glamorousCodeSmallSize;
									yourself).
					element ];
				hMatchParent;
				vFitContentLimited;
				items: adviceActions)
]

{ #category : #ui }
GtAdvice >> buildElementFor: aButton [
	| pane text labelText browseAttribute |
	pane := BrVerticalPane new.
	pane
		hMatchParent;
		vFitContent;
		margin: (BlInsets top: 5 bottom: 5).

	self
		resultsDo: [ :each | 
			text := (self descriptionFor: each) asRopedText
					foreground: BrGlamorousColors disabledButtonTextColor.
			creator
				ifNotNil: [ browseAttribute := GtButtonAttribute new
							beAppend;
							stencil: [ BrButton new
									aptitude: BrGlamorousButtonWithIconAptitude new;
									beTinySize;
									margin: (BlInsets left: 5);
									icon: BrGlamorousVectorIcons browse;
									action: [ aButton phlow spawnTool: (GtMethodCoderTool compiledMethod: creator) ];
									label: 'Browse rule definition' ].
					text
						attribute: browseAttribute
						from: text size
						to: text size ].
			labelText := BrEditor new
					vFitContent;
					aptitude: BrGlamorousRegularEditorAptitude new glamorousCodeSmallSize;
					text: text.
			pane addChild: labelText.
			self
				buildActions: (actions cull: each)
				in: pane
				for: aButton ].
	^ pane
]

{ #category : #accessing }
GtAdvice >> creator [
	^ creator
]

{ #category : #accessing }
GtAdvice >> description [
	^ description
]

{ #category : #accessing }
GtAdvice >> description: aBlockOrText [
	description := aBlockOrText
]

{ #category : #accessing }
GtAdvice >> descriptionFor: anObject [
	^ description cull: anObject
]

{ #category : #testing }
GtAdvice >> hasAdvice [
	^ false
]

{ #category : #initialization }
GtAdvice >> initialize [
	super initialize.
	priority := SmallInteger maxVal.
	actions := [ :result | #() ]
]

{ #category : #advice }
GtAdvice >> item [
	^ GtItemAdvice on: self
]

{ #category : #advice }
GtAdvice >> list [
	^ GtListAdvice on: self
]

{ #category : #advice }
GtAdvice >> none [
	^ GtNoAdvice on: self
]

{ #category : #accessing }
GtAdvice >> priorAdvice [
	^ priorAdvice
]

{ #category : #accessing }
GtAdvice >> priorAdvice: aGtAdvice [
	priorAdvice := aGtAdvice.
	self setCreator
]

{ #category : #accessing }
GtAdvice >> priority [
	^ priority
]

{ #category : #accessing }
GtAdvice >> priority: anInteger [
	priority := anInteger
]

{ #category : #accessing }
GtAdvice >> result [
	^ nil
]

{ #category : #enumerating }
GtAdvice >> resultsDo: aBlock [
]

{ #category : #private }
GtAdvice >> setCreator [
	| current pragmas |
	current := thisContext.
	[ current notNil ]
		whileTrue: [ pragmas := current method pragmas.
			(pragmas anySatisfy: [ :each | each selector = #gtAdvice ])
				ifTrue: [ ^ creator := current method ].
			current := current sender ]
]
