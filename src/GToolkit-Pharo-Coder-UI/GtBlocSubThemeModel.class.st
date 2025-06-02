Class {
	#name : #GtBlocSubThemeModel,
	#superclass : #Object,
	#instVars : [
		'subTheme',
		'subThemeClass',
		'constantAssignments',
		'subThemeName',
		'themeProperties'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #generation }
GtBlocSubThemeModel class >> generateInitializeColorsSourceCode: theThemeableValues for: aSubThemeClass [
	^ String streamContents: [ :s |
		s nextPutAll: 'initializeColors'; cr.
		s tab nextPutAll: 'super initializeColors.'; cr; cr.
	
		theThemeableValues do: [ :eachValue |
			| valueToGenerate |
			valueToGenerate := eachValue.
		
			valueToGenerate valueAssignments
				select: [ :eachAssignment | eachAssignment subThemeClass = aSubThemeClass and: [ eachAssignment subThemeSelector = #initializeColors ] ]
				thenDo: [ :eachAssignment |
					s tab nextPutAll: valueToGenerate propertyName; nextPutAll: ' := '.
					s nextPutAll: eachAssignment valueSourceCode; nextPutAll: '.'; cr; cr ] ] ]
]

{ #category : #generation }
GtBlocSubThemeModel class >> generateInitializeConstantsSourceCode: theConstantAssignments for: aSubThemeClass [
	^ String streamContents: [ :s |
		| allConstantAssignments |
		s nextPutAll: 'initializeConstants'; cr.
		s tab nextPutAll: 'super initializeConstants.'; cr; cr.
	
		allConstantAssignments := OrderedCollection new.
		theConstantAssignments valuesDo: [ :eachAssignments |
			eachAssignments
				select: [ :eachAssignment | eachAssignment subThemeClass = aSubThemeClass ]
				thenDo: [ :eachAssignment | allConstantAssignments add: eachAssignment ] ].
				
		allConstantAssignments := allConstantAssignments sorted: [ :a :b | a valueName < b valueName ].
	
		allConstantAssignments do: [ :eachAssignment |
			s tab.
			s nextPutAll: ('self constantAt: #{1} put: ({2}).' format: {
				eachAssignment valueName.
				eachAssignment valueSourceCode
			}).
			s cr
		] ]
]

{ #category : #generation }
GtBlocSubThemeModel class >> generateInitializeThemeableSourceCode: theThemeableValues for: aSubThemeClass [
	^ String streamContents: [ :s |
		s nextPutAll: 'initializeThemeable'; cr.
		s tab nextPutAll: 'super initializeThemeable.'; cr; cr.
	
		theThemeableValues do: [ :eachValue |
			eachValue valueAssignments
				select: [ :eachAssignment | eachAssignment subThemeClass = aSubThemeClass and: [ eachAssignment subThemeSelector = #initializeThemeable ] ]
				thenDo: [ :eachAssignment |
					s tab nextPutAll: eachValue propertyName; nextPutAll: ' := '.
					s nextPutAll: eachAssignment valueSourceCode; nextPutAll: '.'; cr; cr ] ] ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> computeConstantAssignments [
	<return: #OrderedDictionary>
	| assignments currentClass|
	
	assignments := OrderedCollection new.
	
	currentClass := subThemeClass.
	[ currentClass = BlSubTheme ] whileFalse: [
		assignments addAll: (self detectConstantAssignmentsIn: currentClass).
		currentClass := currentClass superclass ].
	
	^ assignments groupedBy: [ :each | each valueName ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> computeThemeProperties: themeableAssignments [
	| valueNames |
	
	valueNames := subThemeClass allInstVarNames copyWithoutAll: BlSubTheme instVarNames.
	
	^ valueNames collect: [ :eachVarName | 
		(GtBlocThemeProperty new
			subThemeModel: self;
			propertyName: eachVarName;
			propertyValue: (subTheme instVarNamed: eachVarName);
			valueAssignments: (themeableAssignments at: eachVarName ifAbsent: [ #() ]);
			constantAssignments: (constantAssignments at: eachVarName ifAbsent:  [ #() ])) ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> computeThemeableAssignments [
	<return: #OrderedDictionary>
	| assignments currentClass|
	
	assignments := OrderedCollection new.
	
	currentClass := subThemeClass.
	[ currentClass = BlSubTheme ] whileFalse: [
		assignments addAll: (self detectThemeableAssignmentsIn: currentClass).
		currentClass := currentClass superclass ].
	
	^ assignments groupedBy: [ :each | each valueName ]
]

{ #category : #'api - constants' }
GtBlocSubThemeModel >> constantAssignments [
	^ constantAssignments
]

{ #category : #'api - constants' }
GtBlocSubThemeModel >> defineConstantNamed: aValueName valueAst: aValueAst inClass: aSubThemeClass [
	<return: #GtBlocThemeConstantAssignment>
	| newConstant |
	
	newConstant := GtBlocThemeConstantAssignment new
		subThemeClass: aSubThemeClass;
		subThemeSelector: #initializeConstants;
		valueName: aValueName;
		valueAst: aValueAst;
		yourself.

	constantAssignments
		at: aValueName
		ifPresent: [ :aCollectionOfAssignments | aCollectionOfAssignments add: newConstant ]
		ifAbsentPut: [ OrderedCollection with: newConstant ].
		
	^ newConstant
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
				ast := RBParser parseMethod: initializeMethod sourceCode.
				ast nodesDo: [ :each |
					(each isMessage and: [ each selector = #constantAt:put: ])
						ifTrue: [
							assignments add: (GtBlocThemeConstantAssignment new
								subThemeClass: aSubThemeClass;
								subThemeSelector: eachSelector;
								valueName: each arguments first value;
								valueAst: each arguments second) ] ] ] ].
	
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
			ast := RBParser parseMethod: initializeMethod sourceCode.
			ast nodesDo: [ :each |
				each isAssignment
					ifTrue: [
						assignments add: (GtBlocThemeValueAssignment new
							subThemeClass: aSubThemeClass;
							subThemeSelector: eachSelector;
							valueName: each variable name;
							valueAst: each value) ] ] ] ].
	
	^ assignments
]

{ #category : #generation }
GtBlocSubThemeModel >> generateThemeMethods [
	| namespaceModel |
	
	namespaceModel := RBNamespace new.
	
	self  withAllSubThemeClassSuperclasses
		do: [ :eachClass | 
			namespaceModel
						compile: (self  class
						generateInitializeThemeableSourceCode: self themeProperties for: eachClass)
						in: eachClass
						classified: 'initialization'.
						
			namespaceModel
						compile: (self class
						generateInitializeColorsSourceCode: self themeProperties for: eachClass)
						in: eachClass
						classified: 'initialization'.

			namespaceModel
						compile: (self class
						generateInitializeConstantsSourceCode: self constantAssignments for: eachClass)
						in: eachClass
						classified: 'initialization' ].
	
	^ namespaceModel
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> gtDisplayOn: stream [
	stream nextPutAll: self subThemeName
]

{ #category : #views }
GtBlocSubThemeModel >> gtThemePropertiesFor: aView [
	<gtView>
	themeProperties ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Properties';
		priority: 5;
		items: [ themeProperties ];
		column: 'Name' text: [ :each | each propertyName ];
		column: 'Value' text: [ :each | each propertyValue ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> postCopy [
	themeProperties := themeProperties copy.
	constantAssignments := constantAssignments collect: [ :each | each copy ].
]

{ #category : #accessing }
GtBlocSubThemeModel >> replaceThemeProperty: aThemeableValue with: anotherValue [
	| index |
	index:= self themeProperties indexOf: aThemeableValue.
	self themeProperties at: index put: anotherValue.
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

	subThemeName := aSubThemeName.
	subTheme := aBlSubTheme.
	subThemeClass := aBlSubTheme class.
	
	constantAssignments := self computeConstantAssignments.
	themeProperties := self computeThemeProperties: self computeThemeableAssignments.
]

{ #category : #accessing }
GtBlocSubThemeModel >> subThemeClass [
	^ subThemeClass
]

{ #category : #accessing }
GtBlocSubThemeModel >> subThemeName [
	^ subThemeName
]

{ #category : #accessing }
GtBlocSubThemeModel >> themeProperties [
	^ themeProperties
]

{ #category : #accessing }
GtBlocSubThemeModel >> withAllSubThemeClassSuperclasses [
	^ Array streamContents: [ :s | self withAllSubThemeClassSuperclassesDo: [ :eachClass | s nextPut: eachClass ] ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> withAllSubThemeClassSuperclassesDo: aBlock [
	| currentClass |
	currentClass := subThemeClass.
	[ currentClass = BlSubTheme ]
		whileFalse: [
			aBlock value: currentClass.
			currentClass := currentClass superclass ]
]
