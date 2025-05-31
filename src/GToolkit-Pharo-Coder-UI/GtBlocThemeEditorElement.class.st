"
```
GtBlocThemeEditorElement new editTheme: BlTheme default
```
"
Class {
	#name : #GtBlocThemeEditorElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'colors',
		'colorsClass',
		'colorNames',
		'initializationAst',
		'initializationAssignments',
		'editorsPane',
		'editorId',
		'nameId',
		'themeToEdit',
		'themeToEditClass',
		'subThemes',
		'themeModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtBlocThemeEditorElement >> colors [
	^ colors
]

{ #category : #accessing }
GtBlocThemeEditorElement >> colors: aBlThemeColors [
	colors := aBlThemeColors.
	colorsClass := colors class.
	colorNames := (colorsClass allInstVarNames reject: [ :each | each = #theme ]).
	
	initializationAst := GtPharoParser parse: (colorsClass >> #initialize) sourceCode.
	initializationAssignments := ((Array streamContents: [ :s | initializationAst allNodesDo: [ :each | each isAssignment ifTrue: [ s nextPut: each ] ] ]) collect: [ :each | each variable variableName -> each value ]) asDictionary.
	
	editorsPane addChildren: (colorNames collect: [ :eachName | self editorForColorNamed: eachName ])
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> compileChanges [
	colorsClass compile: self generateInitializeSource
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createEditorForSubTheme: aSubThemeModel [
	| container |
	
	container := BrVerticalPane new.
	container
		hMatchParent;
		vFitContent.

	container addChild: (BrLabel new
		aptitude: BrGlamorousMetadataLabelAptitude;
		text: aSubThemeModel name).

	container addChildren: (aSubThemeModel themeableValues collect: [ :eachThemeableValue | self createEditorForThemeableValue: eachThemeableValue ]).
	
	^ container
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createEditorForThemeableValue: eachThemeableValue [
	| container assignmentsContainer |
	
	container := BrVerticalPane new
		hMatchParent;
		vFitContent;
		addAptitude: (BrGlamorousFocusableShadowAptitude);
		background: self theme default contentBackground;
		padding: (BlInsets all: 5);
		margin: (BlInsets all: 5).
		
	container addChild: (self createHeaderForThemeableValue: eachThemeableValue).
		
	assignmentsContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.
	
	eachThemeableValue valueAssignments
		ifEmpty: [
			assignmentsContainer addChild: (BrLabel new
				aptitude: BrGlamorousSummaryLabelAptitude;
				text: 'Not initialized yet') ].
	
	eachThemeableValue valueAssignments do: [ :eachAssignment |
		assignmentsContainer addChild: (self createEditorForThemeableValueAssignment: eachAssignment) ].

	container addChild: assignmentsContainer.
		
	^ container 
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createEditorForThemeableValueAssignment: eachValueAssignment [
	| container valueSourceCoder valueSourceCoderElement |
	container := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	
	valueSourceCoder := GtPharoSnippetCoder forSource: eachValueAssignment valueSourceCode.
	
	valueSourceCoderElement := GtSourceCoderEditorElement new
		id: editorId;
		hMatchParent;
		vFitContent;
		addAptitude: (BrLazyStyleCommonAptitude new
			default: [ :s :t | s border: (BlBorder paint: t editor borderColor) ];
			focused: [ :s :t | s border: (BlBorder paint: t editor focusedBorderColor) ]);
		textualCoderViewModel: valueSourceCoder asCoderViewModel.

	container addChild: valueSourceCoderElement.
	
	^ container
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createHeaderForThemeableValue: eachThemeableValue [
	| header |
	
	header := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	
	header addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		hMatchParent;
		text: eachThemeableValue valueName).
		
	header addChild: (BrLabel new
		aptitude: BrGlamorousSummaryLabelAptitude;
		hMatchParent;
		text: eachThemeableValue themeableValue printString).
		
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> editTheme: aBlTheme [
	themeModel := GtBlocThemeModel new initializeForTheme: aBlTheme.
	
	editorsPane addChildren: (themeModel subThemeModels collect: [ :eachSubThemeModel | self createEditorForSubTheme: eachSubThemeModel ])
]

{ #category : #accessing }
GtBlocThemeEditorElement >> editorForColorNamed: aColorName [
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
GtBlocThemeEditorElement >> generateInitializeSource [
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
GtBlocThemeEditorElement >> initialize [
	super initialize.
	
	self matchParent.
	self background: self theme default backdropBackground.
	self padding: (BlInsets all: 10).
	
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
GtBlocThemeEditorElement >> onColor: aColorName changedTo: aColor [
	colors instVarNamed: aColorName put: aColor.
	colors theme themeModified
]
