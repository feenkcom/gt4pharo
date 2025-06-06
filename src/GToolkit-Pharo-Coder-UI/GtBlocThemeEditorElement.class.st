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

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createCollapsedHeaderForProperty: aTypedThemeProperty [
	| header |
	
	header := self createProtoHeaderForProperty: aTypedThemeProperty.
	
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createEditorForProperty: aTypedThemeProperty assignment: eachValueAssignment [
	| assignmentForCoder container  valueSourceCoderViewModel modificationIndicator valueSourceCoderElement editorContainer |
	
	assignmentForCoder := (aTypedThemeProperty transformAssignmentForCoder: eachValueAssignment)
		asCoderAssignmentFor: aTypedThemeProperty.
	
	container := BrVerticalPane new
		hMatchParent;
		vFitContent.
 
	container addChild: (BrButton new
		fitContent;
		beSmallSize;
		margin: (BlInsets top: 6 left: 3);
		label: assignmentForCoder subThemeMethod printString;
		aptitude: BrGlamorousMetadataLabelAptitude + (BrLazyStyleCommonAptitude new hovered: [ :s :t | s border: t button hoveredBorderColor ]);
		action: [ :aButton |
			aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: assignmentForCoder subThemeMethod)]).
	
	editorContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent.
		
	modificationIndicator := self newModificationIndicator.
	modificationIndicator visibility: BlVisibility gone.
	editorContainer addChild: modificationIndicator.
	
	valueSourceCoderViewModel := aTypedThemeProperty
		createCoderViewModel: assignmentForCoder.
		
	valueSourceCoderViewModel
		when: GtTextualCoderViewModelTextChanged
		do: [ modificationIndicator asyncPromise promise: valueSourceCoderViewModel isTextModifiedPromise  ].
	
	valueSourceCoderElement := GtSourceCoderEditorElement new
		id: editorId;
		hMatchParent;
		vFitContent;
		padding: (BlInsets top: 2 bottom: 2 left: 4 right: 4);
		textualCoderViewModel: valueSourceCoderViewModel.

	editorContainer addChild: valueSourceCoderElement.
	container addChild: editorContainer.
	
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
		text: aSubThemeModel subThemeName).

	container addChildren: (aSubThemeModel themeProperties collect: [ :eachThemeableValue | self createExpanderForProperty: eachThemeableValue valueType ]).
	
	^ container
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createExpandedHeaderForProperty: aTypedThemeProperty [
	| header |
	header := self createProtoHeaderForProperty: aTypedThemeProperty.
	header
		addChild: (BrFrame new
				hMatchParent;
				vExact: 0).
	header
		addChild: (BrButton new
				beSmallSize;
				aptitude: BrGlamorousMetadataLabelAptitude + (BrLazyStyleCommonAptitude new hovered: [ :s :t | s border: t button hoveredBorderColor ]);
				vFitContent;
				label: aTypedThemeProperty printShortThemeableValue;
				action: [ :aButton | aButton phlow spawnObject: aTypedThemeProperty propertyValue ]).
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createExpanderExpandedForProperty: aTypedThemeProperty [
	| container issuesContainer assignmentsContainer |
	
	container := BrVerticalPane new
		hMatchParent;
		vFitContent.

	container addChild: (self createExpandedHeaderForProperty: aTypedThemeProperty).
	
	issuesContainer := BrVerticalPane new
		hMatchParent;
		vFitContent;
		margin: (BlInsets left: 3).

	aTypedThemeProperty issues do: [ :eachIssue |
		issuesContainer addChild: (self createIssueSummary: eachIssue) ].
		
	container addChild: issuesContainer.

	assignmentsContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.
	
	aTypedThemeProperty valueAssignments
		ifEmpty: [
			assignmentsContainer addChild: (BrLabel new
				aptitude: BrGlamorousSummaryLabelAptitude;
				text: 'Not initialized yet') ].
	
	aTypedThemeProperty valueAssignments do: [ :eachAssignment |
		assignmentsContainer addChild: (self createEditorForProperty: aTypedThemeProperty assignment: eachAssignment) ].

	container addChild: assignmentsContainer.
		
	^ container 
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createExpanderForProperty: aTypedThemeProperty [
	| anExpander anExpanderBackground |
	
	anExpanderBackground := aTypedThemeProperty issues
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
		header: [ self createCollapsedHeaderForProperty: aTypedThemeProperty ];
		content: [ self createExpanderExpandedForProperty: aTypedThemeProperty ];
		aptitude: (GtCoderExpanderAptitude new borderPaint: anExpanderBackground).

	^ anExpander
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createIssueSummary: eachIssue [
	| container |
	
	container := BrHorizontalPane new
		vFitContent;
		hMatchParent.
	
	container addChild: (BrButton new
		aptitude: (BrGlamorousLabelAptitude new foreground: self theme status errorBorderColor);
		label: eachIssue description;
		fitContent;
		action: [ :aButton | aButton phlow spawnObject: eachIssue ]).
	
	eachIssue canFixIt
		ifTrue: [
			container addChild: (BrButton new
				beSmallSize;
				label: 'Fix it';
				icon: BrGlamorousVectorIcons repair ;
				fitContent;
				margin: (BlInsets left: 5);
				aptitude: BrGlamorousButtonWithLabelAndIconAptitude;
				action: [ :aButton | aButton phlow spawnObject: eachIssue fixIt ]) ].
	
	^ container
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createProtoHeaderForProperty: eachProperty [
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
				text: eachProperty propertyName).

	eachProperty propertyValue isColor
		ifTrue: [ header
				addChild: (BrButton new
						theme: themeModel theme;
						exact: 12 @ 12;
						margin: (BlInsets
								top: 4
								left: 4
								bottom: 0
								right: 4);
						background: eachProperty propertyValue;
						action: [ :aButton | aButton phlow spawnObject: eachProperty themeableValue ]) ].
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> editTheme: aBlTheme [
	themeModel := GtBlocThemeModel new initializeForTheme: aBlTheme.
	
	editorsPane addChildren: (themeModel subThemeModels collect: [ :eachSubThemeModel | self createEditorsForSubTheme: eachSubThemeModel ])
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

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> newModificationIndicator [
	^ BlElement new
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignLeft.
			c horizontal exact: 3.
			c vertical matchParent ];
		preventMeAndChildrenMouseEvents;
		background: self theme status changesBackgroundColor;
		id: GtTextualCoderModificationIndicatorId;
		withAsyncPromiseDo: [ :anElementPromise |
			anElementPromise
				whenSuccess: [ :anIndicator :isModified |
					anIndicator visibility: (isModified
						ifTrue: [ BlVisibility visible ]
						ifFalse: [ BlVisibility gone ]) ] ]
]
