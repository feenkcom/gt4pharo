Class {
	#name : #GtAdvice,
	#superclass : #Object,
	#instVars : [
		'priorAdvice',
		'creator'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtAdvice class >> advicePragmasFor: anObject [
	^ Pragma
		allNamed: #gtAdvice:
		from: anObject class
		to: ProtoObject
]

{ #category : #accessing }
GtAdvice class >> asyncAdviceStreamFor: anObject [
	| pragmas |
	pragmas := (self advicePragmasFor: anObject)
			asSortedCollection: [ :a :b | a arguments first < b arguments first ].
	^ ((pragmas asAsyncStream collect: [ :each | each methodSelector ])
		withoutDuplicates collect: [ :each | anObject perform: each with: self none ])
		select: [ :each | each isNone not ]
]

{ #category : #accessing }
GtAdvice class >> asyncAdviceStreamForClass: aClass [
	| pragmas |
	pragmas := OrderedCollection new.
	(self advicePragmasFor: aClass instanceSide)
		do: [ :each | 
			pragmas
				add: {each.
						aClass instanceSide} ].
	(self advicePragmasFor: aClass classSide)
		do: [ :each | 
			pragmas
				add: {each.
						aClass classSide} ].
	pragmas
		sort: [ :a :b | 
			a first arguments first < b first arguments first
				or: [ a first arguments first = b first arguments first
						and: [ a last isInstanceSide ] ] ].
	^ ((pragmas asAsyncStream
		collect: [ :each | 
			{each last.
				each first methodSelector} ]) withoutDuplicates
		collect: [ :each | each first perform: each last with: self none ])
		select: [ :each | each isNone not ]
]

{ #category : #'instace creation' }
GtAdvice class >> none [
	^ GtNoAdvice new
]

{ #category : #'instace creation' }
GtAdvice class >> on: aGtAdvice [
	^ self new
		priorAdvice: aGtAdvice;
		yourself
]

{ #category : #ui }
GtAdvice >> buildActionsIn: anElement for: aButton [
]

{ #category : #ui }
GtAdvice >> buildElementFor: aButton [
	| pane text labelText browseAttribute |
	pane := BrVerticalPane new.
	pane
		hMatchParent;
		vFitContent.
	text := self name asRopedText.
	labelText := BrEditor new
			vFitContent;
			aptitude: BrGlamorousRegularEditorAptitude new glamorousCodeSmallSize;
			text: text.
	pane addChild: labelText.

	text := self description asRopedText
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
			padding: (BlInsets left: 20);
			vFitContent;
			aptitude: BrGlamorousRegularEditorAptitude new glamorousCodeSmallSize;
			text: text.
	pane addChild: labelText.
	self buildActionsIn: pane for: aButton.
	^ pane
]

{ #category : #accessing }
GtAdvice >> description [
	^ self subclassResponsibility
]

{ #category : #testing }
GtAdvice >> isNone [
	^ false
]

{ #category : #accessing }
GtAdvice >> name [
	^ self subclassResponsibility
]

{ #category : #advising }
GtAdvice >> none [
	^ GtNoAdvice new
		priorAdvice: self;
		yourself
]

{ #category : #printing }
GtAdvice >> printOn: aStream [
	aStream nextPutAll: self name
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

{ #category : #private }
GtAdvice >> setCreator [
	| current pragmas |
	current := thisContext.
	[ current notNil ]
		whileTrue: [ pragmas := current method pragmas.
			(pragmas anySatisfy: [ :each | each selector = #gtAdvice: ])
				ifTrue: [ ^ creator := current method ].
			current := current sender ]
]
