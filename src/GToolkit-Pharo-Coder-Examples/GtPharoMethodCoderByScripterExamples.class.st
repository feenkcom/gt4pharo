Class {
	#name : #GtPharoMethodCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coder - Method'
}

{ #category : #'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> astMatchesHasUnderlineAttribute [
	<gtExample>
	<noTest>
	| filter aScripter |

	filter := GtSearchIntersectionFilter new
		filter: (GtSearchFixedMethodsFilter new methods:  { thisContext method })
		filter: '`@a asCoder' gtASTMatches.

	aScripter := self scripterForBlock: [ filter asCoder allCoders first ].

	self
		checkFor: aScripter
		textAttributesAt: (thisContext method sourceCode indexOfSubCollection: 'filter asCoder')
		anySatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].

	self
		checkFor: aScripter
		numberfOfTextAttributes: 14
		ofType: BlTextDecorationAttribute.

	^ aScripter
]

{ #category : #'examples - basic' }
GtPharoMethodCoderByScripterExamples >> basicMethodCoder [
	<gtExample>
	| aCoder |
	aCoder := GtPharoMethodCoder new.
	self assert: aCoder selector isNil.
	self assert: aCoder behavior equals: UndefinedObject.
	self assert: aCoder protocol isNil.
	self assert: aCoder currentSourceString isString.
	self assert: aCoder currentSourceString isEmpty.
	^ aCoder
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethod [
	<gtExample>

	^ GtPharoMethodCoderExamples >> #?
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self binaryMethod.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ self binaryMethodCoder ].
	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_CollapsedFromUI [
	<gtExample>
	| aScripter |

	aScripter := self binaryMethodCoderUI.
	aScripter substep: 'Collapse and Check Coder' do: [ :aStep |
		aStep click
			label: 'Click on Expander';
			onChildAt: 1;
			play.
		
		aStep assert
			label: 'Assert Coder Editor Text';
			value: [ :label | label text asString ] equals: '?';
			id: GtSourceCoderCollapsedTextId;
			play.

		aStep assert 
			label: 'Assert Coder UI Is Collapsed';
			satisfies: [ :aCoderElement | aCoderElement isExpanded not ];
			play ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Collapsed_BreadcrumbContent [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.
	
	aScripter checks: 'Check Breadcrumb' do: [ :aStep | 
		aStep assert 
			label: 'Assert Breadcrumb Package Name';
			value: [ :aButton | aButton label asString ]
				equals: [ GtPharoMethodCoderExamples package name ];
			onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
			onChildAt: 1;
			play.
			
		aStep assert 
			label: 'Assert Breadcrumb Class Name';
			value: [ :aButton | aButton label asString ] equals: [ GtPharoMethodCoderExamples name ];
			onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
			onChildAt: 3;
			play ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Collapsed_BreadcrumbOnClassNameClick [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.
	aScripter
		substeps: 'Click On Breadcrumb'
		do: [ :aStep | 
			aStep click
				label: 'Click On Class Name';
				onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
				onChildAt: 3;
				play.

			aStep assert
				label: 'Assert Triggered Spawn Object Event';
				satisfies: [ :theScripter | 
					theScripter events reversed
						detectEventOfClass: GtPhlowObjectToSpawn
						ifFound: [ :theEvent | 
							theEvent object = self binaryMethod
								and: [ theEvent tool isKindOf: GtMethodCoderTool ] ]
						ifNone: [ AssertionFailure
								signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
				onScripter;
				play ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Collapsed_BreadcrumbOnPackageClick [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.
	aScripter
		substeps: 'Click On Breadcrumb'
		do: [ :aStep | 
			aStep click
				label: 'Click On Package Name';
				onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
				onChildAt: 1;
				play.

			aStep assert
				label: 'Assert Triggered Spawn Object Event';
				satisfies: [ :theScripter | 
					theScripter events reversed
						detectEventOfClass: GtPhlowObjectToSpawn
						ifFound: [ :theEvent | 
							theEvent object class = RPackage
								and: [ theEvent object name = self class package name ] ]
						ifNone: [ AssertionFailure
								signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
				onScripter;
				play ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_ExpandedFromUI [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.
	self expandFromUI: aScripter method: self binaryMethod.

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_ExpandedFromUI_CheckActionButtons [
	<gtExample>
	| aScripter |

	aScripter := self binaryMethodCoderUI_ExpandedFromUI.
	self 
		checkFor: aScripter 
		numberOfMainActions: 4
		contextAction: 0.

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_ExpandedFromUI_CodeStyle [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_ExpandedFromUI.
	aScripter
		checks: 'Check Expanded Source Code Style'
		do: [ :aStep | 
			aStep assert
				label: 'Assert Method Name Attributes';
				anySatisfy: [ :aTextAttribute | aTextAttribute = BlFontWeightAttribute bold ];
				id: GtSourceCoderEditorId;
				onBrTextEditor;
				onBrTextEditorText;
				onTextAttributesAt: 1;
				play.
			aStep assert
				label: 'Assert Comment Attributes';
				anySatisfy: [ :aTextAttribute | aTextAttribute = (BlTextForegroundAttribute new paint: Color gray darker) ];
				id: GtSourceCoderEditorId;
				onBrTextEditor;
				onBrTextEditorText;
				onTextAttributesAt: 13;
				play ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Expanded_BreadcrumbContent [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI.
	aScripter checks: 'Check Breadcrumb' do: [ :aStep | 
	
		aStep assert 
			label: 'Assert Breadcrumb Package Name';
			value: [ :aButton | aButton label asString ] equals: [ GtPharoMethodCoderExamples package name ];
			onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
			onChildAt: 1;
			play.
			
		aStep  assert 
			label: 'Assert Breadcrumb Class Name';
			value: [ :aButton | aButton label asString ] equals: [ GtPharoMethodCoderExamples name ];
			onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
			onChildAt: 3;
			play ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Expanded_BreadcrumbOnClassNameClick [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI.
	aScripter
		substeps: 'Click On Breadcrumb'
		do: [ :aStep | 
			aStep click
				label: 'Click On Class Name';
				onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
				onChildAt: 3;
				play.

			aStep assert
				label: 'Assert Triggered Spawn Object Event';
				satisfies: [ :theScripter | 
					theScripter events reversed
						detectEventOfClass: GtPhlowObjectToSpawn
						ifFound: [ :theEvent | 
							theEvent object = self binaryMethod
								and: [ theEvent tool isKindOf: GtMethodCoderTool ] ]
						ifNone: [ AssertionFailure
								signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
				onScripter;
				play ].
	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Expanded_BreadcrumbOnPackageClick [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI.
	aScripter
		substeps: 'Click On Breadcrumb'
		do: [ :aStep | 
			aStep click
				label: 'Click On Package Name';
				onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
				onChildAt: 1;
				play.

			aStep assert
				label: 'Assert Triggered Spawn Object Event';
				satisfies: [ :theScripter | 
					theScripter events reversed
						detectEventOfClass: GtPhlowObjectToSpawn
						ifFound: [ :theEvent | 
							theEvent object class = RPackage
								and: [ theEvent object name = self class package name ] ]
						ifNone: [ AssertionFailure
								signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
				onScripter;
				play ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_WithoutExampleActions [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_ExpandedFromUI.
	self 
		checkFor: aScripter 
		numberOfMainActions: 4
		contextAction: 0.
	self checkFor: aScripter absenceOfContextActionNamed: 'Play'.

	^ aScripter
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter absenceOfContextActionNamed: anActionName [
	<gtExample>
	aScripter assert
		label: 'Assert Context Action Existence Named ' , anActionName asString;
		nonSatisfies: [ :aContextActions | 
			aContextActions title = anActionName translated
				and: [ aContextActions action method = (GtPharoMethodCoder >> #exampleAstFor:into:) ] ];
		onModel;
		onChildFromMessage: #contextActions;
		play
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep discardButtonExists: doesExist [
	<gtExample>
	| aCheck |

	aCheck := aScripterOrStep check
		id: GtMethodCoderDiscardChangesActionId.

	doesExist
		ifTrue: [
			aCheck
				exists;
				label: 'Check discard button exists' ]
		ifFalse: [
			aCheck
				notExists;
				label: 'Check discard button does not exist' ].

	aCheck play
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter existenceOfContextActionNamed: anActionName [
	<gtExample>
	aScripter assert
		label:
			'Assert Context Action Existence Named ' , anActionName asString;
		anySatisfy: [ :aContextActions | 
			aContextActions title = anActionName translated and: [ 
					aContextActions action blocDefiningMethod
					= (GtPharoMethodCoder >> #exampleAstFor:into:) ] ];
		onModel;
		onChildFromMessage: #contextActions;
		play
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter numberOfMainActions: aMainActionsCount contextAction: anAddonsActionsCount [
	<gtExample>
	aScripter substeps: 'Check Available Action Buttons' do: [ :aStep |
		aStep assert 
			label: 'Assert number of main actions';
			childrenCount: aMainActionsCount;
			onBreadthFirstChildOfClass: GtCoderActionsElement;
			onChildAt: 1;
			play.

		aStep assert 
			label: 'Assert number of addons actions';
			childrenCount: anAddonsActionsCount;
			onBreadthFirstChildOfClass: GtCoderActionsElement;
			onChildAt: 3;
			play ]
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep numberfOfTextAttributes: aNumber ofType: aClass [
	aScripterOrStep assert
		label: 'Assert Editor Text Attributes Count';
		value: [ :aText | 
			| anIterator aCounter |
			aCounter := 0.
			anIterator := aText iterator.
			[ anIterator hasNext ] whileTrue: [ (anIterator attributes 
				anySatisfy: [ :eachAttribute | eachAttribute class = aClass ]) ifTrue: [ aCounter := aCounter + 1 ].
				anIterator next ].
			aCounter ] equals: aNumber;
		id: GtSourceCoderEditorId;
		onBrTextEditor;
		onBrTextEditorText;
		play.
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep refactoringPreviewButtonExists: doesExist [
	<gtExample>
	| aCheck |

	aCheck := aScripterOrStep check
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRefactoringsPreviewButton.

	doesExist
		ifTrue: [
			aCheck
				exists;
				label: 'Check refactoring preview button exists' ]
		ifFalse: [
			aCheck
				notExists;
				label: 'Check refactoring preview button does not exist' ].

	aCheck play
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep renameEditorExists: doesExist [
	| aCheck |

	aCheck := aScripterOrStep check
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor.

	doesExist
		ifTrue: [
			aCheck
				exists;
				label: 'Check rename editor exists' ]
		ifFalse: [
			aCheck
				notExists;
				label: 'Check rename editor does not exist' ].

	aCheck play
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep saveButtonEnabled: isEnabled [
	| aCheck |

	aCheck := aScripterOrStep check
		id: GtMethodCoderSaveActionId.

	isEnabled
		ifTrue: [
			aCheck
				satisfies: [ :aButton | aButton isEnabled ];
				label: 'Check save button is enabled' ]
		ifFalse: [
			aCheck
				satisfies: [ :aButton | aButton isDisabled ];
				label: 'Check save button is disbled' ].

	aCheck play
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textAttributesAt: anIndex anySatisfies: aBlock [
	<gtExample>
	aScripterOrStep assert
		label: 'Assert Any Editor Text Attribute Satisfaction';
		anySatisfy: aBlock;
		id: GtSourceCoderEditorId;
		onBrTextEditor;
		onBrTextEditorText;
		onTextAttributesAt: anIndex;
		play
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textAttributesAt: anIndex nonSatisfies: aBlock [
	<gtExample>
	aScripterOrStep assert
		label: 'Assert Editor Text Attributes';
		nonSatisfies: aBlock;
		id: GtSourceCoderEditorId;
		onBrTextEditor;
		onBrTextEditorText;
		onTextAttributesAt: anIndex;
		play
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textExampleStatusAttributeAt: anIndex [
	<gtExample>
	self 
		checkFor: aScripterOrStep 
		textAttributesAt: anIndex 
		anySatisfies: [ :aTextAttribute | aTextAttribute class = GtCoderExampleStatusAttribute ]
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textExpandAttributeAt: anIndex [
	self 
		checkFor: aScripterOrStep 
		textAttributesAt: anIndex 
		anySatisfies: [ :aTextAttribute | aTextAttribute isKindOf: BrGlamorousTriangleExpanderTextAttribute ]
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> checkHasReceiverAttribute: aScripter [
	aScripter check
		label: 'Check receiver attribute';
		value: [ :aCoderEditor | 
				| count |
				count := 0.
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtMessageReceiverAttribute ]
					indicesDo: [ :aStart :anEnd | count := count + 1 ].
				count ]
			equals: [ :aCoderEditor | 1 ];
		id: GtSourceCoderEditorId;
		play
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> checkHasTwoReorderAttributes: aScripter [
	<gtExample>
	aScripter check
		label: 'Check reorder attributes';
		value: [ :aCoderEditor |
				| count |
				count := 0.
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtReorderParametersAttribute ]
					indicesDo: [ :aStart :anEnd | count := count + 1. ].
				count ]
			equals: [ :aCoderEditor | 2 ];
		id: GtSourceCoderEditorId;
		play
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> checkKeywordRenameEditor: aScripter [
	aScripter check
		label: 'Check rename editor attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval ifNil: [ anInterval := aStart to: anEnd ] ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString indexOfSubCollection: '_:'.
				index to: index + 1 ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.

	aScripter check
		label: 'Check method name editor source code';
		value: [ :aNameEditor | aNameEditor text asString first ] equals: $_;
		onChildFromBlock: [ :element | 
			element
				allChildrenBreadthFirstDetect: [ :each | (each isKindOf: GtRenameEditor) and: [ each isFocused ] ]
				ifFound: [ :each | each ] ];
		play.

	aScripter check
		label: 'Check method name editor selected text';
		value: [ :aNameEditor | aNameEditor editor selectedText asString first ]
			equals: $_;
		onChildFromBlock: [ :element | 
			element
				allChildrenBreadthFirstDetect: [ :each | (each isKindOf: GtRenameEditor) and: [ each isFocused ] ]
				ifFound: [ :each | each ] ];
		play
]

{ #category : #'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> classReferenceHasUnderlineAttribute [
	<gtExample>
	| filter aScripter |

	filter := GtSearchIntersectionFilter new
		 filter: (GtSearchFixedMethodsFilter new methods: { thisContext method })
		filter: OrderedCollection gtReferences.
	aScripter := self scripterForBlock: [ filter asCoder allCoders first ].

	aScripter checks: 'Check OrderedCollection highlighted' do: [ :aStep |
		self checkFor: aStep textAttributesAt: (thisContext method sourceCode indexOfSubCollection: 'OrderedCollection') anySatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
		self checkFor: aStep numberfOfTextAttributes: 17 ofType: BlTextDecorationAttribute ].

	^ aScripter
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> clickFixItActionFor: aScripter id: aBlElementId [
	"An utility method to open and click on the fixIt action with id.
	I assume that the fixit menu already exists"

	<gtExample>
	aScripter click
		onSpaceRoot;
		id: aBlElementId;
		play
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> clickFixItFor: aScripter [
	"An utility method to click on the fixIt button to open a context menu"

	"there is no context menu before clicking on the fixit button"

	<gtExample>
	aScripter check
		onSpaceRoot;
		onBreadthFirstChildOfClass: GtCoderContextMenuContent;
		notExists;
		play.

	aScripter click
		onBreadthFirstChildOfClass: GtFixItButton;
		play.	"now it appeared"
	aScripter check
		onSpaceRoot;
		onBreadthFirstChildOfClass: GtCoderContextMenuContent;
		exists;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> clickReorderParameter: aScripter variables: variableNames [
	| text |

	aScripter check
		label: 'Check selected text';
		elementSatisfies:
				[ :aSourceEditor | 
					text := aSourceEditor text asString.
					(('*: <1s> *: <2s>' expandMacrosWithArguments: variableNames) match: text)
						or: [ ('*: <2s> *: <1s>' expandMacrosWithArguments: variableNames) match: text ] ];
		id: GtSourceCoderEditorId;
		play.

	(aScripter click)
		label: 'Open context menu';
		id: #'reorder-parameter-button';
play.

	aScripter check
		label: 'Check selected text';
		elementSatisfies:
				[ :aSourceEditor | 
					| string |
					string := aSourceEditor text asString.
					text ~= string
						and:
							[ (('*: <1s> *: <2s>' expandMacrosWithArguments: variableNames) match: text)
								or: [ ('*: <2s> *: <1s>' expandMacrosWithArguments: variableNames) match: text ] ] ];
		id: GtSourceCoderEditorId;
		play.

	self checkHasTwoReorderAttributes: aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderCollapseProgrammatically [
	<gtExample>
	| aScripter |

	aScripter := self coderExpandedByDefault.
	
	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel collapse ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert view model is not expanded';
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded not ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert view model is not focused';
		satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert element is collapsed';
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isCollapsed ];
		onSelf;
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandClickingOnExpander [
	<gtExample>
	| aScripter |

	aScripter := self coderCollapseProgrammatically.
	
	aScripter click
		id: GtSourceCoderExpanderToggleId;
		play.
	
	aScripter assert
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
		onModel;
		play.
		
	aScripter assert
		satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
		onModel;
		play.

	aScripter assert
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
		onSelf;
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandClickingOnHeader [
	<gtExample>
	| aScripter |

	aScripter := self coderCollapseProgrammatically.
	
	aScripter click
		onBreadthFirstChildOfClass: GtSourceCoderCollapsedContentElement;
		play.
		
	aScripter assert
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
		onModel;
		play.
		
	aScripter assert
		satisfies: [ :aCoderViewModel | aCoderViewModel focused ];
		onModel;
		play.
		
	aScripter assert
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
		onSelf;
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandProgrammatically [
	<gtExample>
	| aScripter |
	aScripter := self coderCollapseProgrammatically.

	aScripter do
		label: 'Expand view model';
		action: [ :aCoderViewModel | aCoderViewModel expand ];
		onModel;
		play.

	aScripter assert
		label: 'Assert view model is expanded';
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
		onModel;
		play.

	aScripter assert
		label: 'Assert view model is not focused';
		satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
		onModel;
		play.

	aScripter assert
		label: 'Assert element is expanded';
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
		onSelf;
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandedByDefault [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self binaryMethodCoder asCoderViewModel ].

	aScripter assert
		label: 'Assert view model is expanded';
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
		onModel;
		play.

	aScripter assert
		label: 'Assert view model is not focused';
		satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
		onModel;
		play.

	aScripter assert
		label: 'Assert element is expanded';
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
		onSelf;
		play.

	^ aScripter
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> coderOnMethod: aMethod [
	<gtExample>
	| aCoder |
	aCoder := self basicMethodCoder.
	aCoder forMethod: aMethod.
	self assert: aCoder selector equals: aMethod selector.
	self assert: aCoder behavior equals: aMethod methodClass.
	self assert: aCoder protocol equals: aMethod protocol.

	"a coder is not displayed and its source text is not initialized"
	self assert: aCoder sourceCode hasSourceText not.
	^ aCoder
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> collapseFromUI: aScripter method: aMethod [
	<gtExample>
	aScripter substep: 'Collapse and Check Coder' do: [ :aStep |
		aStep click
			label: 'Click on Expander';
			onChildAt: 1;
			play.

		aStep assert 
			label: 'Assert Coder UI is Expanded';
			satisfies: [ :aCoderElement | aCoderElement isExpanded not ];
			play.

		aStep assert
			label: 'Assert Coder Collapsed Label Text';
			value: [ :aLabelElement | aLabelElement text asString ] equals: [ aMethod selector ];
			id: GtSourceCoderCollapsedTextId;
			play ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoMethodCoderByScripterExamples >> contextMenuCopy [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new coderOnClassUnaryMethodThatCreatesPoint.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
	self selectTextFor: aScripter from: 38 to: 45 andCheck: '196@400'.
	
	Clipboard clipboardText: ''.
	self openAndClickOnContextMenuItemFor: aScripter id: GtTextualCoderCopyContextMenuItemId.
	self assert: Clipboard clipboardText asString equals: '196@400'.
	
	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoMethodCoderByScripterExamples >> contextMenuCut [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new coderOnClassUnaryMethodThatCreatesPoint.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
	self selectTextFor: aScripter from: 38 to: 45 andCheck: '196@400'.
	
	Clipboard clipboardText: ''.
	self openAndClickOnContextMenuItemFor: aScripter id: GtTextualCoderCutContextMenuItemId.
	self assert: Clipboard clipboardText asString equals: '196@400'.

	aScripter assert
		satisfies: [ :aCoder | (aCoder currentSourceString includesSubstring: '196@400') not ];
		onModel;
		play.
	
	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoMethodCoderByScripterExamples >> contextMenuPaste [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new coderOnClassUnaryMethodThatCreatesPoint.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].

	self selectTextFor: aScripter from: 38 to: 45 andCheck: '196@400'.
	
	Clipboard clipboardText: '400@196'.
	self openAndClickOnContextMenuItemFor: aScripter id: GtTextualCoderPasteContextMenuItemId.
	self assert: Clipboard clipboardText asString equals: '400@196'.

	aScripter assert
		satisfies: [ :aCoder | (aCoder currentSourceString includesSubstring: '196@400') not ];
		onModel;
		play.

	aScripter assert
		satisfies: [ :aCoder | (aCoder currentSourceString includesSubstring: '400@196') ];
		onModel;
		play.
	
	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> createdClassThatDoesntExist [
	^ 'ClassThatDoesNotExist6561'
]

{ #category : #'examples - complete method name' }
GtPharoMethodCoderByScripterExamples >> emptyBodyMethod [
	<gtExample>
	^ GtPharoMethodCoderExamples >> #emptyBody
]

{ #category : #'examples - complete method name' }
GtPharoMethodCoderByScripterExamples >> emptyBodyMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self emptyBodyMethod.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - complete method name' }
GtPharoMethodCoderByScripterExamples >> emptyBodyMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ self emptyBodyMethodCoder asCoderViewModel ].

	^ aScripter
]

{ #category : #'examples - complete method name' }
GtPharoMethodCoderByScripterExamples >> emptyBodyMethodCoderUI_ModifySourceCode [

	"Check https://github.com/feenkcom/gtoolkit/issues/2289"

	<gtExample>
	| aScripter |
	aScripter := self emptyBodyMethodCoderUI.

	aScripter substeps: 'Open method completer' do: [ :aStep | 
		aStep do
			label: 'Append class name and a selector part';
			action: [ :anEditor | 
				anEditor inserter
					atEnd;
					string: ' ' , GtPharoMethodCoderExamples name , ' new '
						, ((GtPharoMethodCoderExamples
							  >> #many:many:many:many:many:many:arguments:) selector 
								 first: 4);
					insert.

				anEditor editor moveCursorTo: anEditor text size.

				self assert: anEditor editor hasCursors ];
			id: GtSourceCoderEditorId;
			play.

		aStep shortcut
			label: 'Trigger completer pop-up';
			combination: BlKeyCombination builder control space build;
			id: GtSourceCoderEditorId;
			play.

		aStep wait
			forEnqueuedSpaceTaskTimeout: 0.5 seconds;
			play.
		aStep wait
			forEmptySpaceTaskQueueTimeout: 5 seconds;
			play ].

	^ aScripter
]

{ #category : #'examples - complete method name' }
GtPharoMethodCoderByScripterExamples >> emptyBodyMethodCoderUI_SelectMethodNameFromCompleterPopUp [

	<gtExample>
	| aScripter |
	aScripter := self emptyBodyMethodCoderUI_ModifySourceCode.

	aScripter substeps: 'Select and insert method' do: [ :aStep | 
		aStep do
			label: 'Select method with many arguments';
			block: [ :element | 
				| items item i text |
				i := 1.
				text := (GtPharoMethodCoderExamples
				         >> #many:many:many:many:many:many:arguments:) selector
					        asString.
				items := element items.
				[ item isNil and: [ i <= items size ] ] whileTrue: [ 
						(items at: i) label = text
							ifTrue: [ item := items at: i ]
							ifFalse: [ i := i + 1 ] ].
				self
					assert: item notNil
					description: [ 
						'Cannot find completer selector: {1}' format: {text} ].
				element selectOne: i ];
			onSpaceRoot;
			id: #'completion-list';
			play.

		aStep shortcut
			label: 'Complete with TAB key';
			combination: BlKeyCombination tab;
			id: GtSourceCoderEditorId;
			play ].

	^ aScripter
]

{ #category : #'examples - complete method name' }
GtPharoMethodCoderByScripterExamples >> emptyBodyMethodCoderUI_TypeAllArguments [
	<gtExample>
	| aScripter |
	aScripter := self emptyBodyMethodCoderUI_SelectMethodNameFromCompleterPopUp.

	aScripter
		substeps: 'Insert argument values'
		do: [ :aStep | 
			| aNumArgs |
			aNumArgs := (GtPharoMethodCoderExamples
					>> #many:many:many:many:many:many:arguments:) numArgs.



			(1 to: aNumArgs)
				do: [ :anIndex | 
					aStep type
						text: '''arg' , anIndex asString , '''';
						id: GtSourceCoderEditorId;
						play ]
				separatedBy: [ aStep shortcut
						label: 'Complete with TAB key';
						combination: BlKeyCombination tab;
						id: GtSourceCoderEditorId;
						play ].

			aStep assert
				label: 'Assert method source code content';
				value: [ :anEditor | anEditor text characters ]
					equals: self finalCompleterSourceCode;
				id: GtSourceCoderEditorId;
				play ].

	^ aScripter
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethod [
	<gtExample>

	^ GtPharoMethodCoderExamples >> #sumMethod
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self exampleMethod.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI [
	<gtExample>
	| aScripter |
	
	aScripter := self scripterForBlock: [ self exampleMethodCoder asCoderViewModel ].
	
	^ aScripter
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_CollapsedFromUI [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI.
	self collapseFromUI: aScripter method: self exampleMethod.

	^ aScripter
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI_CollapsedFromUI.
	self expandFromUI: aScripter method: self exampleMethod.

	^ aScripter
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI_CheckActionButtons [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI_ExpandedFromUI.
	self 
		checkFor: aScripter 
		numberOfMainActions: 4
		contextAction: 4.

	self checkFor: aScripter existenceOfContextActionNamed: 'Play Example'.
	self checkFor: aScripter existenceOfContextActionNamed: 'Play and Inspect Example Result'.

	^ aScripter
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI_PlayAndInspect [
	<gtExample>
	| aScripter |

	aScripter := self exampleMethodCoderUI_ExpandedFromUI_CheckActionButtons.
	
	aScripter click
		label: 'Click play and inspect';
		id: GtMethodCoderPlayAndInspectExampleActionId;
		play.

	^ aScripter
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI_RemovePragma [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI_ExpandedFromUI.

	aScripter substeps: 'Remove Pragma' do: [ :aStep |
		aStep do
			label: 'Delete e character from <gtExample>
	<noTest>';
			action: [ :anEditor | anEditor deleter from: 20 to: 21; delete ];
			id: GtSourceCoderEditorId;
			play.

		self 
			checkFor: aStep
			numberOfMainActions: 5
			contextAction: 0.

		self checkFor: aStep absenceOfContextActionNamed: 'Play Example' ].

	^ aScripter
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> expandFromUI: aScripter method: aMethod [
	<gtExample>
	aScripter
		substep: 'Expand and Check Coder'
		do: [ :aStep | 
			aStep click
				label: 'Click on Expander';
				onChildAt: 1;
				play.

			aStep assert
				label: 'Assert Coder UI is Expanded';
				satisfies: [ :aCoderElement | aCoderElement isExpanded ];
				play.

			aStep assert
				label: 'Assert Coder Editor Text';
				value: [ :anEditorElement | anEditorElement editor text asString ]
					equals: [ aMethod sourceCode ];
				id: GtSourceCoderEditorId;
				play ].

	^ aScripter
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> extractedUnaryMethodNameFor: aMethodCoder [
	^ 'sub', (aMethodCoder attributeNamed: #dummyMethod) selector capitalized
]

{ #category : #'examples - complete method name' }
GtPharoMethodCoderByScripterExamples >> finalCompleterSourceCode [

	^ 'emptyBody GtPharoMethodCoderExamples new many: ''arg1'' many: ''arg2'' many: ''arg3'' many: ''arg4'' many: ''arg5'' many: ''arg6'' arguments: ''arg7'''
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClassInPlayground_01_setup [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPharoSnippetCoder new ].

	aScripter do
		label: 'Type in a class that does not exist';
		action: [ :aCoder | aCoder appendString: String cr , String tab , self createdClassThatDoesntExist ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClassInPlayground_02_click_fixit [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateClassInPlayground_01_setup.
	self clickFixItFor: aScripter.
	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClassInPlayground_03_click_define_class [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateClassInPlayground_02_click_fixit.
	
	"there is no create behavior element before clicking on the menu"
	aScripter assert
		onBreadthFirstChildOfClass: GtCreationFormWidget;
		notExists;
		play.
	
	aScripter click
		onSpaceRoot;
		id: (GtDefineClassFixItActionElementId indexed: 1);
		play.
		
	"now it appeared"
	aScripter assert
		onBreadthFirstChildOfClass: GtCreationFormWidget;
		exists;
		play.
		
	"and it should be saveable"
	aScripter assert
		onBreadthFirstChildOfClass: GtCreationFormWidget;
		id: #toolbar;
		onChildAt: 1;
		value: #isEnabled equals: false;
		play.
	
	"context menu should disappear"
	aScripter assert
		onSpaceRoot;
		onBreadthFirstChildOfClass: GtCoderContextMenuContent;
		notExists;
		play.

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClass_01_setup [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new emptyMethodCoder.
				aCoder appendString: 'method'.
				aCoder ].

	aScripter do
		label: 'Type in a class that does not exist';
		action: [ :aCoder | aCoder appendString: String cr , String tab , self createdClassThatDoesntExist ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClass_02_click_fixit [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateClass_01_setup.
	self clickFixItFor: aScripter.
	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClass_03_click_define_class [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateClass_02_click_fixit.
	
	"there is no create behavior element before clicking on the menu"
	aScripter assert
		onBreadthFirstChildOfClass: GtCreationFormWidget;
		notExists;
		play.
	
	aScripter click
		onSpaceRoot;
		id: (GtDefineClassFixItActionElementId indexed: 1);
		play.
		
	"now it appeared"
	aScripter assert
		onBreadthFirstChildOfClass: GtCreationFormWidget;
		exists;
		play.
		
	"and it should be saveable"
	aScripter assert
		onBreadthFirstChildOfClass: GtCreationFormWidget;
		id: #toolbar;
		onChildAt: 1;
		satisfies: #isEnabled;
		play.
	
	"context menu should disappear"
	aScripter assert
		onSpaceRoot;
		onBreadthFirstChildOfClass: GtCoderContextMenuContent;
		notExists;
		play.

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateInstVar_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder asCoderViewModel ].
				
	aScripter do
		label: 'Type in a variable that does not exist';
		action: [ :aCoderViewModel | aCoderViewModel coderModel appendString: String cr , String tab , 'instance' ];
		onModel;
		play.

	self
		selectTextFor: aScripter
		from: 9
		to: 17
		andCheck: 'instance'.
	self clickFixItFor: aScripter.

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateInstVar_02_add [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateInstVar_01_setup.
	
	self clickFixItActionFor: aScripter id: (GtDefineInstanceVariableFixItActionElementId indexed: 1).

	aScripter assert
		value: [ :aCoderViewModel | aCoderViewModel coderModel currentSourceString ]
		equals: [ :aCoderViewModel |
			String streamContents: [ :aStream |
				aStream
					nextPutAll: (aCoderViewModel coderModel attributeNamed: #dummyMethod) selector; cr;
					tab; nextPutAll: 'instance' ] ];
		onModel;
		play.

	aScripter assert
		label: 'Make sure the instance variable was created';
		satisfies: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) realClass hasSlotNamed: #instance ];
		onModel;
		play.

	aScripter assert
		label: 'Make sure the method still mofied';
		satisfies: [ :aCoderViewModel | aCoderViewModel coderModel isModified ];
		onModel;
		play.

	aScripter assert
		label: 'Make sure the method is not saved/recompiled after adding a temporary variable';
		value: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) systemMethod sourceCode ]
		equals: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) realMethod sourceCode ];
		onModel;
		play.
		
	aScripter assert
		label: 'Make sure the text was deselected';
		satisfies: [ :aCoderViewModel | aCoderViewModel hasSelection not ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateTempVar_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder asCoderViewModel ].

	aScripter do
		label: 'type in a variable that does not exist';
		action: [ :aCoderViewModel | aCoderViewModel coderModel appendString: (String cr, String tab, 'temporary') ];
		onModel;
		play.

	self selectTextFor: aScripter from: 9 to: 18 andCheck: 'temporary'.	
	self clickFixItFor: aScripter.
	
	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateTempVar_02_add [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateTempVar_01_setup.
	
	self clickFixItActionFor: aScripter id: (GtDefineTemporaryVariableFixItActionElementId indexed: 1).
	
	aScripter assert
		value: [ :aCoderViewModel | aCoderViewModel coderModel currentSourceString ]
		equals: [ :aCoderViewModel |
			String streamContents: [ :aStream |
				aStream
					nextPutAll: (aCoderViewModel coderModel attributeNamed: #dummyMethod) selector; cr;
					tab; nextPutAll: '| temporary |'; cr;
					tab; nextPutAll: 'temporary' ] ];
		onModel;
		play.
	
	aScripter assert
		label: 'Make sure the method still mofied';
		satisfies: [ :aCoderViewModel | aCoderViewModel coderModel isModified ];
		onModel;
		play.
		
	aScripter assert
		label: 'Make sure the method is not saved/recompiled after adding a temporary variable';
		value: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) systemMethod sourceCode ]
		equals: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) realMethod sourceCode ];
		onModel;
		play.
		
	aScripter assert
		label: 'Make sure the text was deselected';
		satisfies: [ :aCoderViewModel | aCoderViewModel hasSelection not ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstactInstVar_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
		
	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | aCoder appendString:
('
	^ {1} isNil' format: { (aCoder attributeNamed: #dummyMethod) anyInstVarName })
		];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forAbstactInstVar_01_setup.
	aScripter do
		label: 'Select part of the assignment node';
		action: [ :aSourceEditor | aSourceEditor selecter from: 13 to: 14; select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_03_hover_abstract_variable [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forAbstractInstVar_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover abstract';
		onSpaceRoot;
		id: #'context-menu--abstract-variable';
		play.

	^ aScripter
]

{ #category : #'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_04_click_abstract_variable [
	<gtExample>
	| aScripter |
	aScripter := self forAbstractInstVar_03_hover_abstract_variable.

	aScripter click
		label: 'Click abstract variable';
		onSpaceRoot;
		id: #'context-menu--abstract-variable';
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString indexOfSubCollection: ' isNil'.
				index - 1 to: index - 1 ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
		
	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | aCoder appendString:
'Unique
	^ (1 to: self items size) detect: [:each | (self items at: each) notNil]' ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forAddParameterFromValue_01_setup.
	
	aScripter do
		label: 'Select part of the method pattern';
		action: [ :aSourceEditor |
			| index |
			index := aSourceEditor text asString indexOfSubCollection: '(1'.
			aSourceEditor selecter
				from: index to: index + 1;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_03_hover_add_parameter [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forAddParameterFromValue_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover add parameter';
		onSpaceRoot;
		id: #'context-menu--add-parameter';
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_04_click_add_parameter [
	<gtExample>
	| aScripter |
	aScripter := self forAddParameterFromValue_03_hover_add_parameter.

	aScripter click
		label: 'Click add parameter';
		onSpaceRoot;
		id: #'context-menu--add-parameter';
		play.

	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
			equals: [ :aCoder | 
				'{1}Unique: anObject
	^ (1 to: self items size) detect: [:each | (self items at: each) notNil]'
					format: {(aCoder attributeNamed: #dummyMethod) selector} ];
		onModel;
		play.

	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	aScripter assert
		label: 'Assert rename editor attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 1 to: (aCoderEditor text asString indexOf: $:) ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := (aCoderEditor text asString indexOf: Character cr) - 1.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert method name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_05_enter_method_name [
	<gtExample>
	| aScripter |
	aScripter := self forAddParameterFromValue_04_click_add_parameter.

	(aScripter type: 'someOtherMethodName:') play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := (aCoderEditor text asString indexOf: Character cr) - 1.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	(aScripter keyPress: BlKeyboardKey return) play.

	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := (aCoderEditor text asString indexOf: Character cr) - 1.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
		
	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | aCoder appendString:
'Unique
	^ self printString' ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.
		
	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forAddParameter_01_setup.
	aScripter do
		label: 'Select part of the method pattern';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 0 to: 1;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_03_hover_add_parameter [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forAddParameter_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover add parameter';
		onSpaceRoot;
		id: #'context-menu--add-parameter';
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_04_click_add_parameter [
	<gtExample>
	| aScripter |

	aScripter := self forAddParameter_03_hover_add_parameter.

	aScripter click
		label: 'Click add parameter';
		onSpaceRoot;
		id: #'context-menu--add-parameter';
		play.
	
	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
('{1}Unique: anObject
	^ self printString' format: {
		(aCoder attributeNamed: #dummyMethod) selector
	}) ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.
	
	aScripter assert
		label: 'Assert rename editor attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | 1 to: (aCoderEditor text asString indexOf: $:) ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := (aCoderEditor text asString indexOf: Character cr) - 1.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert method name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_05_enter_method_name [
	<gtExample>
	| aScripter |

	aScripter := self forAddParameter_04_click_add_parameter .

	(aScripter type: 'someOtherMethodName:') play.
	
	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := (aCoderEditor text asString indexOf: Character cr) - 1.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	(aScripter keyPress: BlKeyboardKey return) play.
		
	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := (aCoderEditor text asString indexOf: Character cr) - 1.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].

	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | aCoder appendString:
'
	| cache |
	cache := IdentityDictionary new.
	^ cache' ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forConvertTempToInst_01_setup.
	aScripter do
		label: 'Select part of the variable node';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 11 to: 12;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_03_hover_convert_temporary_to_instance_variable [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forConvertTempToInst_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover convert';
		onSpaceRoot;
		id: #'context-menu--convert-temp-to-inst-var';
		play.

	^ aScripter
]

{ #category : #'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_04_click_convert [
	<gtExample>
	| aScripter |
	aScripter := self
			forConvertTempToInst_03_hover_convert_temporary_to_instance_variable.

	aScripter click
		label: 'Click convert';
		onSpaceRoot;
		id: #'context-menu--convert-temp-to-inst-var';
		play.

	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
			equals: [ false ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString indexOfSubCollection: 'cache'.
				index + 4 to: index + 4 ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - create accessors' }
GtPharoMethodCoderByScripterExamples >> forCreateAccessors_03_hover_create_accessors [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forAbstractInstVar_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover abstract';
		onSpaceRoot;
		id: #'context-menu--create-accessors';
		play.

	^ aScripter
]

{ #category : #'examples - create accessors' }
GtPharoMethodCoderByScripterExamples >> forCreateAccessors_04_click_create_accessors [
	<gtExample>
	| aScripter |
	aScripter := self forCreateAccessors_03_hover_create_accessors.

	aScripter click
		label: 'Click create accessors';
		onSpaceRoot;
		id: #'context-menu--create-accessors';
		play.

	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
			equals: [ false ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString indexOfSubCollection: ' isNil'.
				index - 1 to: index - 1 ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].

	aScripter do
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString: '
	^ self printString size' ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forExtractTemp_01_setup.
	aScripter do
		label: 'Select part of the method to extract';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 11 to: 27;
				select ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: [ 'self printString' ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_03_context_menu [
	<gtExample>
	
	^ self openContextMenu: self forExtractTemp_02_select
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_04_hover_extract_temp [
	<gtExample>
	| aScripter |

	aScripter := self forExtractTemp_03_context_menu.

	aScripter mouseMoveOver
		label: 'Hover extract temp';
		onSpaceRoot;
		id: GtSourceCoderExtractTempVarContextMenuItemId;
		play.

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_05_click_extract_temp [
	<gtExample>
	| aScripter |

	aScripter := self forExtractTemp_04_hover_extract_temp.

	aScripter click
		label: 'Click extract temp';
		onSpaceRoot;
		id: GtSourceCoderExtractTempVarContextMenuItemId;
		play.
	
	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
'method1
	| _ |
	_ := self printString.
	^ _ size' ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ] equals: [ false ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.
	
	aScripter assert
		label: 'Assert rename editor attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor |
				| index |
				index := aCoderEditor text asString indexOfSubCollection: '_ :='.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert variable name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter assert
		label: 'Assert variable name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_06_type_variable_name [
	<gtExample>
	| aScripter |

	aScripter := self forExtractTemp_05_click_extract_temp.

	(aScripter keyPress: BlKeyboardKey delete) play.
	(aScripter keyPress: BlKeyboardKey backspace) play.
	(aScripter type: 'a') play.
	(aScripter keyPress: BlKeyboardKey return) play.

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_07_verify_source [
	<gtExample>
	| aScripter |
	aScripter := self forExtractTemp_06_type_variable_name.

	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
			equals: [ :aCoder | 
				'method1
	| a |
	a := self printString.
	^ a size' ];
		onModel;
		play.

	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	aScripter assert
		label: 'Assert rename editor attribute';
		value: [ :aCoderEditor | 
				aCoderEditor text
					hasAttributeSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ] ]
			equals: false;
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert source editor is focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forExtraction_02_method_parameter_cannot_be_extracted [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_01_setup.
	aScripter do
		label: 'Select part of the method to extract';
		action: [ :aSourceEditor | 
			aSourceEditor selecter
				from: 9 to: 17;
				select ];
		id: GtSourceCoderEditorId;
		play.

	self openContextMenu: aScripter.

	aScripter assert
		label: 'Assert extract method doesn''t exist';
		onSpaceRoot;
		notExists;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	^ aScripter
]

{ #category : #'examples - inline all self sends' }
GtPharoMethodCoderByScripterExamples >> forInlineAllSelfSends_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
		
	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | aCoder appendString:
'
	^ self isNil'];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - inline all self sends' }
GtPharoMethodCoderByScripterExamples >> forInlineAllSelfSends_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forInlineAllSelfSends_01_setup.
	aScripter do
		label: 'Select part of the method node';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 1 to: 2;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - inline all self sends' }
GtPharoMethodCoderByScripterExamples >> forInlineAllSelfSends_03_hover_inline_message_send [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forInlineAllSelfSends_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover inline self send';
		onSpaceRoot;
		id: #'context-menu--inline-self-sends';
		play.

	^ aScripter
]

{ #category : #'examples - inline all self sends' }
GtPharoMethodCoderByScripterExamples >> forInlineAllSelfSends_04_click_inline_send [
	<gtExample>
	| aScripter |
	aScripter := self forInlineAllSelfSends_03_hover_inline_message_send.

	aScripter click
		label: 'Click inline temp';
		onSpaceRoot;
		id: #'context-menu--inline-self-sends';
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString lines first size.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
		
	aScripter do
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
'
	^ self isNil'];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forInlineMessageSend_01_setup.
	aScripter do
		label: 'Select part of the message node';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 13 to: 14;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_03_hover_inline_message_send [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forInlineMessageSend_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover inline message send';
		onSpaceRoot;
		id: #'context-menu--inline-message';
		play.

	^ aScripter
]

{ #category : #'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_04_click_inline_message_send [
	<gtExample>
	| aScripter |

	aScripter := self forInlineMessageSend_03_hover_inline_message_send.

	aScripter click
		label: 'Click inline temp';
		onSpaceRoot;
		id: #'context-menu--inline-message';
		play.

	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
'method1
	^ false' ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - inline parameter' }
GtPharoMethodCoderByScripterExamples >> forInlineParameter_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
	
	aScripter do
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
'Unique: arg
	^ arg printString' ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - inline parameter' }
GtPharoMethodCoderByScripterExamples >> forInlineParameter_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forInlineParameter_01_setup.
	aScripter do
		label: 'Select part of the method arg';
		action: [ :aSourceEditor |
			| index |
			index := (aSourceEditor text asString indexOfSubCollection: 'arg') - 1.
			aSourceEditor selecter
				from: index to: index + 3;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - inline parameter' }
GtPharoMethodCoderByScripterExamples >> forInlineParameter_03_hover_inline_parameter [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forInlineParameter_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover inline parameter';
		onSpaceRoot;
		id: #'context-menu--inline-parameter';
		play.

	^ aScripter
]

{ #category : #'examples - inline parameter' }
GtPharoMethodCoderByScripterExamples >> forInlineParameter_04_click_inline_parameter [
	<gtExample>
	| aScripter |

	aScripter := self forInlineParameter_03_hover_inline_parameter.

	aScripter click
		label: 'Click inline parameter';
		onSpaceRoot;
		id: #'context-menu--inline-parameter';
		play.
	
	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := (aCoderEditor text asString indexOf: Character cr) - 1.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
		
	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | aCoder appendString: '
	| str |
	str := self printString.
	^ str size' ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forInlineTemp_01_setup.
	aScripter do
		label: 'Select part of the assignment node';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 22 to: 24;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_03_hover_inline_temp [
	<gtExample>
	| scripter |
	scripter := self openContextMenu: self forInlineTemp_02_cursor.

	scripter mouseMoveOver
		label: 'Hover inline temp';
		onSpaceRoot;
		id: #'context-menu--inline-temp';
		play.

	scripter assert
		label: 'Assert assignment node highlighted';
		value: [ :editor | 
				| intervals |
				intervals := OrderedCollection new.
				editor text
					findAttributesSuchThat: [ :each | each = GtPharoMethodCoder nodeHighlight ]
					indicesDo: [ :start :end | 
						(intervals notEmpty and: [ intervals last last + 1 = start ])
							ifTrue: [ intervals at: intervals size put: (intervals last first to: end) ]
							ifFalse: [ intervals add: (start to: end) ] ].
				intervals detect: [ :each | each size > 3 ] ]
			equals: [ :aCoderEditor | 
				(aCoderEditor text asString indexOfSubCollection: 'str :=')
					to: (aCoderEditor text asString indexOf: $.) - 1 ];
		id: GtSourceCoderEditorId;
		play.

	^ scripter
]

{ #category : #'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_04_click_inline_temp [
	<gtExample>
	| aScripter |
	aScripter := self forInlineTemp_03_hover_inline_temp.

	aScripter click
		label: 'Click inline temp';
		onSpaceRoot;
		id: #'context-menu--inline-temp';
		play.

	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
			equals: [ false ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
			equals: [ :aCoder | 
				'method1
	^ self printString size' ];
		onModel;
		play.

	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].

	aScripter do
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
(': anObject
	| temp |
	temp := 42.
	^ temp factorial printString , anObject printString')
		];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordExtraction_01_setup.
	aScripter do
		label: 'Select part of the method to extract';
		action: [ :aSourceEditor |
			| index |
			index := (aSourceEditor text asString indexOf: $^) + 1.
			aSourceEditor selecter
				from: index to: aSourceEditor text size;
				select ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: [ 'temp factorial printString , anObject printString' ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_03_context_menu [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordExtraction_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_04_hover_extract_method [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordExtraction_03_context_menu.

	aScripter mouseMoveOver
		label: 'Hover extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_05_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_04_hover_extract_method.

	aScripter click
		label: 'Click extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	self checkHasReceiverAttribute: aScripter.
	self checkHasTwoReorderAttributes: aScripter.
	self checkKeywordRenameEditor: aScripter.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_06_reorder_parameters_and_enter_keywords [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_05_click_extract_method.

	self clickReorderParameter: aScripter variables: #('temp' 'anObject').
	self checkKeywordRenameEditor: aScripter.
	self checkHasReceiverAttribute: aScripter.

	(aScripter type: 'a:') play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	self clickReorderParameter: aScripter variables: #('temp' 'anObject').

	(aScripter keyPress: BlKeyboardKey tab) play.
	self checkKeywordRenameEditor: aScripter.

	(aScripter type: 'b:') play.
	(aScripter keyPress: BlKeyboardKey return) play.

	self clickReorderParameter: aScripter variables: #('temp' 'anObject').

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forKeywordMoveMethod_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
	aScripter do
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
(': anObject
	| temp |
	temp := 42.
	^ OrderedCollection with: self with: anObject with: temp factorial printString , anObject printString')
		];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forKeywordMoveMethod_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordMoveMethod_01_setup.
	aScripter do
		label: 'Select the variable';
		action: [ :aSourceEditor |
			| index |
			index := (aSourceEditor text asString indexOfSubCollection: 'OrderedCollection') - 1.
			aSourceEditor selecter
				from: index to: index + 'OrderedCollection' size;
				select ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: [ 'OrderedCollection' ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forKeywordMoveMethod_03_context_menu_move_method [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordMoveMethod_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	aScripter click
		label: 'Click move method';
		onSpaceRoot;
		id: #'context-menu--move-method';
		play.

	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	self checkHasTwoReorderAttributes: aScripter.
	self checkKeywordRenameEditor: aScripter.

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forKeywordMoveMethod_04_reorder_parameters_and_enter_keywords [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordMoveMethod_03_context_menu_move_method.

	self clickReorderParameter: aScripter variables: #('self' 'anObject').
	self checkKeywordRenameEditor: aScripter.

	(aScripter type: 'a:') play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	self clickReorderParameter: aScripter variables: #('self' 'anObject').
	(aScripter keyPress: BlKeyboardKey tab) play.
	self checkKeywordRenameEditor: aScripter.

	(aScripter type: 'b:') play.
	(aScripter keyPress: BlKeyboardKey return) play.

	self clickReorderParameter: aScripter variables: #('self' 'anObject').

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forKeywordMethodInPackagedClass.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].

	aScripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	aScripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId;
		play.
	
	self checkFor: aScripter saveButtonEnabled: true.
	self checkFor: aScripter discardButtonExists: false.
	
	aScripter assert
		label: 'Assert editor is focused';
		satisfies: [ :anEditorElement | anEditorElement isFocused ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert cursor position';
		value: [ :anEditorElement | anEditorElement editor cursors positions ] equals: [ #(0) ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_02_shortcut [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordRename_01_setup.
	
	aScripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId;
		play.
	
	self checkFor: aScripter saveButtonEnabled: false.
	self checkFor: aScripter renameEditorExists: true.
	self checkFor: aScripter discardButtonExists: false.

	aScripter assert
		label: 'Assert rename editor all selected';
		value: [ :anEditor | anEditor editor selectedText asString ] equals: [ (aScripter model attributeNamed: #dummyMethod) selector allButLast ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_03_move_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordRename_02_shortcut.	
	"this positions the cursor before `:`"
	(aScripter keyPress: BlKeyboardKey arrowLeft) play.
	(aScripter keyPress: BlKeyboardKey arrowRight) play.

	self checkFor: aScripter refactoringPreviewButtonExists: false.

	aScripter assert
		label: 'Assert cursor position';
		value: [ :anEditor | anEditor editor cursors positions ]
			equals: [ {(aScripter model attributeNamed: #dummyMethod) selector size - 1} ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter assert
		label: 'Assert rename editor all selected';
		value: [ :anEditor | anEditor editor selectedText asString ] equals: [ '' ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_04_type [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordRename_03_move_cursor.

	(aScripter type: 'New') play.

	self checkFor: aScripter renameEditorExists: true.
	self checkFor: aScripter refactoringPreviewButtonExists: true.
	self checkFor: aScripter saveButtonEnabled: false.
	self checkFor: aScripter discardButtonExists: false.

	aScripter assert
		label: 'Assert text';
		value: [ :anEditor | anEditor text asString ]
			equals: [ (aScripter model attributeNamed: #dummyMethod) selector allButLast , 'New' ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_05_click_preview [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordRename_04_type.

	aScripter click
		label: 'Click refactoring preview button';
		id: GtSourceCoderEditorId;
		id: #previewCheckButton;
		play.

	aScripter assert
		label: 'Assert that refactorings preview appeared';
		exists;
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId;
		play.

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_06_click_apply [
	<gtExample>
	<noTest>
	| aScripter |

	aScripter := self forKeywordRename_05_click_preview.

	aScripter click
		label: 'Click refactorings apply button';
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId;
		play.
	
	self checkFor: aScripter renameEditorExists: false.
	self checkFor: aScripter refactoringPreviewButtonExists: false.
	self checkFor: aScripter saveButtonEnabled: true.
	self checkFor: aScripter discardButtonExists: false.

	^ aScripter
]

{ #category : #'examples - move variable scope' }
GtPharoMethodCoderByScripterExamples >> forMoveVariableScope_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [ 
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].

	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | 
			aCoder appendString: (self moveVariableSource format: {'|temp|'. ''}) ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - move variable scope' }
GtPharoMethodCoderByScripterExamples >> forMoveVariableScope_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forMoveVariableScope_01_setup.
	aScripter do
		label: 'Select part of the variable node';
		action: [ :aSourceEditor |
			| index |
			index := aSourceEditor text asString indexOfSubCollection: 'temp'.
			aSourceEditor selecter
				from: index - 1 to: index + 3;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - move variable scope' }
GtPharoMethodCoderByScripterExamples >> forMoveVariableScope_03_hover_move_variable_declaration [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forMoveVariableScope_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover protect';
		onSpaceRoot;
		id: #'context-menu--move-variable-declaration';
		play.

	^ aScripter
]

{ #category : #'examples - move variable scope' }
GtPharoMethodCoderByScripterExamples >> forMoveVariableScope_04_click_move_variable_declaration [
	<gtExample>
	| aScripter |
	aScripter := self forMoveVariableScope_03_hover_move_variable_declaration.

	aScripter click
		label: 'Click move variable';
		onSpaceRoot;
		id: #'context-menu--move-variable-declaration';
		play.

	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
			equals: [ false ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | (GtPharoParser parse: aCoder currentSourceString) body ]
			equals: [ :aCoder | 
				GtPharoParser
					parse: (self moveVariableSource
							format: {''.
									'|temp|'})
					startingAt: GtPharoParser startingStateForMethodSequence ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | 
			aCoder
				appendString: ('
	^ {1}' format: {(aCoder attributeNamed: #dummyMethod) anyInstVarName}) ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forProtectInstVar_01_setup.

	aScripter do
		label: 'Select part of the variable node';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 11 to: 12;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_03_hover_protect_variable [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forProtectInstVar_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover protect';
		onSpaceRoot;
		id: #'context-menu--protect-variable';
		play.

	^ aScripter
]

{ #category : #'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_04_click_Protect_variable [
	<gtExample>
	| aScripter |
	aScripter := self forProtectInstVar_03_hover_protect_variable.

	aScripter click
		label: 'Click protect variable';
		onSpaceRoot;
		id: #'context-menu--protect-variable';
		play.

	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
			equals: [ false ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - pull down variable' }
GtPharoMethodCoderByScripterExamples >> forPullDownVariable_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter rootClass |
	aScripter := self
			scripterForBlock: [ | env method coder |
				env := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 3.
				rootClass := env anyDummyLeafClass.
				method := rootClass anyDummyUnaryMethod realMethod.

				coder := GtPharoMethodCoder forMethod: method.
				coder attributeNamed: #dummyEnvironment put: env.
				coder attributeNamed: #dummyMethod put: rootClass anyDummyUnaryMethod.
				coder ].

	aScripter do
		label: 'Type in a method';
		action: [ :aCoder | 
			aCoder
				appendString: ('
	^ {1}' format: {rootClass realClass superclass allInstVarNames last}) ];
		onModel;
		play.

	aScripter do
		label: 'Save a method';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - pull down variable' }
GtPharoMethodCoderByScripterExamples >> forPullDownVariable_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forPullDownVariable_01_setup.
	aScripter do
		label: 'Select part of the variable';
		action: [ :aSourceEditor |
			| index |
			index := (aSourceEditor text asString indexOfSubCollection: '^ ') + 1.
			aSourceEditor selecter
				from: index to: index + 8;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - pull down variable' }
GtPharoMethodCoderByScripterExamples >> forPullDownVariable_03_hover_pull_down [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forPullDownVariable_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover pull down variable';
		onSpaceRoot;
		id: #'context-menu--pull-down-variable';
		play.

	^ aScripter
]

{ #category : #'examples - pull down variable' }
GtPharoMethodCoderByScripterExamples >> forPullDownVariable_04_click_pull_down [
	<gtExample>
	| aScripter |
	aScripter := self forPullDownVariable_03_hover_pull_down.

	aScripter click
		label: 'Click pull down variable';
		onSpaceRoot;
		id: #'context-menu--pull-down-variable';
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString size.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - push down method' }
GtPharoMethodCoderByScripterExamples >> forPushDownMethod_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| env rootClass method coder |
		env := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 3.
		rootClass := env anyDummyRootClass.
		method := rootClass anyDummyUnaryMethod realMethod.
	
		coder := GtPharoMethodCoder forMethod: method.
		coder attributeNamed: #dummyEnvironment put: env.
		coder attributeNamed: #dummyMethod put: rootClass anyDummyUnaryMethod.
		coder ].

	aScripter do
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
'Unique
	^ self printString' ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - push down method' }
GtPharoMethodCoderByScripterExamples >> forPushDownMethod_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forPushDownMethod_01_setup .
	aScripter do
		label: 'Select part of the method pattern';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 0 to: 1;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - push down method' }
GtPharoMethodCoderByScripterExamples >> forPushDownMethod_03_hover_push_down_method [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forPushDownMethod_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover push down method';
		onSpaceRoot;
		id: #'context-menu--push-down-method';
		play.

	^ aScripter
]

{ #category : #'examples - push down method' }
GtPharoMethodCoderByScripterExamples >> forPushDownMethod_04_click_push_down_method [
	<gtExample>
	| aScripter |
	aScripter := self forPushDownMethod_03_hover_push_down_method.

	aScripter click
		label: 'Click push up method';
		onSpaceRoot;
		id: #'context-menu--push-down-method';
		play.

	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
			equals: [ false ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString lines first size.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - push up method' }
GtPharoMethodCoderByScripterExamples >> forPushUpMethod_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter do
		label: 'Type in a method with argument';
		action: [ :aCoder | 
			aCoder
				appendString: '
	^ self printString' ];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - push up method' }
GtPharoMethodCoderByScripterExamples >> forPushUpMethod_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forPushUpMethod_01_setup .
	aScripter do
		label: 'Select part of the method pattern';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 0 to: 7;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - push up method' }
GtPharoMethodCoderByScripterExamples >> forPushUpMethod_03_hover_push_up_method [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forPushUpMethod_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover push up method';
		onSpaceRoot;
		id: #'context-menu--push-up-method';
		play.

	^ aScripter
]

{ #category : #'examples - push up method' }
GtPharoMethodCoderByScripterExamples >> forPushUpMethod_04_click_push_up_method [
	<gtExample>
	| aScripter |
	aScripter := self forPushUpMethod_03_hover_push_up_method.

	aScripter click
		label: 'Click push up method';
		onSpaceRoot;
		id: #'context-menu--push-up-method';
		play.

	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
			equals: [ false ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString lines first size.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - push up variable' }
GtPharoMethodCoderByScripterExamples >> forPushUpVariable_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter rootClass |
	aScripter := self
			scripterForBlock: [ | env method coder |
				env := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 3.
				rootClass := env anyDummyLeafClass.
				method := rootClass anyDummyUnaryMethod realMethod.

				coder := GtPharoMethodCoder forMethod: method.
				coder attributeNamed: #dummyEnvironment put: env.
				coder attributeNamed: #dummyMethod put: rootClass anyDummyUnaryMethod.
				coder ].

	aScripter do
		label: 'Type in a method';
		action: [ :aCoder | 
			aCoder
				appendString: ('
	^ {1}' format: {rootClass realClass allInstVarNames last}) ];
		onModel;
		play.

	aScripter do
		label: 'Save a method';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - push up variable' }
GtPharoMethodCoderByScripterExamples >> forPushUpVariable_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forPushUpVariable_01_setup.
	aScripter do
		label: 'Select part of the variable';
		action: [ :aSourceEditor |
			| index |
			index := (aSourceEditor text asString indexOfSubCollection: '^ ') + 1.
			aSourceEditor selecter
				from: index to: index + 8;
				select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - push up variable' }
GtPharoMethodCoderByScripterExamples >> forPushUpVariable_03_hover_push_up [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forPushUpVariable_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover push up variable';
		onSpaceRoot;
		id: #'context-menu--push-up-variable';
		play.

	^ aScripter
]

{ #category : #'examples - push up variable' }
GtPharoMethodCoderByScripterExamples >> forPushUpVariable_04_click_push_up [
	<gtExample>
	| aScripter |
	aScripter := self forPushUpVariable_03_hover_push_up.

	aScripter click
		label: 'Click push up variable';
		onSpaceRoot;
		id: #'context-menu--push-up-variable';
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := aCoderEditor text asString size.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].

	aScripter do
		label: 'Type-in a method with argument';
		action: [ :aCoder | aCoder appendString:
(': unusedArg
	{1} := Set new' format: { (aCoder attributeNamed: #dummyMethod) anyInstVarName })
		];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forRemoveParameter_01_setup.
	aScripter do
		label: 'Select part of the parameter node';
		action: [ :aSourceEditor | aSourceEditor selecter from: 11 to: 12; select ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_03_hover_remove_parameter [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forRemoveParameter_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover remove parameter';
		onSpaceRoot;
		id: #'context-menu--remove-parameter';
		play.

	^ aScripter
]

{ #category : #'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_04_click_remove_parameter [
	<gtExample>
	| aScripter |

	aScripter := self forRemoveParameter_03_hover_remove_parameter.

	aScripter click
		label: 'Click remove parameter';
		onSpaceRoot;
		id: #'context-menu--remove-parameter';
		play.

	aScripter assert
		label: 'Assert there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ] equals: [ false ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | 
				| index |
				index := (aCoderEditor text asString indexOfSubCollection: 'unusedArg') + 8.
				index to: index ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].

	aScripter do
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
(': anObject
	{1} := anObject.
	{1} := {1} + 42.' format: { (aCoder attributeNamed: #dummyMethod) anyInstVarName })
		];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_01_setup.
	aScripter do
		label: 'Select part of the method to extract';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 42 to: 67;
				select ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: [ '{1} := {1} + 42' format: { (aScripter model attributeNamed:  #dummyMethod) anyInstVarName } ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_03_context_menu [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_04_hover_extract_method [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_03_context_menu.

	aScripter mouseMoveOver
		label: 'Hover extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_05_click_extract_method [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_04_hover_extract_method.

	aScripter click
		label: 'Click extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId;
		play.
	
	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
('{1}: anObject
	{2} := anObject.
	self _' format: {
		(aCoder attributeNamed: #dummyMethod) selector.
		(aCoder attributeNamed:  #dummyMethod) anyInstVarName
	}) ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.
	
	aScripter assert
		label: 'Assert rename editor attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert method name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.
		
	aScripter assert
		label: 'Assert method name editor selected text';
		value: [ :aNameEditor | aNameEditor editor selectedText asString ] equals: '_';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter assert
		label: 'Assert method name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_06_type_method_name [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_05_click_extract_method.

	aScripter type
		text: (self extractedUnaryMethodNameFor: aScripter model);
		play.
	
	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_07_01_accept_with_enter [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_06_type_method_name.

	aScripter keyPress
		key: BlKeyboardKey return;
		play.
		
	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_08_preview_refactoring [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_07_01_accept_with_enter.
	
	"Enter opens the preview"
	aScripter assert
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId;
		exists;
		play.

	aScripter click
		id: #previewCheckButton;
		play.
		
	"Click should close the preview"
	aScripter assert
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId;
		notExists;
		play.

	aScripter click
		id: #previewCheckButton;
		play.

	aScripter assert
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId;
		exists;
		play.

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_09_apply_refactoring [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self forUnaryExtraction_08_preview_refactoring.

	aScripter click
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute does not exist';
		value: [ :aCoderEditor | 
				| anInterval |
				aCoderEditor text
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
					indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
				anInterval ]
			equals: [ nil ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		onBreadthFirstChildOfClass: GtRefactoringsPreviewButton;
		notExists;
		play.

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forUnaryMoveMethod_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
		
	aScripter do
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
(': anObject
	^ anObject ' , thisContext method selector)
		];
		onModel;
		play.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forUnaryMoveMethod_02_select [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryMoveMethod_01_setup.
	aScripter do
		label: 'Select the variable';
		action: [ :aSourceEditor |
			| index |
			index := (aSourceEditor text asString indexOfSubCollection: 'anObject') - 1.
			aSourceEditor selecter
				from: index to: index + 'anObject' size;
				select ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: [ 'anObject' ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forUnaryMoveMethod_03_context_menu_move_method [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryMoveMethod_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	aScripter click
		label: 'Click move method';
		onSpaceRoot;
		id: #'context-menu--move-method';
		play.

	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
('{1}: anObject
	^ anObject _' format: {
		(aCoder attributeNamed: #dummyMethod) selector
	}) ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.
	
	aScripter assert
		label: 'Assert rename editor attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert method name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.
		
	aScripter assert
		label: 'Assert method name editor selected text';
		value: [ :aNameEditor | aNameEditor editor selectedText asString ] equals: '_';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter assert
		label: 'Assert method name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.
		
	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forUnaryMoveMethod_03_context_menu_move_method_and_enter_name [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryMoveMethod_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	aScripter click
		label: 'Click move method';
		onSpaceRoot;
		id: #'context-menu--move-method';
		play.

	aScripter assert
		label: 'Assert current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
('{1}: anObject
	^ anObject _' format: {
		(aCoder attributeNamed: #dummyMethod) selector
	}) ];
		onModel;
		play.
		
	aScripter assert
		label: 'Assert source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel;
		play.
	
	aScripter assert
		label: 'Assert rename editor attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		id: GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		id: GtSourceCoderEditorId;
		play.
	
	aScripter assert
		label: 'Assert method name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.
		
	aScripter assert
		label: 'Assert method name editor selected text';
		value: [ :aNameEditor | aNameEditor editor selectedText asString ] equals: '_';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter assert
		label: 'Assert method name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.
		
	(aScripter type: 'someNewMethodName') play.
	(aScripter keyPress: BlKeyboardKey tab) play.

	aScripter assert
		label: 'Assert refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		id: GtSourceCoderEditorId;
		play.
		
	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forUnaryRename_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	aScripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert editor is focused';
		satisfies: [ :anEditorElement | anEditorElement isFocused ];
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert cursor position';
		value: [ :anEditorElement | anEditorElement editor cursors positions ]
			equals: [ #(0) ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forUnaryRename_02_shortcut [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryRename_01_setup.

	aScripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert rename editor exists';
		exists;
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	aScripter assert
		label: 'Assert rename editor all selected';
		value: [ :anEditor | anEditor editor selectedText asString ]
			equals: [ (aScripter model attributeNamed: #dummyMethod) selector ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.

	^ aScripter
]

{ #category : #'examples - basic' }
GtPharoMethodCoderByScripterExamples >> methodCoder [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter set
		model: [ self basicMethodCoder ];
		play.
	^ aScripter
]

{ #category : #'examples - move variable scope' }
GtPharoMethodCoderByScripterExamples >> moveVariableSource [
	^ '
	{1}
	self printString size > 4 
		ifTrue: [{2} temp := 4. 
			^ 3 + temp] 
		ifFalse: [{2} temp := 2. 
			^ temp + 40]'
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> openAndClickFixItActionFor: aScripter id: aBlElementId [
	"An utility method to open and click on the fixIt action with id.
	I assume that the fixit menu does not already exists"
	
	self clickFixItFor: aScripter.
	self clickFixItActionFor: aScripter id: aBlElementId
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> openContextMenu: aScripter [
	<gtExample>
	aScripter secondaryClick
		label: 'Open context menu';
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - pattern highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterMethod [
	<gtExample>
	^ GtPharoMethodCoderExamples >> #a:a:a:a:
]

{ #category : #'examples - pattern highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self patternHighlighterMethod.
	aCoder := self coderOnMethod: aMethod.
	aCoder highlighter: (GtPharoImplementorPatternHighlighter forPattern: 'a:').
	^ aCoder
]

{ #category : #'examples - pattern highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self patternHighlighterMethodCoder ].
	^ aScripter
]

{ #category : #'examples - pattern highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterMethodCoderUI_CheckUndelineAttributes [
	<gtExample>
	| aScripter |

	aScripter := self patternHighlighterMethodCoderUI.
	
	self
		checkFor: aScripter
		textAttributesAt: 2
		anySatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
	
	self
		checkFor: aScripter
		numberfOfTextAttributes: 8
		ofType: BlTextDecorationAttribute.

	^ aScripter
]

{ #category : #'examples - pattern highlither - print' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintMethod [
	<gtExample>
	^ GtPharoMethodCoderExamples >> #printStringReference
]

{ #category : #'examples - pattern highlither - print' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self patternHighlighterPrintMethod.
	aCoder := self coderOnMethod: aMethod.
	aCoder highlighter: (GtPharoImplementorPatternHighlighter forPattern: 'print').
	^ aCoder
]

{ #category : #'examples - pattern highlither - print' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self patternHighlighterPrintMethodCoder ].
	^ aScripter
]

{ #category : #'examples - pattern highlither - print' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintMethodCoderUI_CheckUndelineAttributes [
	<gtExample>
	| aScripter |

	aScripter := self patternHighlighterPrintMethodCoderUI.
	
	self
		checkFor: aScripter
		textAttributesAt: 1
		anySatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
	
	self
		checkFor: aScripter
		numberfOfTextAttributes: 5
		ofType: BlTextDecorationAttribute.

	self
		checkFor: aScripter
		textAttributesAt: 30
		nonSatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].

	^ aScripter
]

{ #category : #'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintStringMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self patternHighlighterPrintMethod.
	aCoder := self coderOnMethod: aMethod.
	aCoder highlighter: (GtPharoSelectorReferenceAndLiteralHighlighter forSelector: #printString).
	^ aCoder
]

{ #category : #'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintStringMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self patternHighlighterPrintStringMethodCoder ].
	^ aScripter
]

{ #category : #'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintStringMethodCoderUI_CheckUndelineAttributes [
	<gtExample>
	| aScripter |

	aScripter := self patternHighlighterPrintStringMethodCoderUI.
	aScripter checks: 'Check Pattern Highlighter Source Code Style' do: [ :aStep |
		self checkFor: aStep textAttributesAt: 1 nonSatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
		self checkFor: aStep textAttributesAt: 30 anySatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
		self checkFor: aStep numberfOfTextAttributes: 11 ofType: BlTextDecorationAttribute ].

	^ aScripter
]

{ #category : #'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethod [
	<gtExample>
	^ GtPharoMethodCoderExamples >> #b
]

{ #category : #'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self referencedExampleMethod.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self referencedExampleMethodCoder asCoderViewModel ].
	^ aScripter
]

{ #category : #'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI_CheckExampleAttribute [
	<gtExample>
	| aScripter |
	
	aScripter := self referencedExampleMethodCoderUI.
	self checkFor: aScripter textExampleStatusAttributeAt: 1.
	
	^ aScripter
]

{ #category : #'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI_CheckExampleExpandAttribute [
	<gtExample>
	| aScripter |
	aScripter := self referencedExampleMethodCoderUI.
	aScripter checks: 'Check Example Status and Expand Attribute' do: [ :aStep | 
		self checkFor: aStep textExpandAttributeAt: 24.
		self checkFor: aStep textExampleStatusAttributeAt: 1 ].
	^ aScripter
]

{ #category : #'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI_NoExampleStatusAfterPragmaDeletion [
	<gtExample>
	| aScripter |
	aScripter := self referencedExampleMethodCoderUI.
	aScripter substeps: 'Remove Pragma' do: [ :aStep |
	
		aStep do
			label: 'Delete e character from <gtExample>';
			action: [ :anEditor | anEditor deleter from: 12 to: 13; delete ];
			id: GtSourceCoderEditorId;
			onBrTextEditor;
			play.
			
		self 
			checkFor: aStep
			numberOfMainActions: 5
			contextAction: 0.
			
		self checkFor: aStep absenceOfContextActionNamed: 'Play Example' ].
	aScripter checks: 'Assert Example Status Is Not Present' do: [ :aStep | 
		self checkFor: aStep textExpandAttributeAt: 23.
		self 
			checkFor: aStep 
			textAttributesAt: 1 
			nonSatisfies: [ :aTextAttribute | aTextAttribute class = GtCoderExampleStatusAttribute ] ].
	
	^ aScripter
]

{ #category : #'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI_NoExampleStatusAfterPragmaDeletion_WriteExamplePragma [
	<gtExample>
	| aScripter |
	aScripter := self referencedExampleMethodCoderUI_NoExampleStatusAfterPragmaDeletion.
	
	aScripter substeps: 'Insert Pragma' do: [ :aStep |
	
		aStep do
			label: 'Insert e character in <gtExample>';
			action: [ :anEditor | anEditor inserter at: 12; string: 'e'; insert ];
			id: GtSourceCoderEditorId;
			onBrTextEditor;
			play.
			
		self 
			checkFor: aStep
			numberOfMainActions: 4
			contextAction: 4.
			
		self checkFor: aStep existenceOfContextActionNamed: 'Play Example' ].
		
	aScripter checks: 'Check Example Status Is Present' do: [ :aStep | 
		self checkFor: aStep textExpandAttributeAt: 24.
		self checkFor: aStep textExampleStatusAttributeAt: 1. ].
	^ aScripter
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> scripterForBlock: aBlock [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter substep: 'Initialize Coder Model and UI' do: [ :aStep | 
		aStep set 
			label: 'Initialize Coder Model';
			model: aBlock;
			play.
		aStep set 
			label: 'Initialize Coder UI';
			element: [ :aCoder | aCoder asElement ];
			onModel;
			play ].

	^ aScripter
]

{ #category : #'examples - statement selection/motion' }
GtPharoMethodCoderByScripterExamples >> selectStatementsDown [
	<gtExample>
	| aScripter expecteds |
	aScripter := self scripterForBlock: [ self statementMethodCoder ].
	aScripter do
		label: 'Move cursor to middle of statement';
		action: [ :aSourceEditor | 
			| index |
			index := aSourceEditor text asString indexOf: $2.
			aSourceEditor textualCoderViewModel
				cursors: (BrTextEditorCursor at: index - 1) ];
		id: GtSourceCoderEditorId;
		play.

	expecteds := #(
	'b := 2'
	
	'b := 2.
			c := 3'
			
	'a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ]'
			
	'a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ].
	d := 6'
	
	'multipleStatementMethod
	| a b c d |
	a := 1.
	a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ].
	d := 6'
	).
		
	expecteds do: [:each | 
	aScripter shortcut
		combination: BlKeyCombination builder primary shift arrowDown build;
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: each
	;
		id: GtSourceCoderEditorId;
		play].

	^ aScripter
]

{ #category : #'examples - statement selection/motion' }
GtPharoMethodCoderByScripterExamples >> selectStatementsUp [
	<gtExample>
	| aScripter expecteds |
	aScripter := self scripterForBlock: [ self statementMethodCoder ].
	aScripter do
		label: 'Move cursor to middle of statement';
		action: [ :aSourceEditor | 
			| index |
			index := aSourceEditor text asString indexOf: $2.
			aSourceEditor textualCoderViewModel
				cursors: (BrTextEditorCursor at: index - 1) ];
		id: GtSourceCoderEditorId;
		play.

	expecteds := #('b := 2' 
	
	'a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ]' 
			
	'a := 1.
	a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ]' 
			
	'multipleStatementMethod
	| a b c d |
	a := 1.
	a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ].
	d := 6').

	expecteds
		do: [ :each | 
			aScripter shortcut
				combination: BlKeyCombination builder primary shift arrowUp build;
				id: GtSourceCoderEditorId;
				play.

			aScripter assert
				label: 'Assert selected text';
				value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
					equals: each;
				id: GtSourceCoderEditorId;
				play ].

	^ aScripter
]

{ #category : #'examples - statement selection/motion' }
GtPharoMethodCoderByScripterExamples >> selectStatementsWithError [
	<gtExample>
	| aScripter coder |
	aScripter := self scripterForBlock: [ coder := self statementMethodCoder ].
	
	"Create a syntax error"
	coder appendString: ';'.
	
	aScripter do
		label: 'Move cursor to last statement';
		action: [ :aSourceEditor | 
			| index |
			index := aSourceEditor text asString indexOf: $6.
			aSourceEditor textualCoderViewModel
				cursors: (BrTextEditorCursor at: index - 1) ];
		id: GtSourceCoderEditorId;
		play.

	aScripter shortcut
		combination: BlKeyCombination builder primary shift arrowUp build;
		id: GtSourceCoderEditorId;
		play.

	aScripter assert
		label: 'Assert selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: '';
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - statement selection/motion' }
GtPharoMethodCoderByScripterExamples >> statementMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := GtPharoMethodCoderExamples >> #multipleStatementMethod.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]
