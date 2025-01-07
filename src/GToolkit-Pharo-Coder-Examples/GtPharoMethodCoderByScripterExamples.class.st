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

{ #category : #accessing }
GtPharoMethodCoderByScripterExamples class >> dummyMethod: arg [
	self foo: arg
]

{ #category : #'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> astMatchesHasUnderlineAttribute [
	<gtExample>
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
		numberfOfTextAttributes: 13
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
	aScripter
		substep: 'Collapse and Check Coder'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on Expander';
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Coder Editor Text';
						value: [ :label | label text asString ] equals: '?';
						id: GtSourceCoderCollapsedTextId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Coder UI Is Collapsed';
						satisfies: [ :aCoderElement | aCoderElement isExpanded not ] ] ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Collapsed_BreadcrumbContent [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.

	aScripter
		checks: 'Check Breadcrumb'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Breadcrumb Package Name';
						value: [ :aButton | aButton label asString ]
							equals: [ GtPharoMethodCoderExamples package name ];
						onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Breadcrumb Class Name';
						value: [ :aButton | aButton label asString ]
							equals: [ GtPharoMethodCoderExamples name ];
						onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
						onChildAt: 3 ] ].

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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click On Class Name';
						onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
						onChildAt: 3 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Triggered Spawn Object Event';
						satisfies: [ :theScripter | 
							theScripter events reversed
								detectEventOfClass: GtPhlowObjectToSpawn
								ifFound: [ :theEvent | 
									theEvent object = self binaryMethod
										and: [ theEvent tool isKindOf: GtMethodCoderTool ] ]
								ifNone: [ AssertionFailure
										signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
						onScripter ] ].

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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click On Package Name';
						onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Triggered Spawn Object Event';
						satisfies: [ :theScripter | 
							theScripter events reversed
								detectEventOfClass: GtPhlowObjectToSpawn
								ifFound: [ :theEvent | 
									theEvent object class = RPackage
										and: [ theEvent object name = self class package name ] ]
								ifNone: [ AssertionFailure
										signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
						onScripter ] ].

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
	"self 
		checkFor: aScripter 
		numberOfMainActions: 4
		contextAction: 0."
	self checkFor: aScripter absenceOfContextActionNamed: 'Play'.

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
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Method Name Attributes';
						anySatisfy: [ :aTextAttribute | aTextAttribute = BlFontWeightAttribute bold ];
						id: GtSourceCoderEditorId;
						onBrTextEditor;
						onBrTextEditorText;
						onTextAttributesAt: 1 ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Comment Attributes';
						anySatisfy: [ :aTextAttribute | aTextAttribute = (BlTextForegroundAttribute new paint: Color gray darker) ];
						id: GtSourceCoderEditorId;
						onBrTextEditor;
						onBrTextEditorText;
						onTextAttributesAt: 13 ] ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Expanded_BreadcrumbContent [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI.
	aScripter
		checks: 'Check Breadcrumb'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Breadcrumb Package Name';
						value: [ :aButton | aButton label asString ]
							equals: [ GtPharoMethodCoderExamples package name ];
						onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Breadcrumb Class Name';
						value: [ :aButton | aButton label asString ]
							equals: [ GtPharoMethodCoderExamples name ];
						onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
						onChildAt: 3 ] ].

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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click On Class Name';
						onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
						onChildAt: 3 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Triggered Spawn Object Event';
						satisfies: [ :theScripter | 
							theScripter events reversed
								detectEventOfClass: GtPhlowObjectToSpawn
								ifFound: [ :theEvent | 
									theEvent object = self binaryMethod
										and: [ theEvent tool isKindOf: GtMethodCoderTool ] ]
								ifNone: [ AssertionFailure
										signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
						onScripter ] ].
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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click On Package Name';
						onBreadthFirstChildOfClass: GtPharoMethodCoderHeaderElement;
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Triggered Spawn Object Event';
						satisfies: [ :theScripter | 
							theScripter events reversed
								detectEventOfClass: GtPhlowObjectToSpawn
								ifFound: [ :theEvent | 
									theEvent object class = RPackage
										and: [ theEvent object name = self class package name ] ]
								ifNone: [ AssertionFailure
										signal: GtPhlowObjectToSpawn name , ' event was not found' ] ];
						onScripter ] ].

	^ aScripter
]

{ #category : #'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_WithoutExampleActions [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_ExpandedFromUI.
	"self 
		checkFor: aScripter 
		numberOfMainActions: 4
		contextAction: 0."
	self checkFor: aScripter absenceOfContextActionNamed: 'Play'.

	^ aScripter
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter absenceOfContextActionNamed: anActionName [
	<gtExample>
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert Context Action Existence Named ' , anActionName asString;
				nonSatisfies: [ :aContextActions | 
					aContextActions title = anActionName translated
						and: [ aContextActions action method = (GtPharoMethodCoder >> #exampleAstFor:into:viewModel:) ] ];
				onModel;
				onChildFromMessage: #contextActions ]
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
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert Context Action Existence Named ' , anActionName asString;
				anySatisfy: [ :aContextActions | 
					aContextActions title = anActionName translated
						and: [ aContextActions action blocDefiningMethod
								= (GtPharoMethodCoder >> #exampleAstFor:into:viewModel:) ] ];
				onModel;
				onChildFromMessage: #contextActions ]
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter numberOfMainActions: aMainActionsCount contextAction: anAddonsActionsCount [
	<gtExample>
	aScripter
		substeps: 'Check Available Action Buttons'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert number of main actions';
						childrenCount: aMainActionsCount;
						onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert number of addons actions';
						childrenCount: anAddonsActionsCount;
						onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
						onChildAt: 3 ] ]
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter numberOfMainActions: aMainActionsCount contextActionAtLeast: anAddonsActionsCount [
	<gtExample>
	aScripter
		substeps: 'Check Available Action Buttons'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert number of main actions';
						childrenCount: aMainActionsCount;
						onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert number of addons actions';
						satisfies: [ :anElement | anElement childrenCount >= anAddonsActionsCount ] 
							description: [ :anElement | 'Element must have at least {1}, but have {2}: {3}' format: { anAddonsActionsCount. anElement childrenCount. anElement } ];
						onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
						onChildAt: 3 ] ]
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep numberfOfTextAttributes: aNumber ofType: aClass [
	aScripterOrStep
		assertStep: [ :s | 
			s
				label: 'Assert Editor Text Attributes Count';
				value: [ :aText | 
						| anIterator aCounter |
						aCounter := 0.
						anIterator := aText iterator.
						[ anIterator hasNext ]
							whileTrue: [ (anIterator attributes
									anySatisfy: [ :eachAttribute | eachAttribute class = aClass ])
									ifTrue: [ aCounter := aCounter + 1 ].
								anIterator next ].
						aCounter ]
					equals: aNumber;
				id: GtSourceCoderEditorId;
				onBrTextEditor;
				onBrTextEditorText ]
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
	aScripterOrStep
		assertStep: [ :s | 
			s
				label: 'Assert Any Editor Text Attribute Satisfaction';
				anySatisfy: aBlock;
				id: GtSourceCoderEditorId;
				onBrTextEditor;
				onBrTextEditorText;
				onTextAttributesAt: anIndex ]
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textAttributesAt: anIndex nonSatisfies: aBlock [
	<gtExample>
	aScripterOrStep
		assertStep: [ :s | 
			s
				label: 'Assert Editor Text Attributes';
				nonSatisfies: aBlock;
				id: GtSourceCoderEditorId;
				onBrTextEditor;
				onBrTextEditorText;
				onTextAttributesAt: anIndex ]
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
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check receiver attribute';
				value: [ :aCoderEditor | 
						| count |
						count := 0.
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtMessageReceiverAttribute ]
							indicesDo: [ :aStart :anEnd | count := count + 1 ].
						count ]
					equals: [ :aCoderEditor | 1 ];
				id: GtSourceCoderEditorId ]
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> checkHasTwoReorderAttributes: aScripter [
	<gtExample>
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check reorder attributes';
				value: [ :aCoderEditor | 
						| count |
						count := 0.
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtReorderParametersAttribute ]
							indicesDo: [ :aStart :anEnd | count := count + 1 ].
						count ]
					equals: [ :aCoderEditor | 2 ];
				id: GtSourceCoderEditorId ]
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> checkKeywordRenameEditor: aScripter [
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check rename editor attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval ifNil: [ anInterval := aStart to: anEnd ] ].
						anInterval ]
					equals: [ :aCoderEditor | 
						| index |
						index := aCoderEditor text asString indexOfSubCollection: '_:'.
						index to: index + 1 ];
				id: GtSourceCoderEditorId ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check source editor is not focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
				id: GtSourceCoderEditorId ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check source editor has focus';
				satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
				id: GtSourceCoderEditorId ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check method name editor source code';
				value: [ :aNameEditor | aNameEditor text asString first ] equals: $_;
				onChildFromBlock: [ :element | 
					element
						allChildrenBreadthFirstDetect: [ :each | (each isKindOf: GtRenameEditor) and: [ each isFocused ] ]
						ifFound: [ :each | each ] ] ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check method name editor selected text';
				value: [ :aNameEditor | aNameEditor editor selectedText asString first ]
					equals: $_;
				onChildFromBlock: [ :element | 
					element
						allChildrenBreadthFirstDetect: [ :each | (each isKindOf: GtRenameEditor) and: [ each isFocused ] ]
						ifFound: [ :each | each ] ] ]
]

{ #category : #'examples - rename variable' }
GtPharoMethodCoderByScripterExamples >> checkRefactoringAttributesForRenamingInstVar [
	<gtExample>
	| scripter |
	[ environment printString ] value.
	scripter := self
			scripterForBlock: [ GtPharoMethodCoder forMethod: thisContext method method ].

	scripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	scripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId;
		play.

	scripter do
		label: 'Position cursor';
		id: GtSourceCoderEditorId;
		block: [ :each | 
			each editor
				moveCursorTo: (thisContext method method sourceCode indexOfSubCollection: 'environment') + 1 ];
		play.

	scripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId;
		play.


	self checkFor: scripter renameEditorExists: true.
	self checkFor: scripter refactoringPreviewButtonExists: false.
	self checkFor: scripter saveButtonEnabled: false.

	(scripter type: 'env') play.

	self checkFor: scripter renameEditorExists: true.
	self checkFor: scripter refactoringPreviewButtonExists: true.
	self checkFor: scripter saveButtonEnabled: false.

	(scripter type: 'ironment') play.

	self checkFor: scripter renameEditorExists: true.
	self checkFor: scripter refactoringPreviewButtonExists: false.
	self checkFor: scripter saveButtonEnabled: false.

	(scripter type: '1') play.

	self checkFor: scripter renameEditorExists: true.
	self checkFor: scripter refactoringPreviewButtonExists: true.
	self checkFor: scripter saveButtonEnabled: false.

	^ scripter
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

{ #category : #'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> classSideExtractToComponent [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (self coderOnMethod: self class class >> #dummyMethod:) asCoderViewModel ].
	aScripter requestFocus
		id: GtSourceCoderEditorId;
		play.
	aScripter
		keyPressStep: [ :s | 
			s
				label: 'Goto next line';
				key: BlKeyboardKey arrowDown ].
	aScripter keyDown
		key: BlKeyboardKey shiftLeft;
		play.
	aScripter
		keyPressStep: [ :s | 
			s
				label: 'Goto next line';
				key: BlKeyboardKey arrowDown ].
	aScripter keyUp
		key: BlKeyboardKey shiftLeft;
		play.
	aScripter keyDown
		key: BlKeyboardKey primaryLeft;
		play.
	aScripter
		keyPressStep: [ :s | 
			s
				label: 'Extract';
				key: BlKeyboardKey e ].
	aScripter keyUp
		key: BlKeyboardKey primaryLeft;
		play.
	aScripter
		clickStep: [ :s | 
			s
				id: GtSourceCoderEditorId;
				onChildFromBlock: [ :element | 
					element
						allChildrenBreadthFirstDetect: [ :each | each isKindOf: BrButton ]
						ifFound: [ :each | each ] ] ].
	aScripter
		clickStep: [ :s | 
			s
				onChildFromBlock: [ :element | 
					element parent
						allChildrenBreadthFirstDetect: [ :each | each isKindOf: BrSimpleList ]
						ifFound: [ :each | each children first children at: 2 ]
						ifNone: [ self error: 'Drop down not found' ] ] ].
	aScripter
		checkStep: [ :s | 
			s
				label: 'Should have two rename editors (receiver type & selector)';
				id: GtSourceCoderEditorId;
				value: [ :each | 
						| count |
						count := 0.
						each
							allChildrenDepthFirstDo: [ :child | (child isKindOf: GtRenameEditor) ifTrue: [ count := count + 1 ] ].
						count ]
					equals: 2 ].
	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> cleanDummyOneObject [
	GtPharoDummyOneObject instA: nil.
	GtPharoDummyOneObject varA: nil
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
	aScripter
		clickStep: [ :s | 
			s
				onSpaceRoot;
				id: aBlElementId ]
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> clickFixItFor: aScripter [
	"An utility method to click on the fixIt button to open a context menu"

	"there is no context menu before clicking on the fixit button"

	<gtExample>
	aScripter
		checkStep: [ :s | 
			s
				onSpaceRoot;
				onBreadthFirstChildOfClass: GtCoderContextMenuContent;
				notExists ].

	aScripter
		clickStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtFixItButton ].	"now it appeared"
	aScripter
		checkStep: [ :s | 
			s
				onSpaceRoot;
				onBreadthFirstChildOfClass: GtCoderContextMenuContent;
				exists ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> clickReorderParameter: aScripter variables: variableNames [
	| text |
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check selected text';
				elementSatisfies: [ :aSourceEditor | 
					text := aSourceEditor text asString.
					(('*: <1s> *: <2s>' expandMacrosWithArguments: variableNames) match: text)
						or: [ ('*: <2s> *: <1s>' expandMacrosWithArguments: variableNames) match: text ] ];
				id: GtSourceCoderEditorId ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Open context menu';
				id: #'reorder-parameter-button' ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check selected text';
				elementSatisfies: [ :aSourceEditor | 
					| string |
					string := aSourceEditor text asString.
					text ~= string
						and: [ (('*: <1s> *: <2s>' expandMacrosWithArguments: variableNames) match: text)
								or: [ ('*: <2s> *: <1s>' expandMacrosWithArguments: variableNames) match: text ] ] ];
				id: GtSourceCoderEditorId ].

	self checkHasTwoReorderAttributes: aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderCollapseProgrammatically [
	<gtExample>
	| aScripter |
	aScripter := self coderExpandedByDefault.

	aScripter
		doStep: [ :s | 
			s
				action: [ :aCoderViewModel | aCoderViewModel collapse ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert view model is not expanded';
				satisfies: [ :aCoderViewModel | aCoderViewModel expanded not ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert view model is not focused';
				satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert element is collapsed';
				satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isCollapsed ];
				onSelf ].

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderElementWithSelfObject [
	<gtExample>
	| aScripter anObject |
	anObject := GtPharoDummyOneObject new.
	
	aScripter := self
			scripterForBlock: [ self methodCoderWithSelfCalls asCoderViewModel selfObject: anObject ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert view model has self object';
				value: [ :aCoderViewModel | aCoderViewModel selfObject ] equals: anObject;
				onModel ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert element has play and inspect button';
				exists;
				// GtPharoMethodPlayAndInspectActionId ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert element has method two expander';
				exists;
				// GtSourceCoderEditorId;
				// (GtPharoMethodExpanderId indexed: 1) ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert element has method one expander';
				exists;
				// GtSourceCoderEditorId;
				// (GtPharoMethodExpanderId indexed: 2) ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on method two expander';
				// GtSourceCoderEditorId;
				// (GtPharoMethodExpanderId indexed: 1) ].
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert embeded method has play and inspect button';
				exists;
				// GtSourceCoderEditorId;
				// GtSourceCoderExpandedContentElement;
				// GtPharoMethodPlayAndInspectActionId ].
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click embeded method play and inspect button';
				// GtSourceCoderEditorId;
				// GtSourceCoderExpandedContentElement;
				// GtPharoMethodPlayAndInspectActionId ].
	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandClickingOnExpander [
	<gtExample>
	| aScripter |
	aScripter := self coderCollapseProgrammatically.

	aScripter
		clickStep: [ :s | 
			s
				id: GtSourceCoderExpanderToggleId ].

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
				onSelf ].

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandClickingOnHeader [
	<gtExample>
	| aScripter |
	aScripter := self coderCollapseProgrammatically.

	aScripter
		clickStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtSourceCoderCollapsedContentElement ].

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :aCoderViewModel | aCoderViewModel focused ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
				onSelf ].

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandProgrammatically [
	<gtExample>
	| aScripter |
	aScripter := self coderCollapseProgrammatically.

	aScripter
		doStep: [ :s | 
			s
				label: 'Expand view model';
				action: [ :aCoderViewModel | aCoderViewModel expand ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert view model is expanded';
				satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert view model is not focused';
				satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert element is expanded';
				satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
				onSelf ].

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandedByDefault [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self binaryMethodCoder asCoderViewModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert view model is expanded';
				satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert view model is not focused';
				satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert element is expanded';
				satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
				onSelf ].

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
	aScripter
		substep: 'Collapse and Check Coder'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on Expander';
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Coder UI is Expanded';
						satisfies: [ :aCoderElement | aCoderElement isExpanded not ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Coder Collapsed Label Text';
						value: [ :aLabelElement | aLabelElement text asString ]
							equals: [ aMethod selector ];
						id: GtSourceCoderCollapsedTextId ] ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoMethodCoderByScripterExamples >> contextMenuCopy [
	<gtExample>
	<after: #cleanUp>
	| aScripter expectedCopiedString |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new coderOnClassUnaryMethodThatCreatesPoint.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
	
	expectedCopiedString := '	| aPoint |
	
	aPoint := 196@400'.
	self selectTextFor: aScripter from: 13 to: 45 andCheck: expectedCopiedString.
	
	Clipboard clipboardText: ''.
	self openAndClickOnContextMenuItemFor: aScripter id: GtTextualCoderCopyContextMenuItemId.
	self 
		assert: Clipboard clipboardText asString 
		equals: expectedCopiedString.
	
	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoMethodCoderByScripterExamples >> contextMenuCut [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new
						coderOnClassUnaryMethodThatCreatesPoint.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].
	self
		selectTextFor: aScripter
		from: 38
		to: 45
		andCheck: '196@400'.

	Clipboard clipboardText: ''.
	self
		openAndClickOnContextMenuItemFor: aScripter
		id: GtTextualCoderCutContextMenuItemId.
	self assert: Clipboard clipboardText asString equals: '196@400'.

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :aCoder | (aCoder currentSourceString includesSubstring: '196@400') not ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoMethodCoderByScripterExamples >> contextMenuPaste [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new
						coderOnClassUnaryMethodThatCreatesPoint.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	self
		selectTextFor: aScripter
		from: 38
		to: 45
		andCheck: '196@400'.

	Clipboard clipboardText: '400@196'.
	self
		openAndClickOnContextMenuItemFor: aScripter
		id: GtTextualCoderPasteContextMenuItemId.
	self assert: Clipboard clipboardText asString equals: '400@196'.

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :aCoder | (aCoder currentSourceString includesSubstring: '196@400') not ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				satisfies: [ :aCoder | aCoder currentSourceString includesSubstring: '400@196' ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> createdClassThatDoesntExist [
	^ 'ClassThatDoesNotExist6561'
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> createdMethodThatIsNotImplemented [
	^ 'messageThatIsNotImplmented6561'
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> dummyOneObject [
	^ GtPharoDummyOneObject new instA: 12
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

	aScripter
		substeps: 'Open method completer'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Append class name and a selector part';
						action: [ :anEditor | 
							anEditor inserter
								atEnd;
								string: ' ' , GtPharoMethodCoderExamples name , ' new '
										, ((GtPharoMethodCoderExamples >> #many:many:many:many:many:many:arguments:)
												selector first: 4);
								insert.

							anEditor editor moveCursorTo: anEditor text size.

							self assert: anEditor editor hasCursors ];
						id: GtSourceCoderEditorId ].

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

	aScripter
		substeps: 'Select and insert method'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Select method with many arguments';
						block: [ :element | 
							| items item i text |
							i := 1.
							text := (GtPharoMethodCoderExamples
									>> #many:many:many:many:many:many:arguments:) selector asString.
							items := element items.
							[ item isNil and: [ i <= items size ] ]
								whileTrue: [ (items at: i) label = text
										ifTrue: [ item := items at: i ]
										ifFalse: [ i := i + 1 ] ].
							self
								assert: item notNil
								description: [ 'Cannot find completer selector: {1}' format: {text} ].
							element selectOne: i ];
						onSpaceRoot;
						id: #'completion-list' ].

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
					aStep
						typeStep: [ :s | 
							s
								text: '''arg' , anIndex asString , '''';
								id: GtSourceCoderEditorId ] ]
				separatedBy: [ aStep shortcut
						label: 'Complete with TAB key';
						combination: BlKeyCombination tab;
						id: GtSourceCoderEditorId;
						play ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert method source code content';
						value: [ :anEditor | anEditor text characters ]
							equals: self finalCompleterSourceCode;
						id: GtSourceCoderEditorId ] ].

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
		contextActionAtLeast: 5.

	self checkFor: aScripter existenceOfContextActionNamed: 'Evaluate example'.
	self checkFor: aScripter existenceOfContextActionNamed: 'Evaluate and inspect example result'.

	^ aScripter
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI_PlayAndInspect [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI_ExpandedFromUI_CheckActionButtons.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click evaluate and inspect';
				id: GtMethodCoderPlayAndInspectExampleActionId ].

	^ aScripter
]

{ #category : #'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI_RemovePragma [
	<gtExample>
	| aScripter aNumberOfContextActionElements |
	aScripter := self exampleMethodCoderUI_ExpandedFromUI.

	aScripter
		substeps: 'Remove Pragma'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Get number of context actions';
						block: [ :anElement | 
							aNumberOfContextActionElements := anElement childrenCount ];
						onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
						onChildAt: 3 ].
		
			aStep
				doStep: [ :s | 
					s
						label: 'Delete e character from <gtExample>
	<noTest>';
						action: [ :anEditor | 
							anEditor deleter
								from: 20 to: 21;
								delete ];
						id: GtSourceCoderEditorId ].

			self
				checkFor: aStep
				numberOfMainActions: 5
				contextAction: aNumberOfContextActionElements - 5.

			self checkFor: aStep absenceOfContextActionNamed: 'Play Example' ].

	^ aScripter
]

{ #category : #utilities }
GtPharoMethodCoderByScripterExamples >> expandFromUI: aScripter method: aMethod [
	<gtExample>
	aScripter
		substep: 'Expand and Check Coder'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on Expander';
						onChildAt: 1 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Coder UI is Expanded';
						satisfies: [ :aCoderElement | aCoderElement isExpanded ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert Coder Editor Text';
						value: [ :anEditorElement | anEditorElement editor text asString ]
							equals: [ aMethod sourceCode ];
						id: GtSourceCoderEditorId ] ].

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
	aScripter := self scripterForBlock: [ GtPharoSnippetCoder new ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a class that does not exist';
				action: [ :aCoder | aCoder appendString: String cr , String tab , self createdClassThatDoesntExist ];
				onModel ].

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
	aScripter := self fixitCreateClassInPlayground_02_click_fixit.	"there is no create behavior element before clicking on the menu"
	aScripter
		assertStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtCreationFormWidget;
				notExists ].

	aScripter
		clickStep: [ :s | 
			s
				onSpaceRoot;
				id: (GtDefineClassFixItActionElementId indexed: 1) ].	"now it appeared"
	aScripter
		assertStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtCreationFormWidget;
				exists ].	"and it should be saveable"
	aScripter
		assertStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtCreationFormWidget;
				id: #toolbar;
				onChildAt: 1;
				value: #isEnabled equals: false ].	"context menu should disappear"
	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				onBreadthFirstChildOfClass: GtCoderContextMenuContent;
				notExists ].

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

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a class that does not exist';
				action: [ :aCoder | aCoder appendString: String cr , String tab , self createdClassThatDoesntExist ];
				onModel ].

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
	aScripter := self fixitCreateClass_02_click_fixit.	"there is no create behavior element before clicking on the menu"
	aScripter
		assertStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtCreationFormWidget;
				notExists ].

	aScripter
		clickStep: [ :s | 
			s
				onSpaceRoot;
				id: (GtDefineClassFixItActionElementId indexed: 1) ].	"now it appeared"
	aScripter
		assertStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtCreationFormWidget;
				exists ].	"and it should be saveable"
	aScripter
		assertStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtCreationFormWidget;
				id: #toolbar;
				onChildAt: 1;
				satisfies: #isEnabled ].	"context menu should disappear"
	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				onBreadthFirstChildOfClass: GtCoderContextMenuContent;
				notExists ].

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

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a variable that does not exist';
				action: [ :aCoderViewModel | aCoderViewModel coderModel appendString: String cr , String tab , 'instance' ];
				onModel ].

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

	self
		clickFixItActionFor: aScripter
		id: (GtDefineInstanceVariableFixItActionElementId indexed: 1).

	aScripter
		assertStep: [ :s | 
			s
				value: [ :aCoderViewModel | aCoderViewModel coderModel currentSourceString ]
					equals: [ :aCoderViewModel | 
						String
							streamContents: [ :aStream | 
								aStream
									nextPutAll: (aCoderViewModel coderModel attributeNamed: #dummyMethod) selector;
									cr;
									tab;
									nextPutAll: 'instance' ] ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Make sure the instance variable was created';
				satisfies: [ :aCoderViewModel | 
					(aCoderViewModel coderModel attributeNamed: #dummyMethod) realClass
						hasSlotNamed: #instance ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Make sure the method still mofied';
				satisfies: [ :aCoderViewModel | aCoderViewModel coderModel isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Make sure the method is not saved/recompiled after adding a temporary variable';
				value: [ :aCoderViewModel | 
						(aCoderViewModel coderModel attributeNamed: #dummyMethod) systemMethod
							sourceCode ]
					equals: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) realMethod sourceCode ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Make sure the text was deselected';
				satisfies: [ :aCoderViewModel | aCoderViewModel hasSelection not ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateMethodInPlayground_01_setup [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ GtPharoSnippetCoder new ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method that does not exist';
				action: [ :aCoder | aCoder appendString: 'Object new ', self createdMethodThatIsNotImplemented ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateMethodInPlayground_02_click_fixit [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateMethodInPlayground_01_setup.
	self clickFixItFor: aScripter.
	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateTempVar_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder asCoderViewModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'type in a variable that does not exist';
				action: [ :aCoderViewModel | aCoderViewModel coderModel appendString: String cr , String tab , 'temporary' ];
				onModel ].

	self
		selectTextFor: aScripter
		from: 9
		to: 18
		andCheck: 'temporary'.
	self clickFixItFor: aScripter.

	^ aScripter
]

{ #category : #'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateTempVar_02_add [
	<gtExample>
	| aScripter |
	aScripter := self fixitCreateTempVar_01_setup.

	self
		clickFixItActionFor: aScripter
		id: (GtDefineTemporaryVariableFixItActionElementId indexed: 1).

	aScripter
		assertStep: [ :s | 
			s
				value: [ :aCoderViewModel | aCoderViewModel coderModel currentSourceString ]
					equals: [ :aCoderViewModel | 
						String
							streamContents: [ :aStream | 
								aStream
									nextPutAll: (aCoderViewModel coderModel attributeNamed: #dummyMethod) selector;
									cr;
									tab;
									nextPutAll: '| temporary |';
									cr;
									tab;
									nextPutAll: 'temporary' ] ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Make sure the method still mofied';
				satisfies: [ :aCoderViewModel | aCoderViewModel coderModel isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Make sure the method is not saved/recompiled after adding a temporary variable';
				value: [ :aCoderViewModel | 
						(aCoderViewModel coderModel attributeNamed: #dummyMethod) systemMethod
							sourceCode ]
					equals: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) realMethod sourceCode ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Make sure the text was deselected';
				satisfies: [ :aCoderViewModel | aCoderViewModel hasSelection not ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstactInstVar_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: ('
	^ {1} isNil' format: {(aCoder attributeNamed: #dummyMethod) anyInstVarName}) ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forAbstactInstVar_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the assignment node';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 13 to: 14;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_03_hover_abstract_variable [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forAbstractInstVar_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover abstract';
				onSpaceRoot;
				id: #'context-menu--abstract-variable' ].

	^ aScripter
]

{ #category : #'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_04_click_abstract_variable [
	<gtExample>
	| aScripter |
	aScripter := self forAbstractInstVar_03_hover_abstract_variable.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click abstract variable';
				onSpaceRoot;
				id: #'context-menu--abstract-variable' ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: 'Unique
	^ (1 to: self items size) detect: [:each | (self items at: each) notNil]' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forAddParameterFromValue_01_setup.

	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method pattern';
				action: [ :aSourceEditor | 
					| index |
					index := aSourceEditor text asString indexOfSubCollection: '(1'.
					aSourceEditor selecter
						from: index to: index + 1;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_03_hover_add_parameter [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forAddParameterFromValue_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover add parameter';
				onSpaceRoot;
				id: #'context-menu--add-parameter' ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_04_click_add_parameter [
	<gtExample>
	| aScripter |
	aScripter := self forAddParameterFromValue_03_hover_add_parameter.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click add parameter';
				onSpaceRoot;
				id: #'context-menu--add-parameter' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'{1}Unique: anObject
	^ (1 to: self items size) detect: [:each | (self items at: each) notNil]'
							format: {(aCoder attributeNamed: #dummyMethod) selector} ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor attribute';
				value: [ :aCoderEditor | 
						| interval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
							indicesDo: [ :aStart :anEnd | interval ifNil: [ interval := aStart to: anEnd ] ].
						interval ]
					equals: [ :aCoderEditor | 1 to: (aCoderEditor text asString indexOf: $:) ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | 
						| index |
						index := (aCoderEditor text asString indexOf: Character cr) - 1.
						index to: index ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor is not focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor has focus';
				satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor isFocused ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameterFromValue_05_enter_method_name [
	<gtExample>
	| aScripter |
	aScripter := self forAddParameterFromValue_04_click_add_parameter.

	(aScripter type: 'someOtherMethodName:') play.

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	(aScripter keyPress: BlKeyboardKey return) play.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: 'Unique
	^ self printString' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forAddParameter_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method pattern';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 0 to: 1;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_03_hover_add_parameter [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forAddParameter_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover add parameter';
				onSpaceRoot;
				id: #'context-menu--add-parameter' ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_04_click_add_parameter [
	<gtExample>
	| aScripter |
	aScripter := self forAddParameter_03_hover_add_parameter.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click add parameter';
				onSpaceRoot;
				id: #'context-menu--add-parameter' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'{1}Unique: anObject
	^ self printString' format: {(aCoder attributeNamed: #dummyMethod) selector} ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor attribute';
				value: [ :aCoderEditor | 
						| interval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
							indicesDo: [ :aStart :anEnd | interval ifNil: [ interval := aStart to: anEnd ] ].
						interval ]
					equals: [ :aCoderEditor | 1 to: (aCoderEditor text asString indexOf: $:) ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | 
						| index |
						index := (aCoderEditor text asString indexOf: Character cr) - 1.
						index to: index ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor is not focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor has focus';
				satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor isFocused ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	^ aScripter
]

{ #category : #'examples - add parameter' }
GtPharoMethodCoderByScripterExamples >> forAddParameter_05_enter_method_name [
	<gtExample>
	| aScripter |
	aScripter := self forAddParameter_04_click_add_parameter.

	(aScripter type: 'someOtherMethodName:') play.

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	(aScripter keyPress: BlKeyboardKey return) play.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	(aScripter type: 'parameter') play.

	(aScripter keyPress: BlKeyboardKey return) play.

	(aScripter type: '#()') play.

	(aScripter keyPress: BlKeyboardKey return) play.

	aScripter
		assertStep: [ :s | 
			s
				onChildFromBlock: [ :element | 
					element parent
						allChildrenBreadthFirstDetect: [ :each | each id = GtRefactoringsPreviewAcceptId uniqueInstance ]
						ifFound: [ :each | each ]
						ifNone: [ self error: 'Apply button not found' ] ];
				value: [ :button | button isVisible ] equals: true ].

	^ aScripter
]

{ #category : #'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: '
	| cache |
	cache := IdentityDictionary new.
	^ cache' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forConvertTempToInst_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the variable node';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 11 to: 12;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_03_hover_convert_temporary_to_instance_variable [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forConvertTempToInst_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover convert';
				onSpaceRoot;
				id: #'context-menu--convert-temp-to-inst-var' ].

	^ aScripter
]

{ #category : #'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_04_click_convert [
	<gtExample>
	| aScripter |
	aScripter := self
			forConvertTempToInst_03_hover_convert_temporary_to_instance_variable.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click convert';
				onSpaceRoot;
				id: #'context-menu--convert-temp-to-inst-var' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - create accessors' }
GtPharoMethodCoderByScripterExamples >> forCreateAccessors_03_hover_create_accessors [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forAbstractInstVar_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover abstract';
				onSpaceRoot;
				id: #'context-menu--create-accessors' ].

	^ aScripter
]

{ #category : #'examples - create accessors' }
GtPharoMethodCoderByScripterExamples >> forCreateAccessors_04_click_create_accessors [
	<gtExample>
	| aScripter |
	aScripter := self forCreateAccessors_03_hover_create_accessors.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click create accessors';
				onSpaceRoot;
				id: #'context-menu--create-accessors' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: '
	^ self printString size' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_02_select [
	<gtExample>
	| aScripter |
	aScripter := self forExtractTemp_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method to extract';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 11 to: 27;
						select ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert selected text';
				value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
					equals: [ 'self printString' ];
				id: GtSourceCoderEditorId ].

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

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover extract temp';
				onSpaceRoot;
				id: GtSourceCoderExtractTempVarContextMenuItemId ].

	^ aScripter
]

{ #category : #'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_05_click_extract_temp [
	<gtExample>
	| aScripter |
	aScripter := self forExtractTemp_04_hover_extract_temp.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click extract temp';
				onSpaceRoot;
				id: GtSourceCoderExtractTempVarContextMenuItemId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'method1
	| _ |
	_ := self printString.
	^ _ size' ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | 
						| index |
						index := aCoderEditor text asString indexOfSubCollection: '_ :='.
						index to: index ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor is not focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor has focus';
				satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert variable name editor source code';
				value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert variable name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor isFocused ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

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

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'method1
	| a |
	a := self printString.
	^ a size' ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor attribute';
				value: [ :aCoderEditor | 
						aCoderEditor text
							hasAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ] ]
					equals: false;
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor is focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forExtraction_02_method_parameter_cannot_be_extracted [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method to extract';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 9 to: 17;
						select ];
				id: GtSourceCoderEditorId ].

	self openContextMenu: aScripter.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert extract method doesn''t exist';
				onSpaceRoot;
				notExists;
				id: GtMethodCoderExtractMethodContextMenuItemId ].

	^ aScripter
]

{ #category : #'examples - inline all self sends' }
GtPharoMethodCoderByScripterExamples >> forInlineAllSelfSends_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: '
	^ self isNil' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - inline all self sends' }
GtPharoMethodCoderByScripterExamples >> forInlineAllSelfSends_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forInlineAllSelfSends_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method node';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 1 to: 2;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - inline all self sends' }
GtPharoMethodCoderByScripterExamples >> forInlineAllSelfSends_03_hover_inline_message_send [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forInlineAllSelfSends_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover inline self send';
				onSpaceRoot;
				id: #'context-menu--inline-self-sends' ].

	^ aScripter
]

{ #category : #'examples - inline all self sends' }
GtPharoMethodCoderByScripterExamples >> forInlineAllSelfSends_04_click_inline_send [
	<gtExample>
	| aScripter |
	aScripter := self forInlineAllSelfSends_03_hover_inline_message_send.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click inline temp';
				onSpaceRoot;
				id: #'context-menu--inline-self-sends' ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: '
	^ self isNil' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forInlineMessageSend_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the message node';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 13 to: 14;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_03_hover_inline_message_send [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forInlineMessageSend_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover inline message send';
				onSpaceRoot;
				id: #'context-menu--inline-message' ].

	^ aScripter
]

{ #category : #'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_04_click_inline_message_send [
	<gtExample>
	| aScripter |
	aScripter := self forInlineMessageSend_03_hover_inline_message_send.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click inline temp';
				onSpaceRoot;
				id: #'context-menu--inline-message' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'method1
	^ false' ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - inline parameter' }
GtPharoMethodCoderByScripterExamples >> forInlineParameter_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: 'Unique: arg
	^ arg printString' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - inline parameter' }
GtPharoMethodCoderByScripterExamples >> forInlineParameter_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forInlineParameter_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method arg';
				action: [ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString indexOfSubCollection: 'arg') - 1.
					aSourceEditor selecter
						from: index to: index + 3;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - inline parameter' }
GtPharoMethodCoderByScripterExamples >> forInlineParameter_03_hover_inline_parameter [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forInlineParameter_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover inline parameter';
				onSpaceRoot;
				id: #'context-menu--inline-parameter' ].

	^ aScripter
]

{ #category : #'examples - inline parameter' }
GtPharoMethodCoderByScripterExamples >> forInlineParameter_04_click_inline_parameter [
	<gtExample>
	| aScripter |
	aScripter := self forInlineParameter_03_hover_inline_parameter.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click inline parameter';
				onSpaceRoot;
				id: #'context-menu--inline-parameter' ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: '
	| str |
	str := self printString.
	^ str size' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forInlineTemp_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the assignment node';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 22 to: 24;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_03_hover_inline_temp [
	<gtExample>
	| scripter |
	scripter := self openContextMenu: self forInlineTemp_02_cursor.

	scripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover inline temp';
				onSpaceRoot;
				id: #'context-menu--inline-temp' ].

	scripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ scripter
]

{ #category : #'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_04_click_inline_temp [
	<gtExample>
	| aScripter |
	aScripter := self forInlineTemp_03_hover_inline_temp.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click inline temp';
				onSpaceRoot;
				id: #'context-menu--inline-temp' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'method1
	^ self printString size' ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: ': anObject
	| temp |
	temp := 42.
	^ temp factorial printString , anObject printString' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_02_select [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method to extract';
				action: [ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString indexOf: $^) + 1.
					aSourceEditor selecter
						from: index to: aSourceEditor text size;
						select ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert selected text';
				value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
					equals: [ 'temp factorial printString , anObject printString' ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_03_context_menu [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_02_select.
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_04_hover_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_03_context_menu.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover extract method';
				onSpaceRoot;
				id: GtMethodCoderExtractMethodContextMenuItemId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forKeywordExtraction_05_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordExtraction_04_hover_extract_method.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click extract method';
				onSpaceRoot;
				id: GtMethodCoderExtractMethodContextMenuItemId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

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

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

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
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].
	aScripter
		doStep: [ :s | 
			s
				label: 'type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: ': anObject
	| temp |
	temp := 42.
	^ OrderedCollection with: self with: anObject with: temp factorial printString , anObject printString' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forKeywordMoveMethod_02_select [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordMoveMethod_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select the variable';
				action: [ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString
							indexOfSubCollection: 'OrderedCollection') - 1.
					aSourceEditor selecter
						from: index to: index + 'OrderedCollection' size;
						select ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert selected text';
				value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
					equals: [ 'OrderedCollection' ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forKeywordMoveMethod_03_context_menu_move_method [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordMoveMethod_02_select.
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				id: GtSourceCoderEditorId ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click move method';
				onSpaceRoot;
				id: #'context-menu--move-method' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

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

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	self clickReorderParameter: aScripter variables: #('self' 'anObject').
	(aScripter keyPress: BlKeyboardKey tab) play.
	self checkKeywordRenameEditor: aScripter.

	(aScripter type: 'b:') play.
	(aScripter keyPress: BlKeyboardKey return) play.

	self clickReorderParameter: aScripter variables: #('self' 'anObject').

	^ aScripter
]

{ #category : #'examples - rename variable' }
GtPharoMethodCoderByScripterExamples >> forKeywordRenameLocalVariableParens [
	<gtExample>
	| scripter |
	scripter := self
			scripterForBlock: [ GtPharoMethodCoder forMethod: thisContext method method ].
	[ (scripter) yourself ] argumentCount.	"leave parens around variable".

	scripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	scripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId;
		play.

	scripter assert
		label: 'Assert editor is focused';
		satisfies: [ :anEditorElement | anEditorElement isFocused ];
		id: GtSourceCoderEditorId;
		play.

	scripter do
		label: 'Position cursor';
		id: GtSourceCoderEditorId;
		block: [ :each | 
			each editor
				moveCursorTo: (thisContext method method sourceCode indexOfSubCollection: 'scripter') + 1 ];
		play.

	scripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId;
		play.

	self checkFor: scripter renameEditorExists: true.

	^ scripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRenameWithReorderArgs [
	<gtExample>
	| scripter |
	[ self ifNil: [ 1 ] ifNotNil: [ 2 ] ] value.
	scripter := self
			scripterForBlock: [ GtPharoMethodCoder forMethod: thisContext method method ].

	scripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId;
		play.

	scripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId;
		play.

	scripter assert
		label: 'Assert editor is focused';
		satisfies: [ :anEditorElement | anEditorElement isFocused ];
		id: GtSourceCoderEditorId;
		play.

	scripter do
		label: 'Position cursor';
		id: GtSourceCoderEditorId;
		block: [ :each | 
			each editor
				moveCursorTo: (thisContext method method sourceCode indexOfSubCollection: 'ifNil') + 1 ];
		play.

	scripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId;
		play.

	self checkFor: scripter renameEditorExists: true.
	self checkFor: scripter refactoringPreviewButtonExists: false.

	scripter click
		id: #'reorder-parameter-button';
		play.

	self checkFor: scripter renameEditorExists: true.
	self checkFor: scripter refactoringPreviewButtonExists: true.

	scripter click
		id: #'reorder-parameter-button';
		play.

	self checkFor: scripter renameEditorExists: true.
	self checkFor: scripter refactoringPreviewButtonExists: false.

	scripter click
		id: #'reorder-parameter-button';
		play.

	self checkFor: scripter renameEditorExists: true.
	self checkFor: scripter refactoringPreviewButtonExists: true.

	^ scripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forKeywordMethodInPackagedClass.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				id: GtSourceCoderEditorId ].

	aScripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId;
		play.

	self checkFor: aScripter saveButtonEnabled: true.
	self checkFor: aScripter discardButtonExists: false.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert editor is focused';
				satisfies: [ :anEditorElement | anEditorElement isFocused ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert cursor position';
				value: [ :anEditorElement | anEditorElement editor cursors positions ]
					equals: [ #(0) ];
				id: GtSourceCoderEditorId ].

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

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor all selected';
				value: [ :anEditor | anEditor editor selectedText asString ]
					equals: [ (aScripter model attributeNamed: #dummyMethod) selector allButLast ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_03_move_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordRename_02_shortcut.	"this positions the cursor before `:`"
	(aScripter keyPress: BlKeyboardKey arrowLeft) play.
	(aScripter keyPress: BlKeyboardKey arrowRight) play.

	self checkFor: aScripter refactoringPreviewButtonExists: false.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert cursor position';
				value: [ :anEditor | anEditor editor cursors positions ]
					equals: [ {(aScripter model attributeNamed: #dummyMethod) selector size - 1} ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor all selected';
				value: [ :anEditor | anEditor editor selectedText asString ] equals: [ '' ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

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

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert text';
				value: [ :anEditor | anEditor text asString ]
					equals: [ (aScripter model attributeNamed: #dummyMethod) selector allButLast , 'New' ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_05_click_preview [
	<gtExample>
	| aScripter |
	aScripter := self forKeywordRename_04_type.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click refactoring preview button';
				id: GtSourceCoderEditorId;
				id: #previewCheckButton ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert that refactorings preview appeared';
				exists;
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].

	^ aScripter
]

{ #category : #'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_06_click_apply [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self forKeywordRename_05_click_preview.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click refactorings apply button';
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].

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
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: (self moveVariableSource
								format: {'|temp|'.
										''}) ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - move variable scope' }
GtPharoMethodCoderByScripterExamples >> forMoveVariableScope_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forMoveVariableScope_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the variable node';
				action: [ :aSourceEditor | 
					| index |
					index := aSourceEditor text asString indexOfSubCollection: 'temp'.
					aSourceEditor selecter
						from: index - 1 to: index + 3;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - move variable scope' }
GtPharoMethodCoderByScripterExamples >> forMoveVariableScope_03_hover_move_variable_declaration [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forMoveVariableScope_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover protect';
				onSpaceRoot;
				id: #'context-menu--move-variable-declaration' ].

	^ aScripter
]

{ #category : #'examples - move variable scope' }
GtPharoMethodCoderByScripterExamples >> forMoveVariableScope_04_click_move_variable_declaration [
	<gtExample>
	| aScripter |
	aScripter := self forMoveVariableScope_03_hover_move_variable_declaration.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click move variable';
				onSpaceRoot;
				id: #'context-menu--move-variable-declaration' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | (GtPharoParser parse: aCoder currentSourceString) body ]
					equals: [ :aCoder | 
						GtPharoParser
							parse: (self moveVariableSource
									format: {''.
											'|temp|'})
							startingAt: GtPharoParser startingStateForMethodSequence ];
				onModel ].

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

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: ('
	^ {1}' format: {(aCoder attributeNamed: #dummyMethod) anyInstVarName}) ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forProtectInstVar_01_setup.

	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the variable node';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 11 to: 12;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_03_hover_protect_variable [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forProtectInstVar_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover protect';
				onSpaceRoot;
				id: #'context-menu--protect-variable' ].

	^ aScripter
]

{ #category : #'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_04_click_Protect_variable [
	<gtExample>
	| aScripter |
	aScripter := self forProtectInstVar_03_hover_protect_variable.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click protect variable';
				onSpaceRoot;
				id: #'context-menu--protect-variable' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

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

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method';
				action: [ :aCoder | 
					aCoder
						appendString: ('
	^ {1}' format: {rootClass realClass superclass allInstVarNames last}) ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - pull down variable' }
GtPharoMethodCoderByScripterExamples >> forPullDownVariable_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forPullDownVariable_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the variable';
				action: [ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString indexOfSubCollection: '^ ') + 1.
					aSourceEditor selecter
						from: index to: index + 8;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - pull down variable' }
GtPharoMethodCoderByScripterExamples >> forPullDownVariable_03_hover_pull_down [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forPullDownVariable_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover pull down variable';
				onSpaceRoot;
				id: #'context-menu--pull-down-variable' ].

	^ aScripter
]

{ #category : #'examples - pull down variable' }
GtPharoMethodCoderByScripterExamples >> forPullDownVariable_04_click_pull_down [
	<gtExample>
	| aScripter |
	aScripter := self forPullDownVariable_03_hover_pull_down.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click pull down variable';
				onSpaceRoot;
				id: #'context-menu--pull-down-variable' ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - push down method' }
GtPharoMethodCoderByScripterExamples >> forPushDownMethod_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | env rootClass method coder |
				env := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 3.
				rootClass := env anyDummyRootClass.
				method := rootClass anyDummyUnaryMethod realMethod.

				coder := GtPharoMethodCoder forMethod: method.
				coder attributeNamed: #dummyEnvironment put: env.
				coder attributeNamed: #dummyMethod put: rootClass anyDummyUnaryMethod.
				coder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: 'Unique
	^ self printString' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - push down method' }
GtPharoMethodCoderByScripterExamples >> forPushDownMethod_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forPushDownMethod_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method pattern';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 0 to: 1;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - push down method' }
GtPharoMethodCoderByScripterExamples >> forPushDownMethod_03_hover_push_down_method [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forPushDownMethod_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover push down method';
				onSpaceRoot;
				id: #'context-menu--push-down-method' ].

	^ aScripter
]

{ #category : #'examples - push down method' }
GtPharoMethodCoderByScripterExamples >> forPushDownMethod_04_click_push_down_method [
	<gtExample>
	| aScripter |
	aScripter := self forPushDownMethod_03_hover_push_down_method.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click push up method';
				onSpaceRoot;
				id: #'context-menu--push-down-method' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

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

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: '
	^ self printString' ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - push up method' }
GtPharoMethodCoderByScripterExamples >> forPushUpMethod_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forPushUpMethod_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method pattern';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 0 to: 7;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - push up method' }
GtPharoMethodCoderByScripterExamples >> forPushUpMethod_03_hover_push_up_method [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forPushUpMethod_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover push up method';
				onSpaceRoot;
				id: #'context-menu--push-up-method' ].

	^ aScripter
]

{ #category : #'examples - push up method' }
GtPharoMethodCoderByScripterExamples >> forPushUpMethod_04_click_push_up_method [
	<gtExample>
	| aScripter |
	aScripter := self forPushUpMethod_03_hover_push_up_method.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click push up method';
				onSpaceRoot;
				id: #'context-menu--push-up-method' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

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

	aScripter
		doStep: [ :s | 
			s
				label: 'Type in a method';
				action: [ :aCoder | 
					aCoder
						appendString: ('
	^ {1}' format: {rootClass realClass allInstVarNames last}) ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - push up variable' }
GtPharoMethodCoderByScripterExamples >> forPushUpVariable_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forPushUpVariable_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the variable';
				action: [ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString indexOfSubCollection: '^ ') + 1.
					aSourceEditor selecter
						from: index to: index + 8;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - push up variable' }
GtPharoMethodCoderByScripterExamples >> forPushUpVariable_03_hover_push_up [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forPushUpVariable_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover push up variable';
				onSpaceRoot;
				id: #'context-menu--push-up-variable' ].

	^ aScripter
]

{ #category : #'examples - push up variable' }
GtPharoMethodCoderByScripterExamples >> forPushUpVariable_04_click_push_up [
	<gtExample>
	| aScripter |
	aScripter := self forPushUpVariable_03_hover_push_up.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click push up variable';
				onSpaceRoot;
				id: #'context-menu--push-up-variable' ].

	aScripter
		assertStep: [ :s | 
			s
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
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Type-in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: (': unusedArg
	{1} := Set new' format: {(aCoder attributeNamed: #dummyMethod) anyInstVarName}) ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_02_cursor [
	<gtExample>
	| aScripter |
	aScripter := self forRemoveParameter_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the parameter node';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 11 to: 12;
						select ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_03_hover_remove_parameter [
	<gtExample>
	| aScripter |
	aScripter := self openContextMenu: self forRemoveParameter_02_cursor.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover remove parameter';
				onSpaceRoot;
				id: #'context-menu--remove-parameter' ].

	^ aScripter
]

{ #category : #'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_04_click_remove_parameter [
	<gtExample>
	| aScripter |
	aScripter := self forRemoveParameter_03_hover_remove_parameter.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click remove parameter';
				onSpaceRoot;
				id: #'context-menu--remove-parameter' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert there is no selected text';
				value: [ :aSourceEditor | aSourceEditor editor hasSelection ]
					equals: [ false ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | 
						| index |
						index := (aCoderEditor text asString indexOfSubCollection: 'unusedArg')
								+ 8.
						index to: index ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: (': anObject
	{1} := anObject.
	{1} := {1} + 42.'
								format: {(aCoder attributeNamed: #dummyMethod) anyInstVarName}) ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_02_select [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select part of the method to extract';
				action: [ :aSourceEditor | 
					aSourceEditor selecter
						from: 42 to: 67;
						select ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert selected text';
				value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
					equals: [ '{1} := {1} + 42'
							format: {(aScripter model attributeNamed: #dummyMethod) anyInstVarName} ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_03_context_menu [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_02_select.
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_04_hover_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_03_context_menu.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Hover extract method';
				onSpaceRoot;
				id: GtMethodCoderExtractMethodContextMenuItemId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_05_click_extract_method [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_04_hover_extract_method.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click extract method';
				onSpaceRoot;
				id: GtMethodCoderExtractMethodContextMenuItemId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'{1}: anObject
	{2} := anObject.
	self _'
							format: {(aCoder attributeNamed: #dummyMethod) selector.
									(aCoder attributeNamed: #dummyMethod) anyInstVarName} ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor is not focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor has focus';
				satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor source code';
				value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor selected text';
				value: [ :aNameEditor | aNameEditor editor selectedText asString ]
					equals: '_';
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor isFocused ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_06_type_method_name [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_05_click_extract_method.

	aScripter
		typeStep: [ :s | 
			s
				text: (self extractedUnaryMethodNameFor: aScripter model) ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_07_01_accept_with_enter [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_06_type_method_name.

	aScripter
		keyPressStep: [ :s | 
			s
				key: BlKeyboardKey return ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_08_preview_refactoring [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryExtraction_07_01_accept_with_enter.	"Enter opens the preview"
	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId;
				exists ].

	aScripter
		clickStep: [ :s | 
			s
				id: #previewCheckButton ].	"Click should close the preview"
	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId;
				notExists ].

	aScripter
		clickStep: [ :s | 
			s
				id: #previewCheckButton ].

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId;
				exists ].

	^ aScripter
]

{ #category : #'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_09_apply_refactoring [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self forUnaryExtraction_08_preview_refactoring.

	aScripter
		clickStep: [ :s | 
			s
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute does not exist';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ nil ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				onBreadthFirstChildOfClass: GtRefactoringsPreviewButton;
				notExists ].

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forUnaryMoveMethod_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
				environment := aCoder attributeNamed: #dummyEnvironment.
				aCoder ].

	aScripter
		doStep: [ :s | 
			s
				label: 'type in a method with argument';
				action: [ :aCoder | 
					aCoder
						appendString: ': anObject
	^ anObject ' , thisContext method selector ];
				onModel ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Save a method with argument';
				action: [ :aCoder | aCoder save ];
				onModel ].

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forUnaryMoveMethod_02_select [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryMoveMethod_01_setup.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select the variable';
				action: [ :aSourceEditor | 
					| index |
					index := (aSourceEditor text asString indexOfSubCollection: 'anObject') - 1.
					aSourceEditor selecter
						from: index to: index + 'anObject' size;
						select ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert selected text';
				value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
					equals: [ 'anObject' ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forUnaryMoveMethod_03_context_menu_move_method [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryMoveMethod_02_select.
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				id: GtSourceCoderEditorId ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click move method';
				onSpaceRoot;
				id: #'context-menu--move-method' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'{1}: anObject
	^ anObject _' format: {(aCoder attributeNamed: #dummyMethod) selector} ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor is not focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor has focus';
				satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor source code';
				value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor selected text';
				value: [ :aNameEditor | aNameEditor editor selectedText asString ]
					equals: '_';
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor isFocused ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	^ aScripter
]

{ #category : #'examples - move method' }
GtPharoMethodCoderByScripterExamples >> forUnaryMoveMethod_03_context_menu_move_method_and_enter_name [
	<gtExample>
	| aScripter |
	aScripter := self forUnaryMoveMethod_02_select.
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				id: GtSourceCoderEditorId ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click move method';
				onSpaceRoot;
				id: #'context-menu--move-method' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert current source in coder model';
				value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ]
					equals: [ :aCoder | 
						'{1}: anObject
	^ anObject _' format: {(aCoder attributeNamed: #dummyMethod) selector} ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code modified';
				satisfies: [ :aCoder | aCoder isModified ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRenameEditorAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor is not focused';
				satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source editor has focus';
				satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor source code';
				value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor selected text';
				value: [ :aNameEditor | aNameEditor editor selectedText asString ]
					equals: '_';
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert method name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor isFocused ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	(aScripter type: 'someNewMethodName') play.
	(aScripter keyPress: BlKeyboardKey tab) play.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert refactoring changes attribute';
				value: [ :aCoderEditor | 
						| anInterval |
						aCoderEditor text
							findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ]
							indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
						anInterval ]
					equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
				id: GtSourceCoderEditorId ].

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

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the coder editor to give it focus';
				id: GtSourceCoderEditorId ].

	aScripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId;
		play.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert editor is focused';
				satisfies: [ :anEditorElement | anEditorElement isFocused ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert cursor position';
				value: [ :anEditorElement | anEditorElement editor cursors positions ]
					equals: [ #(0) ];
				id: GtSourceCoderEditorId ].

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

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor exists';
				exists;
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert rename editor all selected';
				value: [ :anEditor | anEditor editor selectedText asString ]
					equals: [ (aScripter model attributeNamed: #dummyMethod) selector ];
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: GtRenameEditor ].

	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> initializeDummyOneObject [
	GtPharoDummyOneObject instA: 72.
	GtPharoDummyOneObject varA: 144
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

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithClassSideMethodInstA [
	<gtExample>
	<after: #cleanDummyOneObject>
	| aScripter |
	aScripter := self
			scripterForBlock: [ self methodCoderWithClassSideMethodInstA asCoderViewModel ].

	self initializeDummyOneObject.

	aScripter methodCoder
		assertSelfObjectIs: nil;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyOneObject class;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionExists;
		assertPlayAndInspectExampleActionNotExists;
		select: 'instA' from: 9 to: 14;
		printIt;
		assertPrintItString: GtPharoDummyOneObject instA printString;
		play.
		
	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithClassSideMethodVarA [
	<gtExample>
	<noTest>
	<after: #cleanDummyOneObject>
	| aScripter |
	aScripter := self
			scripterForBlock: [ self methodCoderWithClassSideMethodVarA asCoderViewModel ].

	self initializeDummyOneObject.

	aScripter methodCoder
		assertSelfObjectIs: nil;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyOneObject class;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionExists;
		assertPlayAndInspectExampleActionNotExists;
		select: 'VarA' from: 8 to: 12;
		printIt;
		assertPrintItString: GtPharoDummyOneObject varA printString;
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithFailingExample [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ self methodCoderWithFailingExample asCoderViewModel ].

	aScripter methodCoder
		assertSelfObjectIs: nil;
		assertExplicitProviderClassIs: GtPharoDummyTwoObject;
		assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionNotExists;
		assertPlayAndInspectExampleActionExists;
		assertMethodExpandersCountIs: 1;
		clickOnPlayAndInspectExampleButton;
		assertExampleReturnValueIsKindOf: AssertionFailure;
		assertExampleAssertionHighlightFrom: 94 to: 112;
		clickOnMethodCoderExpander: 1
			insideDo: [ :stepA | 
				stepA
					assertSelfObjectIs: nil;
					assertExplicitProviderClassIs: GtPharoDummyTwoObject;
					assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
					assertHeaderMethodBehaviorIs: GtPharoDummyOneObject;
					assertParentExampleValueIsKindOf: AssertionFailure;
					assertExampleAssertionHighlightFrom: 174 to: 238;
					assertMethodExpandersCountIs: 4;
					assertBindingIsNotDefined: #aValue;
					assertPlayAndInspectActionNotExists;
					assertPlayAndInspectExampleActionNotExists ];
		play.

	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithInstanceSideMethodInstA [
	<gtExample>
	<noTest>
	<after: #cleanDummyOneObject>
	| aScripter |
	self initializeDummyOneObject.

	aScripter := self
			scripterForBlock: [ | aCoderViewModel |
				aCoderViewModel := self methodCoderWithInstanceSideMethodInstA asCoderViewModel.
				aCoderViewModel ].
				
	aScripter methodCoder
		assertSelfObjectIs: nil;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyOneObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionNotExists;
		assertPlayAndInspectExampleActionNotExists;
		select: 'instA' from: 9 to: 14;
		printIt;
		flag: 'The print-it value should be either nil or undeclared temp error. The existing behavior is not correct.';
		assertPrintItString: GtPharoDummyOneObject instA printString;
		play.

	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithInstanceSideMethodInstA_SelfObject [
	<gtExample>
	<after: #cleanDummyOneObject>
	| aScripter anObject |
	anObject := self dummyOneObject.
	self initializeDummyOneObject.

	aScripter := self
			scripterForBlock: [ | aCoderViewModel |
				aCoderViewModel := self methodCoderWithInstanceSideMethodInstA asCoderViewModel.
				aCoderViewModel selfObject: anObject.
				aCoderViewModel ].
				
	aScripter methodCoder
		assertSelfObjectIs: anObject;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyOneObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionExists;
		assertPlayAndInspectExampleActionNotExists;
		select: 'instA'
			from: 9
			to: 14;
		printIt;
		assertPrintItString: 12 printString;
		play.

	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithInstanceSideMethodVarA [
	<gtExample>
	<noTest>
	<after: #cleanDummyOneObject>
	| aScripter |
	self initializeDummyOneObject.

	aScripter := self
			scripterForBlock: [ | aCoderViewModel |
				aCoderViewModel := self methodCoderWithInstanceSideMethodVarA asCoderViewModel.
				aCoderViewModel ].
				
	aScripter methodCoder
		assertSelfObjectIs: nil;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyOneObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionNotExists;
		assertPlayAndInspectExampleActionNotExists;
		select: 'VarA' from: 8 to: 12;
		printIt;
		assertPrintItString: GtPharoDummyOneObject varA printString;
		play.

	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithInstanceSideMethodVarA_SelfObject [
	<gtExample>
	<noTest>
	<after: #cleanDummyOneObject>
	| aScripter anObject |
	anObject := self dummyOneObject.
	self initializeDummyOneObject.

	aScripter := self
			scripterForBlock: [ | aCoderViewModel |
				aCoderViewModel := self methodCoderWithInstanceSideMethodVarA asCoderViewModel.
				aCoderViewModel selfObject: anObject.
				aCoderViewModel ].
				
	aScripter methodCoder
		assertSelfObjectIs: anObject;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyOneObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionExists;
		assertPlayAndInspectExampleActionNotExists;
		select: 'VarA' from: 8 to: 12;
		printIt;
		assertPrintItString: GtPharoDummyOneObject varA printString;
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithOneObjectMethodSumOneTwoOnSelfArgument [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ self methodCoderWithOneObjectMethodSumOneTwoOnSelfArgument asCoderViewModel ].

	aScripter methodCoder
		assertSelfObjectIs: nil;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyOneObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionNotExists;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :stepA | 
				stepA
					assertSelfObjectIs: nil;
					assertExplicitProviderClassIs: GtPharoDummyOneObject;
					assertHeaderProviderBehaviorIs: GtPharoDummyOneObject;
					assertHeaderMethodBehaviorIsNotVisible;
					assertMethodExpandersCountIs: 1;
					assertBindingIsNotDefined: #anObject;
					assertPlayAndInspectActionNotExists ];
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithOneObjectMethodSumOneTwoOnSelfArgumentWithExplicitProviderClass [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aCoder | 
				aCoder := self methodCoderWithOneObjectMethodSumOneTwoOnSelfArgument.
				aCoder explicitProviderClass: GtPharoDummyThreeObject.
				aCoder asCoderViewModel ].

	aScripter methodCoder
		assertSelfObjectIs: nil;
		assertExplicitProviderClassIs: GtPharoDummyThreeObject;
		assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
		assertHeaderMethodBehaviorIs: GtPharoDummyOneObject;
		assertPlayAndInspectActionNotExists;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :stepA | 
				stepA
					assertSelfObjectIs: nil;
					assertExplicitProviderClassIs: GtPharoDummyThreeObject;
					assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
					assertHeaderMethodBehaviorIs: GtPharoDummyOneObject;
					assertMethodExpandersCountIs: 1;
					assertBindingIsNotDefined: #anObject;
					assertPlayAndInspectActionNotExists ];
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithOneObjectMethodSumOneTwoOnSuperArgument [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ self methodCoderWithOneObjectMethodSumOneTwoOnSuperArgument asCoderViewModel ].

	aScripter methodCoder
		assertSelfObjectIs: nil;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyOneObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertPlayAndInspectActionNotExists;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :stepA | 
				stepA
					assertSelfObjectIs: nil;
					assertExplicitProviderClassIs: GtPharoDummyOneObject;
					assertHeaderProviderBehaviorIs: GtPharoDummyOneObject;
					assertHeaderMethodBehaviorIsNotVisible;
					assertMethodExpandersCountIs: 1;
					assertBindingIsNotDefined: #anObject;
					assertPlayAndInspectActionNotExists ];
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithTwoObjectAndMethodAnotherNumber [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ self methodCoderWithTwoObjectAndMethodAnotherNumber asCoderViewModel ].

	aScripter
		methodCoderStep: [ :s | 
			s
				assertMethodExpandersCountIs: 1;
				assertSelfObjectIs: nil;
				clickOnMethodCoderExpander: 1
					insideDo: [ :selfNumberStep | 
						selfNumberStep
							assertMethodExpandersCountIs: 7;
							assertSelfObjectIs: nil ] ].

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithTwoObjectAndMethodAnotherNumberAndSelfObject [
	<gtExample>
	| aScripter aSelfObject |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := self methodCoderWithTwoObjectAndMethodAnotherNumber.
				aCoder asCoderViewModel selfObject: (aSelfObject := aCoder behavior new) ].

	aScripter methodCoder
		assertMethodExpandersCountIs: 1;
		assertSelfObjectIs: aSelfObject;
		assertTargetBehaviorIs: aSelfObject class;
		assertExplicitProviderClassIs: nil;
		assertPlayAndInspectActionExists;
		clickOnPlayAndInspectButton;
		clickOnMethodCoderExpander: 1
			insideDo: [ :stepSelfNumber | 
				stepSelfNumber
					assertMethodExpandersCountIs: 7;
					assertSelfObjectIs: aSelfObject;
					assertTargetBehaviorIs: aSelfObject class;
					assertExplicitProviderClassIs: aSelfObject class;
					assertPlayAndInspectActionExists;
					clickOnPlayAndInspectButton;
					clickOnMethodCoderExpander: 1
						insideDo: [ :stepSuperNumber | 
							stepSuperNumber
								assertMethodExpandersCountIs: 1;
								assertSelfObjectIs: aSelfObject;
								assertTargetBehaviorIs: aSelfObject class superclass;
								assertExplicitProviderClassIs: aSelfObject class;
								assertPlayAndInspectActionExists;
								clickOnPlayAndInspectButton;
								clickOnMethodCoderExpander: 1
									insideDo: [ :stepSelfOne | 
										stepSelfOne
											assertMethodExpandersCountIs: 1;
											assertSelfObjectIs: aSelfObject;
											assertTargetBehaviorIs: aSelfObject class;
											assertExplicitProviderClassIs: aSelfObject class;
											assertPlayAndInspectActionExists;
											clickOnPlayAndInspectButton ] ];
					clickOnMethodCoderExpander: 2
						insideDo: [ :stepSelfOne | 
							stepSelfOne
								assertMethodExpandersCountIs: 1;
								assertSelfObjectIs: aSelfObject;
								assertTargetBehaviorIs: aSelfObject class;
								assertExplicitProviderClassIs: aSelfObject class;
								assertPlayAndInspectActionExists;
								clickOnPlayAndInspectButton ] ];
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithTwoObjectMethodOne [
	<gtExample>
	| aScripter aSelfObject |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := self methodCoderWithTwoObjectMethodOne ].
	aSelfObject := nil.

	aScripter methodCoder
		assertCompiledMethodIs: GtPharoDummyTwoObject >> #one;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertSelfObjectIs: aSelfObject;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :s | 
				s
					assertCompiledMethodIs: GtPharoDummyOneObject >> #one;
					assertSelfObjectIs: aSelfObject;
					assertExplicitProviderClassIs: GtPharoDummyTwoObject;
					assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
					assertHeaderMethodBehaviorIs: GtPharoDummyOneObject;
					assertMethodExpandersCountIs: 1;
					clickOnMethodCoderExpander: 1
						insideDo: [ :printStringStep | 
							printStringStep
								assertCompiledMethodIs: GtPharoDummyTwoObject >> #printString;
								assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
								assertHeaderMethodBehaviorIsNotVisible;
								assertSelfObjectIs: aSelfObject;
								assertMethodExpandersCountIs: 1;
								clickOnMethodCoderExpander: 1
									insideDo: [ :objectPrintStringStep | 
										objectPrintStringStep
											assertCompiledMethodIs: Object >> #printString;
											assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
											assertHeaderMethodBehaviorIs: Object;
											assertSelfObjectIs: aSelfObject;
											assertMethodExpandersCountIs: 1 ] ] ];
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithTwoObjectMethodOneAndExplicitProviderClass [
	<gtExample>
	| aScripter aSelfObject |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := self methodCoderWithTwoObjectMethodOne.
				aCoder explicitProviderClass: GtPharoDummyThreeObject ].
	aSelfObject := nil.

	aScripter methodCoder
		assertCompiledMethodIs: GtPharoDummyTwoObject >> #one;
		assertExplicitProviderClassIs: GtPharoDummyThreeObject;
		assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
		assertHeaderMethodBehaviorIs: GtPharoDummyTwoObject;
		assertSelfObjectIs: aSelfObject;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :s | 
				s
					assertCompiledMethodIs: GtPharoDummyOneObject >> #one;
					assertSelfObjectIs: aSelfObject;
					assertExplicitProviderClassIs: GtPharoDummyThreeObject;
					assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
					assertHeaderMethodBehaviorIs: GtPharoDummyOneObject;
					assertMethodExpandersCountIs: 1;
					clickOnMethodCoderExpander: 1
						insideDo: [ :printStringStep | 
							printStringStep
								assertCompiledMethodIs: GtPharoDummyTwoObject >> #printString;
								assertExplicitProviderClassIs: GtPharoDummyThreeObject;
								assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
								assertHeaderMethodBehaviorIs: GtPharoDummyTwoObject;
								assertSelfObjectIs: aSelfObject;
								assertMethodExpandersCountIs: 1;
								clickOnMethodCoderExpander: 1
									insideDo: [ :objectPrintStringStep | 
										objectPrintStringStep
											assertCompiledMethodIs: Object >> #printString;
											assertExplicitProviderClassIs: GtPharoDummyThreeObject;
											assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
											assertHeaderMethodBehaviorIs: Object;
											assertSelfObjectIs: aSelfObject;
											assertMethodExpandersCountIs: 1 ] ] ];
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithTwoObjectMethodOneAndSelfObject [
	<gtExample>
	| aScripter aSelfObject |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := self methodCoderWithTwoObjectMethodOne.
				aCoder asCoderViewModel selfObject: (aSelfObject := GtPharoDummyThreeObject new) ].

	aScripter methodCoder
		assertCompiledMethodIs: GtPharoDummyTwoObject >> #one;
		assertExplicitProviderClassIs: nil;
		assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
		assertHeaderMethodBehaviorIsNotVisible;
		assertSelfObjectIs: aSelfObject;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :s | 
				s
					assertCompiledMethodIs: GtPharoDummyOneObject >> #one;
					assertSelfObjectIs: aSelfObject;
					assertExplicitProviderClassIs: GtPharoDummyTwoObject;
					assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
					assertHeaderMethodBehaviorIs: GtPharoDummyOneObject;
					assertMethodExpandersCountIs: 1;
					clickOnMethodCoderExpander: 1
						insideDo: [ :printStringStep | 
							printStringStep
								assertCompiledMethodIs: GtPharoDummyTwoObject >> #printString;
								assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
								assertHeaderMethodBehaviorIsNotVisible;
								assertSelfObjectIs: aSelfObject;
								assertMethodExpandersCountIs: 1;
								clickOnMethodCoderExpander: 1
									insideDo: [ :objectPrintStringStep | 
										objectPrintStringStep
											assertCompiledMethodIs: Object >> #printString;
											assertHeaderProviderBehaviorIs: GtPharoDummyTwoObject;
											assertHeaderMethodBehaviorIs: Object;
											assertSelfObjectIs: aSelfObject;
											assertMethodExpandersCountIs: 1;
											assertPlayAndInspectActionExists ] ] ];
		play.

	^ aScripter
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderElementWithTwoObjectMethodOneAndSelfObjectAndExplicitProviderBehavior [
	<gtExample>
	| aScripter aSelfObject |
	aScripter := self
			scripterForBlock: [ | aCoder |
				aCoder := self methodCoderWithTwoObjectMethodOne.
				aCoder explicitProviderClass: GtPharoDummyThreeObject.
				aCoder asCoderViewModel selfObject: (aSelfObject := GtPharoDummyThreeObject new) ].

	aScripter methodCoder
		assertCompiledMethodIs: GtPharoDummyTwoObject >> #one;
		assertExplicitProviderClassIs: GtPharoDummyThreeObject;
		assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
		assertHeaderMethodBehaviorIs: GtPharoDummyTwoObject;
		assertSelfObjectIs: aSelfObject;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :s | 
				s
					assertCompiledMethodIs: GtPharoDummyOneObject >> #one;
					assertSelfObjectIs: aSelfObject;
					assertExplicitProviderClassIs: GtPharoDummyThreeObject;
					assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
					assertHeaderMethodBehaviorIs: GtPharoDummyOneObject;
					assertMethodExpandersCountIs: 1;
					clickOnMethodCoderExpander: 1
						insideDo: [ :printStringStep | 
							printStringStep
								assertCompiledMethodIs: GtPharoDummyTwoObject >> #printString;
								assertExplicitProviderClassIs: GtPharoDummyThreeObject;
								assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
								assertHeaderMethodBehaviorIs: GtPharoDummyTwoObject;
								assertSelfObjectIs: aSelfObject;
								assertMethodExpandersCountIs: 1;
								clickOnMethodCoderExpander: 1
									insideDo: [ :objectPrintStringStep | 
										objectPrintStringStep
											assertCompiledMethodIs: Object >> #printString;
											assertExplicitProviderClassIs: GtPharoDummyThreeObject;
											assertHeaderProviderBehaviorIs: GtPharoDummyThreeObject;
											assertHeaderMethodBehaviorIs: Object;
											assertSelfObjectIs: aSelfObject;
											assertMethodExpandersCountIs: 1 ] ] ];
		play.

	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithClassSideMethodInstA [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithClassSideMethodInstA.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithClassSideMethodVarA [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithClassSideMethodVarA.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithFailingExample [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithFailingExample.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithInstanceSideMethodInstA [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithInstanceSideMethodInstA.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithInstanceSideMethodVarA [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithInstanceSideMethodVarA.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithOneObjectMethodSumOneTwoOnSelfArgument [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithOneObjectMethodSumOneTwoOnSelfArgument.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithOneObjectMethodSumOneTwoOnSuperArgument [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithOneObjectMethodSumOneTwoOnSuperArgument.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithSelfCalls [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithOneObjectMethodThree.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithTwoObjectAndMethodAnotherNumber [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithTwoObjectMethodAnotherNumber.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodCoderWithTwoObjectMethodOne [
	<gtExample>
	| aMethod aCoder |
	aMethod := self methodWithTwoObjectMethodOne.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodWithClassSideMethodInstA [
	<gtExample>
	^ GtPharoDummyOneObject class >> #instA
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodWithClassSideMethodVarA [
	<gtExample>
	^ GtPharoDummyOneObject class >> #varA
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodWithFailingExample [
	<gtExample>
	^ GtPharoDummyTwoObject >> #failingExample
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodWithInstanceSideMethodInstA [
	<gtExample>
	^ GtPharoDummyOneObject >> #instA
]

{ #category : #'examples - evaluation context' }
GtPharoMethodCoderByScripterExamples >> methodWithInstanceSideMethodVarA [
	<gtExample>
	^ GtPharoDummyOneObject >> #varA
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodWithOneObjectMethodSumOneTwoOnSelfArgument [
	<gtExample>

	^ GtPharoDummyOneObject >> #sumOneTwoOnSelfArgument
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodWithOneObjectMethodSumOneTwoOnSuperArgument [
	<gtExample>

	^ GtPharoDummyOneObject >> #sumOneTwoOnSuperArgument
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodWithOneObjectMethodThree [
	<gtExample>

	^ GtPharoDummyOneObject >> #three
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodWithTwoObjectMethodAnotherNumber [
	<gtExample>

	^ GtPharoDummyTwoObject >> #anotherNumber
]

{ #category : #'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> methodWithTwoObjectMethodOne [
	<gtExample>

	^ GtPharoDummyTwoObject >> #one
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
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open context menu';
				id: GtSourceCoderEditorId ].

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
	| aScripter aNumberOfContextActionElements |
	aScripter := self referencedExampleMethodCoderUI.
	aScripter
		substeps: 'Remove Pragma'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Get number of context actions';
						block: [ :anElement | 
							aNumberOfContextActionElements := anElement childrenCount ];
						onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
						onChildAt: 3 ].
		
		
			aStep
				doStep: [ :s | 
					s
						label: 'Delete e character from <gtExample>';
						action: [ :anEditor | 
							anEditor deleter
								from: 12 to: 13;
								delete ];
						id: GtSourceCoderEditorId;
						onBrTextEditor ].

			self
				checkFor: aStep
				numberOfMainActions: 5
				contextAction: aNumberOfContextActionElements - 5.

			self checkFor: aStep absenceOfContextActionNamed: 'Play Example' ].
	aScripter
		checks: 'Assert Example Status Is Not Present'
		do: [ :aStep | 
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
	aScripter := self
			referencedExampleMethodCoderUI_NoExampleStatusAfterPragmaDeletion.

	aScripter
		substeps: 'Insert Pragma'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Insert e character in <gtExample>';
						action: [ :anEditor | 
							anEditor inserter
								at: 12;
								string: 'e';
								insert ];
						id: GtSourceCoderEditorId;
						onBrTextEditor ].

			self
				checkFor: aStep
				numberOfMainActions: 4
				contextActionAtLeast: 5.

			self checkFor: aStep existenceOfContextActionNamed: 'Evaluate example' ].

	aScripter
		checks: 'Check Example Status Is Present'
		do: [ :aStep | 
			self checkFor: aStep textExpandAttributeAt: 24.
			self checkFor: aStep textExampleStatusAttributeAt: 1 ].
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
	aScripter
		doStep: [ :s | 
			s
				label: 'Move cursor to middle of statement';
				action: [ :aSourceEditor | 
					| index |
					index := aSourceEditor text asString indexOf: $2.
					aSourceEditor textualCoderViewModel
						cursors: (BrTextEditorCursor at: index - 1) ];
				id: GtSourceCoderEditorId ].

	expecteds := #('b := 2' 'b := 2.
			c := 3' 'a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ]' 'a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ].
	d := 6' 'multipleStatementMethod
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
				combination: BlKeyCombination builder primary shift arrowDown build;
				id: GtSourceCoderEditorId;
				play.

			aScripter
				assertStep: [ :s | 
					s
						label: 'Assert selected text';
						value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
							equals: each;
						id: GtSourceCoderEditorId ] ].

	^ aScripter
]

{ #category : #'examples - statement selection/motion' }
GtPharoMethodCoderByScripterExamples >> selectStatementsUp [
	<gtExample>
	| aScripter expecteds |
	aScripter := self scripterForBlock: [ self statementMethodCoder ].
	aScripter
		doStep: [ :s | 
			s
				label: 'Move cursor to middle of statement';
				action: [ :aSourceEditor | 
					| index |
					index := aSourceEditor text asString indexOf: $2.
					aSourceEditor textualCoderViewModel
						cursors: (BrTextEditorCursor at: index - 1) ];
				id: GtSourceCoderEditorId ].

	expecteds := #('b := 2' 'a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ]' 'a := 1.
	a = 1
		ifTrue: [ b := 2.
			c := 3 ]
		ifFalse: [ c := 4.
			d := 5 ]' 'multipleStatementMethod
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

			aScripter
				assertStep: [ :s | 
					s
						label: 'Assert selected text';
						value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
							equals: each;
						id: GtSourceCoderEditorId ] ].

	^ aScripter
]

{ #category : #'examples - statement selection/motion' }
GtPharoMethodCoderByScripterExamples >> selectStatementsWithError [
	<gtExample>
	| aScripter coder |
	aScripter := self scripterForBlock: [ coder := self statementMethodCoder ].	"Create a syntax error"
	coder appendString: ';'.

	aScripter
		doStep: [ :s | 
			s
				label: 'Move cursor to last statement';
				action: [ :aSourceEditor | 
					| index |
					index := aSourceEditor text asString indexOf: $6.
					aSourceEditor textualCoderViewModel
						cursors: (BrTextEditorCursor at: index - 1) ];
				id: GtSourceCoderEditorId ].

	aScripter shortcut
		combination: BlKeyCombination builder primary shift arrowUp build;
		id: GtSourceCoderEditorId;
		play.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert selected text';
				value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
					equals: '';
				id: GtSourceCoderEditorId ].

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

{ #category : #'examples - undo/redo' }
GtPharoMethodCoderByScripterExamples >> undoRedoRecompileMethod [
	<gtExample>
	<after: #cleanUp>
	| scripter rootClass originalSource |
	scripter := self
			scripterForBlock: [ | method coder |
				environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
				rootClass := environment anyDummyLeafClass.
				method := rootClass anyDummyUnaryMethod realMethod.
				coder := GtPharoMethodCoder forMethod: method.
				coder attributeNamed: #dummyEnvironment put: environment.
				coder attributeNamed: #dummyMethod put: rootClass anyDummyUnaryMethod.
				coder ].
	scripter
		doStep: [ :s | 
			s
				label: 'Type in a method';
				action: [ :coder | 
					originalSource := coder currentSourceText asString.
					coder
						appendString: '
	"This is a comment"' ];
				onModel ].
	scripter
		doStep: [ :s | 
			s
				label: 'Save a method';
				action: [ :coder | coder save ];
				onModel ].
	scripter
		doStep: [ :s | 
			s
				label: 'Check source is different';
				action: [ :coder | self assert: originalSource ~= coder currentSourceText asString ];
				onModel ].
	scripter
		doStep: [ :s | 
			s
				label: 'Undo change';
				action: [ :coder | 
					self assert: GtRefactoryChangeManager instance hasUndoableOperations.
					GtRefactoryChangeManager instance undoChange ];
				onModel ].
	scripter
		doStep: [ :s | 
			s
				label: 'Check source is equal to original';
				action: [ :coder | self assert: originalSource = coder currentSourceText asString ];
				onModel ].
	scripter
		doStep: [ :s | 
			s
				label: 'Redo change';
				action: [ :coder | 
					self assert: GtRefactoryChangeManager instance hasRedoableOperations.
					GtRefactoryChangeManager instance redoChange ];
				onModel ].
	scripter
		doStep: [ :s | 
			s
				label: 'Check source is different after redo';
				action: [ :coder | self assert: originalSource ~= coder currentSourceText asString ];
				onModel ].
	^ scripter
]

{ #category : #'examples - undo/redo' }
GtPharoMethodCoderByScripterExamples >> undoRedoRemoveMethod [
	<gtExample>
	<after: #cleanUp>
	| scripter rootClass selector originalSource |
	scripter := self
			scripterForBlock: [ | method coder |
				environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
				rootClass := environment anyDummyLeafClass.
				method := rootClass anyDummyUnaryMethod realMethod.
				selector := method selector.
				originalSource := method sourceCode.
				coder := GtPharoMethodCoder forMethod: method.
				coder attributeNamed: #dummyEnvironment put: environment.
				coder attributeNamed: #dummyMethod put: rootClass anyDummyUnaryMethod.
				coder ].
	scripter
		doStep: [ :s | 
			s
				label: 'Remove method';
				action: [ :coder | coder remove ];
				onModel ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check method no longer exists';
				do: [ :coder | self assert: (rootClass realClass includesSelector: selector) not ] ].
	scripter
		doStep: [ :s | 
			s
				label: 'Undo change';
				action: [ :coder | 
					self assert: GtRefactoryChangeManager instance hasUndoableOperations.
					GtRefactoryChangeManager instance undoChange ];
				onModel ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check method exists';
				do: [ :coder | 
					self assert: (rootClass realClass includesSelector: selector).
					self assert: (rootClass realClass sourceCodeAt: selector) = originalSource ] ].
	scripter
		doStep: [ :s | 
			s
				label: 'Redo change';
				action: [ :coder | 
					self assert: GtRefactoryChangeManager instance hasRedoableOperations.
					GtRefactoryChangeManager instance redoChange ];
				onModel ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check method no longer exists after redo';
				do: [ :coder | self assert: (rootClass realClass includesSelector: selector) not ] ].
	^ scripter
]
