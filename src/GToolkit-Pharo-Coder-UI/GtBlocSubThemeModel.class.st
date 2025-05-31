Class {
	#name : #GtBlocSubThemeModel,
	#superclass : #Object,
	#instVars : [
		'name',
		'subTheme',
		'subThemeClass',
		'themeableValues',
		'themeableAssignments',
		'constantAssignments'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtBlocSubThemeModel >> computeConstantAssignments [
	| assignments currentClass|
	
	assignments := OrderedCollection new.
	
	currentClass := subThemeClass.
	[ currentClass = BlSubTheme ] whileFalse: [
		assignments addAll: (self detectConstantAssignmentsIn: currentClass).
		currentClass := currentClass superclass ].
	
	^ assignments groupedBy: [ :each | each valueName ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> computeThemeableAssignments [
	| assignments currentClass|
	
	assignments := OrderedCollection new.
	
	currentClass := subThemeClass.
	[ currentClass = BlSubTheme ] whileFalse: [
		assignments addAll: (self detectThemeableAssignmentsIn: currentClass).
		currentClass := currentClass superclass ].
	
	^ assignments groupedBy: [ :each | each valueName ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> computeThemeableValues [
	| valueNames |
	
	valueNames := subThemeClass allInstVarNames copyWithoutAll: BlSubTheme instVarNames.
	
	^ valueNames collect: [ :eachVarName | 
		(GtBlocThemeableValue new
			subThemeModel: self;
			valueName: eachVarName;
			valueAssignments: (themeableAssignments at: eachVarName ifAbsent: [ #() ]);
			themeableValue: (subTheme instVarNamed: eachVarName)) ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> detectConstantAssignmentsIn: aSubThemeClass [
	| assignments selectors |
	
	assignments := OrderedCollection new.
	
	selectors := #(initializeConstants).
	
	selectors do: [ :eachSelector |
		aSubThemeClass
			compiledMethodAt: eachSelector
			ifPresent: [ :initializeMethod |
				| ast |
				ast := GtPharoParser parse: initializeMethod sourceCode.
				ast allNodesDo: [ :each |
					(each isMessageSend and: [ each selector = #constantsAt:put: ])
						ifTrue: [
							assignments add: (GtBlocThemeableConstantAssignment new
								subThemeClass: aSubThemeClass;
								subThemeSelector: eachSelector;
								valueName: each variable variableName;
								valueAst: each value) ] ] ] ].
	
	^ assignments
]

{ #category : #accessing }
GtBlocSubThemeModel >> detectThemeableAssignmentsIn: aSubThemeClass [
	| assignments selectors |
	
	assignments := OrderedCollection new.
	
	selectors := #(initialize initializeThemeable initializeColors).
	
	selectors do: [ :eachSelector |
		aSubThemeClass
		compiledMethodAt: eachSelector
		ifPresent: [ :initializeMethod |
			| ast |
			ast := GtPharoParser parse: initializeMethod sourceCode.
			ast allNodesDo: [ :each |
				each isAssignment
					ifTrue: [
						assignments add: (GtBlocThemeableValueAssignment new
							subThemeClass: aSubThemeClass;
							subThemeSelector: eachSelector;
							valueName: each variable variableName;
							valueAst: each value) ] ] ] ].
	
	^ assignments
]

{ #category : #accessing }
GtBlocSubThemeModel >> name [
	^ name
]

{ #category : #accessing }
GtBlocSubThemeModel >> subTheme [
	^ subTheme
]

{ #category : #accessing }
GtBlocSubThemeModel >> subTheme: aBlSubTheme name: aSubThemeName [
	self
		assert: [ aBlSubTheme isKindOf: BlSubTheme ]
		description: [ 'Provided SubTheme must inhertit from ', BlSubTheme name ].

	name := aSubThemeName.
	subTheme := aBlSubTheme.
	subThemeClass := aBlSubTheme class.
	
	themeableAssignments := self computeThemeableAssignments.
	constantAssignments := self computeConstantAssignments.
	themeableValues := self computeThemeableValues
]

{ #category : #accessing }
GtBlocSubThemeModel >> themeableValues [
	^ themeableValues
]
