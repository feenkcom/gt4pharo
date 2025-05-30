Class {
	#name : #BrGlamorousThemeColorsEditorElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'colors',
		'colorsClass',
		'colorNames',
		'initializationAst',
		'initializationAssignments',
		'editorsPane',
		'editorId',
		'nameId'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
BrGlamorousThemeColorsEditorElement >> colors [
	^ colors
]

{ #category : #accessing }
BrGlamorousThemeColorsEditorElement >> colors: aBlThemeColors [
	colors := aBlThemeColors.
	colorsClass := colors class.
	colorNames := (colorsClass allInstVarNames reject: [ :each | each = #theme ]).
	
	initializationAst := GtPharoParser parse: (colorsClass >> #initialize) sourceCode.
	initializationAssignments := ((Array streamContents: [ :s | initializationAst allNodesDo: [ :each | each isAssignment ifTrue: [ s nextPut: each ] ] ]) collect: [ :each | each variable variableName -> each value ]) asDictionary.
	
	editorsPane addChildren: (colorNames collect: [ :eachName | self editorForColorNamed: eachName ])
]

{ #category : #'as yet unclassified' }
BrGlamorousThemeColorsEditorElement >> compileChanges [
	colorsClass compile: self generateInitializeSource
]

{ #category : #accessing }
BrGlamorousThemeColorsEditorElement >> editorForColorNamed: aColorName [
	| container colorName colorSource colorSourceCoder colorSourceCoderElement |
	
	colorName := BrLabel new
		id: nameId;
		aptitude: BrGlamorousLabelAptitude;
		hMatchParent;
		text: aColorName.

	colorSource := initializationAssignments
		at: aColorName
		ifPresent: [ :anAssignment | anAssignment source ]
		ifAbsent: [ '' ].
		
	colorSourceCoder := GtPharoSnippetCoder forSource: colorSource.
	colorSourceCoder
		when: GtCoderEvaluationAnnouncement
		do: [ :anAnnouncement |
			anAnnouncement evaluationResult isSuccess
				ifTrue: [
					self
						onColor: aColorName
						changedTo: anAnnouncement evaluationResult value  ] ].
	
	colorSourceCoderElement := GtSourceCoderEditorElement new
		id: editorId;
		textualCoderViewModel: colorSourceCoder asCoderViewModel.
	colorSourceCoderElement
		hMatchParent;
		vFitContent.

	container := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	
	container addChild: colorName.
	container addChild: colorSourceCoderElement.
	
	^ container
]

{ #category : #'as yet unclassified' }
BrGlamorousThemeColorsEditorElement >> generateInitializeSource [
	^ String streamContents: [ :s | 
		s
			nextPutAll: 'initialize'; cr;
			tab; nextPutAll: 'super initialize.'; cr; cr.
			
		editorsPane children do: [ :each |
			| eachName eachSource | 
			eachName := (each childWithId: nameId) text asString.
			eachSource := (each childWithId: editorId) textualCoderViewModel sourceText asString.
			
			eachSource ifEmpty: [ eachSource := 'nil' ].
			
			s tab; nextPutAll: eachName; nextPutAll: ' := '; nextPutAll: eachSource; nextPutAll: '.'; cr ] ]
]

{ #category : #'as yet unclassified' }
BrGlamorousThemeColorsEditorElement >> initialize [
	super initialize.
	
	self matchParent.
	
	nameId := #'theme-colors--name'.
	editorId := #'theme-colors--coder'.
	
	editorsPane := BrVerticalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 2.
	
	self addChild:(BrScrollPane new
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		matchParent;
		content: editorsPane)
]

{ #category : #accessing }
BrGlamorousThemeColorsEditorElement >> onColor: aColorName changedTo: aColor [
	colors instVarNamed: aColorName put: aColor.
	colors theme themeModified
]
