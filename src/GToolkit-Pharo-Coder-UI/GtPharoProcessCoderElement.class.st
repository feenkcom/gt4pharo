Class {
	#name : #GtPharoProcessCoderElement,
	#superclass : #GtPharoMethodsCoderElement,
	#instVars : [
		'activeCoder',
		'contextVariablesElement',
		'watchVariablesElement',
		'watchExpressions'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #private }
GtPharoProcessCoderElement >> addMethodWatchExpressionFrom: aMethodCoder [
	GtWatchExpression addExpression: aMethodCoder selectedSource for: aMethodCoder compiledMethod.
	self updateWatchExpressions
]

{ #category : #private }
GtPharoProcessCoderElement >> addWatchExpressionFrom: aMethodCoder [
	(watchExpressions at: aMethodCoder ifAbsentPut: [ OrderedCollection new ])
		add: (GtWatchExpression new expression: aMethodCoder selectedSource).
	self updateWatchExpressions
]

{ #category : #ui }
GtPharoProcessCoderElement >> buildElement [
	super buildElement.
	self layout: BlLinearLayout horizontal.
	self addChild: self variablesElement
]

{ #category : #private }
GtPharoProcessCoderElement >> contextVariables [
	| vars |
	(activeCoder isNil or: [ activeCoder isDead ])
		ifTrue: [ ^ #() ].
	vars := OrderedCollection new.
	activeCoder tempNamesAndValuesDo: [ :name :value | vars add: {name. 'temporary'. value} ].
	activeCoder instanceVariableNamesAndValuesDo: [ :name :value | vars add: {name. 'instance'. value} ].
	vars sort: [ :a :b | a first < b first ].
	vars addFirst: {'self'. 'self'. activeCoder receiver}.
	activeCoder stackVariableNamesAndValuesDo: [ :name :value | vars add: {name. 'stack'. value} ].
	^ vars
]

{ #category : #ui }
GtPharoProcessCoderElement >> contextVariablesElement [
	contextVariablesElement := self variablesListElement.
	contextVariablesElement items: self contextVariables.
	^ contextVariablesElement
]

{ #category : #private }
GtPharoProcessCoderElement >> focusedCoder: aCoder in: anElement [
	activeCoder := aCoder.
	self updateVariables
]

{ #category : #'initialize-release' }
GtPharoProcessCoderElement >> initialize [
	super initialize.
	watchExpressions := WeakKeyDictionary new
]

{ #category : #private }
GtPharoProcessCoderElement >> updateList [
	super updateList.
	self updateVariables
]

{ #category : #private }
GtPharoProcessCoderElement >> updateVariables [
	contextVariablesElement notNil
		ifTrue: [ contextVariablesElement display: self contextVariables ].
	self updateWatchExpressions
]

{ #category : #private }
GtPharoProcessCoderElement >> updateWatchExpressions [
	watchVariablesElement notNil
		ifTrue: [ watchVariablesElement display: self watchVariables ]
]

{ #category : #ui }
GtPharoProcessCoderElement >> variablesElement [
	^ BrTabGroup new
		aptitude: BrGlamorousTabGroupAptitude new;
		addTab: (BrTab new
			aptitude: BrGlamorousTabAptitude new;
			label: 'Variables';
			stencil: [ self contextVariablesElement ]);
		addTab: (BrTab new
			aptitude: BrGlamorousTabAptitude new;
			label: 'Watches';
			stencil: [ self watchVariablesElement ])
]

{ #category : #ui }
GtPharoProcessCoderElement >> variablesListElement [
	| list |
	list := BrColumnedList new.
	list margin: (BlInsets all: 10).
	list addEventHandler: (GtPhlowListToSelectHandler new transformation: [ :each | each last ]).
	list column
		title: 'Icon';
		stencil: [ :each | 
			| icon |
			icon := [ each last gtInspectorIcon ifNil: [ each last class systemIcon ] ]
				on: Error
				do: [ :error | self iconNamed: #smallWarningIcon ].
			icon asElement
				margin:
					(BlInsets
						top: 3
						left: 10
						bottom: 3
						right: 0) ].
	list column
		title: 'Variable';
		stencil: [ :each | 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
				text: each first asString;
				hMatchParent;
				vMatchParent;
				margin:
					(BlInsets
						top: 3
						left: 10
						bottom: 3
						right: 0) ].
	list column
		title: 'Value';
		stencil: [ :each | 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
				text: (each last printStringLimitedTo: 50);
				hMatchParent;
				vMatchParent;
				margin:
					(BlInsets
						top: 3
						left: 10
						bottom: 3
						right: 0) ].
	^ list
]

{ #category : #private }
GtPharoProcessCoderElement >> watchExpressionsFor: aMethodCoder [
	^ (watchExpressions at: aMethodCoder ifAbsent: [ #() ]) , (GtWatchExpression expressionsFor: aMethodCoder compiledMethod) asArray
]

{ #category : #private }
GtPharoProcessCoderElement >> watchVariables [
	| variables |
	variables := OrderedCollection new.
	methodsCoderUIModel coder coders
		do: [ :each | variables addAll: (self watchVariablesFor: each) ].
	^ variables
]

{ #category : #ui }
GtPharoProcessCoderElement >> watchVariablesElement [
	watchVariablesElement := self variablesListElement.
	watchVariablesElement items: self watchVariables.
	^ watchVariablesElement
]

{ #category : #private }
GtPharoProcessCoderElement >> watchVariablesFor: aMethodCoder [
	^ (self watchExpressionsFor: aMethodCoder)
		collect: [ :each | 
			{each expression.
			'Watch Expression'.
			(each valueIn: aMethodCoder context)} ]
]
