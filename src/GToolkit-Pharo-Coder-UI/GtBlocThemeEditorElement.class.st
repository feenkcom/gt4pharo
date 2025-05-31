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
		'themeModel',
		'headerId'
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
GtBlocThemeEditorElement >> createCollapsedHeaderForThemeableValue: eachThemeableValue [
	| header |
	
	header := self createProtoHeaderForThemeableValue: eachThemeableValue.
	
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createEditorForThemeableValue: aThemeableValue assignment: eachValueAssignment [
	| container valueSourceCoder valueSourceCoderElement valueSourceCoderViewModel |
	container := BrVerticalPane new
		hMatchParent;
		vFitContent.
 
	container addChild: (BrButton new
		fitContent;
		beSmallSize;
		margin: (BlInsets top: 6 left: 3);
		label: eachValueAssignment subThemeMethod printString;
		aptitude: BrGlamorousMetadataLabelAptitude + (BrLazyStyleCommonAptitude new hovered: [ :s :t | s border: t button hoveredBorderColor ]);
		action: [ :aButton |
			aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: eachValueAssignment subThemeMethod)]).
	
	valueSourceCoder := GtPharoSnippetCoder forSource: (aThemeableValue valueAssignmentSourceCodeOf: eachValueAssignment).
	
	valueSourceCoderViewModel := valueSourceCoder asCoderViewModel.
	valueSourceCoderViewModel selfObject: aThemeableValue subThemeModel subTheme.
	
	valueSourceCoderElement := GtSourceCoderEditorElement new
		id: editorId;
		hMatchParent;
		vFitContent;
		padding: (BlInsets top: 2 bottom: 2 left: 4 right: 4);
		"addAptitude: (BrLazyStyleCommonAptitude new
			default: [ :s :t | s border: (BlBorder paint: t editor borderColor) ];
			focused: [ :s :t | s border: (BlBorder paint: t editor focusedBorderColor) ]);"
		textualCoderViewModel: valueSourceCoderViewModel.

	container addChild: valueSourceCoderElement.
	
	^ container
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createEditorsForSubTheme: aSubThemeModel [
	| container |
	
	container := BrVerticalPane new.
	container
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 3).

	container addChild: (BrLabel new
		aptitude: BrGlamorousMetadataLabelAptitude;
		text: aSubThemeModel name).

	container addChildren: (aSubThemeModel themeableValues collect: [ :eachThemeableValue | self createExpanderForThemeableValue: eachThemeableValue ]).
	
	^ container
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createExpandedHeaderForThemeableValue: eachThemeableValue [
	| header |
	header := self createProtoHeaderForThemeableValue: eachThemeableValue.
	header
		addChild: (BrFrame new
				hMatchParent;
				vExact: 0).
	header
		addChild: (BrButton new
				beSmallSize;
				aptitude: BrGlamorousMetadataLabelAptitude + (BrLazyStyleCommonAptitude new hovered: [ :s :t | s border: t button hoveredBorderColor ]);
				vFitContent;
				label: eachThemeableValue printShortThemeableValue;
				action: [ :aButton | aButton phlow spawnObject: eachThemeableValue themeableValue ]).
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createExpanderExpandedForThemeableValue: eachThemeableValue [
	| container issuesContainer assignmentsContainer |
	
	container := BrVerticalPane new
		hMatchParent;
		vFitContent.

	container addChild: (self createExpandedHeaderForThemeableValue: eachThemeableValue).
	
	issuesContainer := BrVerticalPane new
		hMatchParent;
		vFitContent;
		margin: (BlInsets left: 3).

	eachThemeableValue issues do: [ :eachIssue |
		issuesContainer addChild: (self createIssueSummary: eachIssue) ].
		
	container addChild: issuesContainer.

	assignmentsContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.
	
	eachThemeableValue valueAssignments
		ifEmpty: [
			assignmentsContainer addChild: (BrLabel new
				aptitude: BrGlamorousSummaryLabelAptitude;
				text: 'Not initialized yet') ].
	
	eachThemeableValue valueAssignments do: [ :eachAssignment |
		assignmentsContainer addChild: (self createEditorForThemeableValue: eachThemeableValue assignment: eachAssignment) ].

	container addChild: assignmentsContainer.
		
	^ container 
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createExpanderForThemeableValue: eachThemeableValue [
	| anExpander anExpanderBackground |
	
	anExpanderBackground := eachThemeableValue issues
		ifEmpty: [ self theme default lightBorderColor ]
		ifNotEmpty: [ :theIssues |
			(theIssues anySatisfy: [ :eachIssue | eachIssue isSeriousIssue ])
				ifTrue: [ self theme status errorBorderColor ]
				ifFalse: [ self theme status failureBorderColor ] ].
	
	anExpander := BrExpander new
		hMatchParent;
		vFitContent;
		margin: (BlInsets top: 3 bottom: 3).

	anExpander
		header: [ self createCollapsedHeaderForThemeableValue: eachThemeableValue ];
		content: [ self createExpanderExpandedForThemeableValue: eachThemeableValue ];
		aptitude: (GtCoderExpanderAptitude new borderPaint: anExpanderBackground).

	^ anExpander
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createIssueSummary: eachIssue [
	^ BrButton new
		aptitude: (BrGlamorousLabelAptitude new foreground: self theme status errorBorderColor);
		label: eachIssue description;
		fitContent;
		action: [ :aButton | aButton phlow spawnObject: eachIssue ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createProtoHeaderForThemeableValue: eachThemeableValue [
	| header |
	header := BrHorizontalPane new
			hMatchParent;
			vFitContent;
			id: #'theme-editor--value-header'.

	header
		when: BlClickEvent
		do: [ :anEvent |
			anEvent currentTarget
				allParentsDetect: [ :each | each isKindOf: BrExpander ]
				ifFound: [ :anExpander |
					anEvent consumed: true.
					anExpander toggleExpanded ] 
				ifNone: [ ] ].

	header
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				margin: (BlInsets left: 3);
				text: eachThemeableValue valueName).

	eachThemeableValue themeableValue isColor
		ifTrue: [ header
				addChild: (BrButton new
						exact: 12 @ 12;
						margin: (BlInsets
								top: 4
								left: 4
								bottom: 0
								right: 4);
						background: eachThemeableValue themeableValue;
						action: [ :aButton | aButton phlow spawnObject: eachThemeableValue themeableValue ]) ].
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> editTheme: aBlTheme [
	themeModel := GtBlocThemeModel new initializeForTheme: aBlTheme.
	
	editorsPane addChildren: (themeModel subThemeModels collect: [ :eachSubThemeModel | self createEditorsForSubTheme: eachSubThemeModel ])
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
	
	nameId := #'theme-colors--name'.
	editorId := #'theme-colors--coder'.
	headerId := #'theme-editor--value-header'.
	
	editorsPane := BrVerticalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 2.
	
	self addChild:(BrScrollPane new
		padding: (BlInsets all: 10);
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		matchParent;
		content: editorsPane)
]

{ #category : #accessing }
GtBlocThemeEditorElement >> onColor: aColorName changedTo: aColor [
	colors instVarNamed: aColorName put: aColor.
	colors theme themeModified
]
