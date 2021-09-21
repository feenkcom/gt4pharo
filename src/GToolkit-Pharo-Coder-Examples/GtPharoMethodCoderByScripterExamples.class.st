Class {
	#name : 'GtPharoMethodCoderByScripterExamples',
	#superclass : 'Object',
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#instVars : [
		'environment'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : 'examples - basic' }
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

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethod [
	<gtExample>

	^ GtPharoMethodCoderExamples >> #?
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self binaryMethod.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ self binaryMethodCoder ].
	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_CollapsedFromUI [
	<gtExample>
	| aScripter |

	aScripter := self binaryMethodCoderUI.
	aScripter substep: 'Collapse and Check Coder' do: [ :aStep |
		aStep click
			label: 'Click on Expander';
			onChildAt: 1.
		
		aStep wait forEmptySpaceTaskQueue.
		
		aStep check
			label: 'Check Coder Editor Text';
			value: [ :label | label text asString ] equals: '?';
			id: GtSourceCoderCollapsedTextId.
		aStep check 
			label: 'Check Coder UI Is Collapsed';
			satisfies: [ :aCoderElement | aCoderElement isExpanded not ] ].

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Collapsed_BreadcrumbContent [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.
	aScripter checks: 'Check Breadcrumb' do: [ :aStep | 
		aStep  check 
			label: 'Check Breadcrumb Package Name';
			value: [ :aButton | aButton label asString ] equals: [ GtPharoMethodCoderExamples package name ];
			onBreadthFirstChildOfClass: GtMethodCoderBreadcrumbElement;
			onChildAt: 1.
		aStep  check 
			label: 'Check Breadcrumb Class Name';
			value: [ :aButton | aButton label asString ] equals: [ GtPharoMethodCoderExamples name ];
			onBreadthFirstChildOfClass: GtMethodCoderBreadcrumbElement;
			onChildAt: 3 ].

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Collapsed_BreadcrumbOnClassNameClick [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.
	aScripter substeps: 'Click On Breadcrumb' do: [ :aStep |
		aStep click
			label: 'Click On Class Name';
			onChildAt: 2;
			onChildOfClass: GtSourceCoderCollapsedContentElement;
			onChildAt: 1;
			onChildOfClass: GtMethodCoderBreadcrumbElement;
			onChildAt: 3.
		
		aStep wait forEmptySpaceTaskQueue.	
		
		aStep  check 
			label: 'Check Triggered Spawn Object Event';
			satisfies: [ :theScripter | theScripter events reversed 
				detectEventOfClass: GtPhlowObjectToSpawn
				ifFound: [ :theEvent |
					theEvent object = self binaryMethod methodClass and: [ theEvent tool isKindOf: GtClassCoderTool ] ]
				ifNone: [ AssertionFailure signal: GtPhlowObjectToSpawn name, ' event was not found' ]  ];
			onScripter.
		].

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Collapsed_BreadcrumbOnPackageClick [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.
	aScripter substeps: 'Click On Breadcrumb' do: [ :aStep |
		aStep click
			label: 'Click On Package Name';
			onChildAt: 2;
			onChildOfClass: GtSourceCoderCollapsedContentElement;
			onChildAt: 1;
			onChildOfClass: GtMethodCoderBreadcrumbElement;
			onChildAt: 1.
		
		aStep wait forEmptySpaceTaskQueue.
		
		aStep  check 
			label: 'Check Triggered Spawn Object Event';
			satisfies: [ :theScripter | theScripter events reversed 
				detectEventOfClass: GtPhlowObjectToSpawn
				ifFound: [ :theEvent | theEvent object class = RPackage and: [ theEvent object name = self class package name ] ]
				ifNone: [ AssertionFailure signal: GtPhlowObjectToSpawn name, ' event was not found' ]  ];
			onScripter.
		].

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_ExpandedFromUI [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_CollapsedFromUI.
	self expandFromUI: aScripter method: self binaryMethod.

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_ExpandedFromUI_CheckActionButtons [
	<gtExample>
	| aScripter |

	aScripter := self binaryMethodCoderUI_ExpandedFromUI.
	self 
		checkFor: aScripter 
		numberOfMainActions: 5
		contextAction: 0.

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_ExpandedFromUI_CodeStyle [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_ExpandedFromUI.
	aScripter checks: 'Check Expanded Source Code Style' do: [ :aStep |
		aStep check
			label: 'Check Method Name Attributes';
			anySatisfy: [ :aTextAttribute | aTextAttribute = BlFontWeightAttribute bold ];
			onChildNamed: #editor;
			onBrTextEditor;
			onBrTextEditorText;
			onTextAttributesAt: 1.
		aStep check
			label: 'Check Comment Attributes';
			anySatisfy: [ :aTextAttribute | aTextAttribute = (BlTextForegroundAttribute new paint: Color gray darker) ];
			onChildNamed: #editor;
			onBrTextEditor;
			onBrTextEditorText;
			onTextAttributesAt: 13.
	].

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Expanded_BreadcrumbContent [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI.
	aScripter checks: 'Check Breadcrumb' do: [ :aStep | 
		aStep  check 
			label: 'Check Breadcrumb Package Name';
			value: [ :aButton | aButton label asString ] equals: [ GtPharoMethodCoderExamples package name ];
			onBreadthFirstChildOfClass: GtMethodCoderBreadcrumbElement;
			onChildAt: 1.
		aStep  check 
			label: 'Check Breadcrumb Class Name';
			value: [ :aButton | aButton label asString ] equals: [ GtPharoMethodCoderExamples name ];
			onBreadthFirstChildOfClass: GtMethodCoderBreadcrumbElement;
			onChildAt: 3 ].

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Expanded_BreadcrumbOnClassNameClick [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI.
	aScripter substeps: 'Click On Breadcrumb' do: [ :aStep |
		aStep click
			label: 'Click On Class Name';
			onChildAt: 2;
			onChildOfClass: GtSourceCoderExpandedContentElement;
			onChildAt: 1;
			onChildOfClass: GtMethodCoderBreadcrumbElement;
			onChildAt: 3.
			
		aStep wait forEmptySpaceTaskQueue.
		
		aStep  check 
			label: 'Check Triggered Spawn Object Event';
			satisfies: [ :theScripter | theScripter events reversed 
				detectEventOfClass: GtPhlowObjectToSpawn
				ifFound: [ :theEvent |
					theEvent object = self binaryMethod methodClass and: [ theEvent tool isKindOf: GtClassCoderTool ] ]
				ifNone: [ AssertionFailure signal: GtPhlowObjectToSpawn name, ' event was not found' ]  ];
			onScripter.
		].
	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_Expanded_BreadcrumbOnPackageClick [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI.
	aScripter substeps: 'Click On Breadcrumb' do: [ :aStep |
		aStep click
			label: 'Click On Package Name';
			onChildAt: 2;
			onChildOfClass: GtSourceCoderExpandedContentElement;
			onChildAt: 1;
			onChildOfClass: GtMethodCoderBreadcrumbElement;
			onChildAt: 1.
			
		aStep wait forEmptySpaceTaskQueue.
		
		aStep  check 
			label: 'Check Triggered Spawn Object Event';
			satisfies: [ :theScripter | theScripter events reversed 
				detectEventOfClass: GtPhlowObjectToSpawn
				ifFound: [ :theEvent | theEvent object class = RPackage and: [ theEvent object name = self class package name ] ]
				ifNone: [ AssertionFailure signal: GtPhlowObjectToSpawn name, ' event was not found' ]  ];
			onScripter.
		].

	^ aScripter syncContinue
]

{ #category : 'examples - binary method' }
GtPharoMethodCoderByScripterExamples >> binaryMethodCoderUI_WithoutExampleActions [
	<gtExample>
	| aScripter |
	aScripter := self binaryMethodCoderUI_ExpandedFromUI.
	self 
		checkFor: aScripter 
		numberOfMainActions: 5
		contextAction: 0.
	self checkFor: aScripter absenceOfContextActionNamed: 'Play'.

	^ aScripter syncContinue
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter absenceOfContextActionNamed: anActionName [
	<gtExample>
	
	aScripter check 
		label: 'Check Context Action Existence Named ', anActionName asString;
		nonSatisfies: [ :aContextActions | aContextActions title = anActionName translated
			and: [ aContextActions action method = (GtPharoMethodCoder>>#exampleAstFor:into:) ] ];
		onModel;
		onChildFromMessage: #contextActions.
	
	^ aScripter
]

{ #category : 'utilities' }
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

	^ aScripterOrStep
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter existenceOfContextActionNamed: anActionName [

	<gtExample>
	aScripter check
		label:
			'Check Context Action Existence Named ' , anActionName asString;
		anySatisfy: [ :aContextActions | 
			aContextActions title = anActionName translated and: [ 
					aContextActions action blocDefiningMethod
					= (GtPharoMethodCoder >> #exampleAstFor:into:) ] ];
		onModel;
		onChildFromMessage: #contextActions.

	^ aScripter
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripter numberOfMainActions: aMainActionsCount contextAction: anAddonsActionsCount [
	<gtExample>
	aScripter substeps: 'Check Available Action Buttons' do: [ :aStep |
		aStep wait forEmptySpaceTaskQueue.

		aStep check 
			label: 'Number of main actions';
			childrenCount: aMainActionsCount;
			onBreadthFirstChildOfClass: GtCoderActionsElement;
			onChildAt: 1.

		aStep check 
			label: 'Number of addons actions';
			childrenCount: anAddonsActionsCount;
			onBreadthFirstChildOfClass: GtCoderActionsElement;
			onChildAt: 3 ].

	^ aScripter
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep numberfOfTextAttributes: aNumber OfType: aClass [
	<gtExample>
	aScripterOrStep check
		label: 'Check Editor Text Attributes';
		value: [ :aText | 
			| anIterator aCounter |
			aCounter := 0.
			anIterator := aText iterator.
			[ anIterator hasNext ] whileTrue: [ (anIterator attributes 
				anySatisfy: [ :eachAttribute | eachAttribute class = aClass ]) ifTrue: [ aCounter := aCounter + 1 ].
				anIterator next ].
			aCounter ] equals: aNumber;
		onChildNamed: #editor;
		onBrTextEditor;
		onBrTextEditorText.
	^ aScripterOrStep
]

{ #category : 'utilities' }
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

	^ aScripterOrStep
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep renameEditorExists: doesExist [
	<gtExample>
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

	^ aScripterOrStep
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep saveButtonEnabled: isEnabled [
	<gtExample>
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

	^ aScripterOrStep
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textAttributesAt: anIndex anySatisfies: aBlock [
	<gtExample>
	aScripterOrStep check
		label: 'Check Editor Text Attributes';
		anySatisfy: aBlock;
		onChildNamed: #editor;
		onBrTextEditor;
		onBrTextEditorText;
		onTextAttributesAt: anIndex.
	^ aScripterOrStep
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textAttributesAt: anIndex nonSatisfies: aBlock [
	<gtExample>
	aScripterOrStep check
		label: 'Check Editor Text Attributes';
		nonSatisfies: aBlock;
		onChildNamed: #editor;
		onBrTextEditor;
		onBrTextEditorText;
		onTextAttributesAt: anIndex.
	^ aScripterOrStep
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textExampleStatusAttributeAt: anIndex [
	<gtExample>
	self 
		checkFor: aScripterOrStep 
		textAttributesAt: anIndex 
		anySatisfies: [ :aTextAttribute | aTextAttribute class = GtCoderExampleStatusAttribute ].
	^ aScripterOrStep
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> checkFor: aScripterOrStep textExpandAttributeAt: anIndex [
	<gtExample>
	self 
		checkFor: aScripterOrStep 
		textAttributesAt: anIndex 
		anySatisfies: [ :aTextAttribute | aTextAttribute isKindOf: BrGlamorousTrangleExpanderTextAttribute ].
	^ aScripterOrStep
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> clickFixItActionFor: aScripter id: aBlElementId [
	"An utility method to open and click on the fixIt action with id.
	I assume that the fixit menu already exists"
	
	aScripter click
		onSpaceRoot;
		id: aBlElementId.

	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> clickFixItFor: aScripter [
	"An utility method to click on the fixIt button to open a context menu"

	"there is no context menu before clicking on the fixit button"
	aScripter check
		onSpaceRoot;
		onBreadthFirstChildOfClass: GtCoderContextMenuContent;
		notExists.
	
	aScripter click
		onBreadthFirstChildOfClass: GtFixItButton.

	aScripter wait forEmptySpaceTaskQueue.
	
	"now it appeared"
	aScripter check
		onSpaceRoot;
		onBreadthFirstChildOfClass: GtCoderContextMenuContent;
		exists.

	^ aScripter syncContinue
]

{ #category : 'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderCollapseProgrammatically [
	<gtExample>
	| aScripter |

	aScripter := self coderExpandedByDefault.
	
	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel collapse ];
		onModel.
	
	aScripter wait forEmptySpaceTaskQueue.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded not ];
		onModel.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
		onModel.
		
	aScripter check
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isCollapsed ];
		onSelf.

	^ aScripter syncContinue
]

{ #category : 'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandClickingOnExpander [
	<gtExample>
	| aScripter |

	aScripter := self coderCollapseProgrammatically.
	
	aScripter click
		id: GtSourceCoderExpanderToggleId.
	
	aScripter wait forEmptySpaceTaskQueue.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
		onModel.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
		onModel.

	aScripter check
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
		onSelf.

	^ aScripter syncContinue
]

{ #category : 'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandClickingOnHeader [
	<gtExample>
	| aScripter |

	aScripter := self coderCollapseProgrammatically.
	
	aScripter click
		onBreadthFirstChildOfClass: GtSourceCoderCollapsedContentElement.
	
	aScripter wait forEmptySpaceTaskQueue.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
		onModel.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel focused ];
		onModel.
		
	aScripter check
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
		onSelf.

	^ aScripter syncContinue
]

{ #category : 'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandProgrammatically [
	<gtExample>
	| aScripter |

	aScripter := self coderCollapseProgrammatically.
	
	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel expand ];
		onModel.
	
	aScripter wait forEmptySpaceTaskQueue.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
		onModel.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
		onModel.
		
	aScripter check
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
		onSelf.

	^ aScripter syncContinue
]

{ #category : 'examples - expansion' }
GtPharoMethodCoderByScripterExamples >> coderExpandedByDefault [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ self binaryMethodCoder asCoderViewModel ].
	aScripter wait forEmptySpaceTaskQueue.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel expanded ];
		onModel.
		
	aScripter check
		satisfies: [ :aCoderViewModel | aCoderViewModel focused not ];
		onModel.

	aScripter check
		satisfies: [ :anExpandableCoderElement | anExpandableCoderElement isExpanded ];
		onSelf.

	^ aScripter syncContinue
]

{ #category : 'utilities' }
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

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> collapseFromUI: aScripter method: aMethod [
	<gtExample>
	aScripter substep: 'Collapse and Check Coder' do: [ :aStep |
		aStep click
			label: 'Click on Expander';
			onChildAt: 1.
		aStep wait forEmptySpaceTaskQueue.

		aStep check 
			label: 'Check Coder UI is Expanded';
			satisfies: [ :aCoderElement | aCoderElement isExpanded not ].

		aStep check
			label: 'Check Coder Collapsed Label Text';
			value: [ :aLabelElement | aLabelElement text asString ] equals: [ aMethod selector ];
			id: GtSourceCoderCollapsedTextId ].

	^ aScripter
]

{ #category : 'examples - context menu' }
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

{ #category : 'examples - context menu' }
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
	aScripter check
		satisfies: [ :aCoder | (aCoder currentSourceString includesSubstring: '196@400') not ];
		onModel.
	
	^ aScripter
]

{ #category : 'examples - context menu' }
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
	aScripter check
		satisfies: [ :aCoder | (aCoder currentSourceString includesSubstring: '196@400') not ];
		onModel.
	aScripter check
		satisfies: [ :aCoder | (aCoder currentSourceString includesSubstring: '400@196') ];
		onModel.
	
	^ aScripter
]

{ #category : 'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethod [
	<gtExample>

	^ GtPharoMethodCoderExamples >> #sumMethod
]

{ #category : 'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self exampleMethod.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : 'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI [
	<gtExample>
	| aScripter |
	
	aScripter := self scripterForBlock: [ self exampleMethodCoder asCoderViewModel ].
	
	^ aScripter syncContinue
]

{ #category : 'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_CollapsedFromUI [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI.
	self collapseFromUI: aScripter method: self exampleMethod.

	^ aScripter syncContinue
]

{ #category : 'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI_CollapsedFromUI.
	self expandFromUI: aScripter method: self exampleMethod.

	^ aScripter syncContinue
]

{ #category : 'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI_CheckActionButtons [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI_ExpandedFromUI.
	self 
		checkFor: aScripter 
		numberOfMainActions: 5
		contextAction: 4.

	self checkFor: aScripter existenceOfContextActionNamed: 'Play Example'.
	self checkFor: aScripter existenceOfContextActionNamed: 'Play and Inspect Example Result'.

	^ aScripter syncContinue
]

{ #category : 'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI_PlayAndInspect [
	<gtExample>
	| aScripter |

	aScripter := self exampleMethodCoderUI_ExpandedFromUI_CheckActionButtons.
	
	aScripter click
		label: 'Click play and inspect';
		id: GtMethodCoderPlayAndInspectExampleActionId.

	^ aScripter syncContinue
]

{ #category : 'examples - example method' }
GtPharoMethodCoderByScripterExamples >> exampleMethodCoderUI_ExpandedFromUI_RemovePragma [
	<gtExample>
	| aScripter |
	aScripter := self exampleMethodCoderUI_ExpandedFromUI.

	aScripter substeps: 'Remove Pragma' do: [ :aStep |
		aStep do
			label: 'Delete e character from <gtExample>';
			action: [ :anEditor | anEditor deleter from: 20 to: 21; delete ];
			onChildNamed: #editor;
			onBrTextEditor.
		self 
			checkFor: aStep
			numberOfMainActions: 6
			contextAction: 0.

		self checkFor: aStep absenceOfContextActionNamed: 'Play Example' ].

	^ aScripter syncContinue
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> expandFromUI: aScripter method: aMethod [
	<gtExample>
	aScripter substep: 'Expand and Check Coder' do: [ :aStep |
		aStep click
			label: 'Click on Expander';
			onChildAt: 1.

		aStep wait forEmptySpaceTaskQueue.

		aStep check 
			label: 'Check Coder UI is Expanded';
			satisfies: [ :aCoderElement | aCoderElement isExpanded ].

		aStep check
			label: 'Check Coder Editor Text';
			value: [ :anEditorElement | anEditorElement editor text asString ] equals: [ aMethod sourceCode ];
			onChildNamed: #editor ].

	^ aScripter
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> extractedUnaryMethodNameFor: aMethodCoder [
	^ 'sub', (aMethodCoder attributeNamed: #dummyMethod) selector capitalized
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClass_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
	aScripter do
		label: 'type in a class that does not exist';
		action: [ :aCoder | aCoder appendString: (String cr, String tab, '{1}New' format: { (aCoder attributeNamed: #dummyMethod) className }) ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClass_02_click_fixit [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateClass_01_setup.
	self clickFixItFor: aScripter.
	^ aScripter syncContinue
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateClass_03_click_define_class [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateClass_02_click_fixit.
	
	"there is no create behavior element before clicking on the menu"
	aScripter check
		onBreadthFirstChildOfClass: GtPharoCreateBehaviorElement;
		notExists.
	
	aScripter click
		onSpaceRoot;
		id: (GtDefineClassFixItActionElementId indexed: 1).

	aScripter wait forEmptySpaceTaskQueue.
	
	"now it appeared"
	aScripter check
		onBreadthFirstChildOfClass: GtPharoCreateBehaviorElement;
		exists.
	
	"context menu should disappear"
	aScripter check
		onSpaceRoot;
		onBreadthFirstChildOfClass: GtCoderContextMenuContent;
		notExists.

	^ aScripter syncContinue
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateInstVar_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod .
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder asCoderViewModel ].
	aScripter do
		label: 'type in a variable that does not exist';
		action: [ :aCoderViewModel | aCoderViewModel coderModel appendString: (String cr, String tab, 'instance') ];
		onModel.
	aScripter wait forEmptySpaceTaskQueue.
	
	self selectTextFor: aScripter from: 9 to: 17 andCheck: 'instance'.	
	self clickFixItFor: aScripter.
	
	^ aScripter syncContinue
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateInstVar_02_add [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateInstVar_01_setup.
	
	self clickFixItActionFor: aScripter id: (GtDefineInstanceVariableFixItActionElementId indexed: 1).

	aScripter check
		value: [ :aCoderViewModel | aCoderViewModel coderModel currentSourceString ]
		equals: [ :aCoderViewModel |
			String streamContents: [ :aStream |
				aStream
					nextPutAll: (aCoderViewModel coderModel attributeNamed: #dummyMethod) selector; cr;
					tab; nextPutAll: 'instance' ] ];
		onModel.

	aScripter check
		label: 'Make sure the instance variable was created';
		satisfies: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) realClass hasSlotNamed: #instance ];
		onModel.

	aScripter check
		label: 'Make sure the method still mofied';
		satisfies: [ :aCoderViewModel | aCoderViewModel coderModel isModified ];
		onModel.

	aScripter check
		label: 'Make sure the method is not saved/recompiled after adding a temporary variable';
		value: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) systemMethod sourceCode ]
		equals: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) realMethod sourceCode ];
		onModel.
		
	aScripter check
		label: 'Make sure the text was deselected';
		satisfies: [ :aCoderViewModel | aCoderViewModel hasSelection not ];
		onModel.

	^ aScripter syncContinue
]

{ #category : 'examples - fixit class' }
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
		onModel.
	aScripter wait forEmptySpaceTaskQueue.

	self selectTextFor: aScripter from: 9 to: 18 andCheck: 'temporary'.	
	self clickFixItFor: aScripter.
	
	^ aScripter syncContinue
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> fixitCreateTempVar_02_add [
	<gtExample>
	| aScripter |

	aScripter := self fixitCreateTempVar_01_setup.
	
	self clickFixItActionFor: aScripter id: (GtDefineTemporaryVariableFixItActionElementId indexed: 1).
	
	aScripter check
		value: [ :aCoderViewModel | aCoderViewModel coderModel currentSourceString ]
		equals: [ :aCoderViewModel |
			String streamContents: [ :aStream |
				aStream
					nextPutAll: (aCoderViewModel coderModel attributeNamed: #dummyMethod) selector; cr;
					tab; nextPutAll: '| temporary |'; cr;
					tab; nextPutAll: 'temporary' ] ];
		onModel.
		
	aScripter check
		label: 'Make sure the method still mofied';
		satisfies: [ :aCoderViewModel | aCoderViewModel coderModel isModified ];
		onModel.
		
	aScripter check
		label: 'Make sure the method is not saved/recompiled after adding a temporary variable';
		value: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) systemMethod sourceCode ]
		equals: [ :aCoderViewModel | (aCoderViewModel coderModel attributeNamed: #dummyMethod) realMethod sourceCode ];
		onModel.
		
	aScripter check
		label: 'Make sure the text was deselected';
		satisfies: [ :aCoderViewModel | aCoderViewModel hasSelection not ];
		onModel.

	^ aScripter syncContinue
]

{ #category : 'examples - abstract inst var' }
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
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
('
	^ {1} isNil' format: { (aCoder attributeNamed: #dummyMethod) anyInstVarName })
		];
		onModel.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forAbstactInstVar_01_setup.
	aScripter do
		label: 'Select part of the assignment node';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 13 to: 14;
				select ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_03_hover_abstract_variable [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forAbstractInstVar_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover abstract';
		onSpaceRoot;
		id: #'context-menu--abstract-variable'.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - abstract inst var' }
GtPharoMethodCoderByScripterExamples >> forAbstractInstVar_04_click_abstract_variable [
	<gtExample>
	| aScripter |

	aScripter := self forAbstractInstVar_03_hover_abstract_variable.

	aScripter click
		label: 'Click abstract variable';
		onSpaceRoot;
		onChildNamed: #'context-menu--abstract-variable'.

	aScripter wait forEmptySpaceTaskQueue.

	aScripter check
		label: 'Check refactoring changes attribute';
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	^ aScripter syncContinue
]

{ #category : 'examples - convert temporary to instance variable' }
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
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
'
	| cache |
	cache := IdentityDictionary new.
	^ cache' ];
		onModel.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - convert temporary to instance variable' }
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_03_hover_convert_temporary_to_instance_variable [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forConvertTempToInst_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover convert';
		onSpaceRoot;
		id: #'context-menu--convert-temp-to-inst-var'.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - convert temporary to instance variable' }
GtPharoMethodCoderByScripterExamples >> forConvertTempToInst_04_click_convert [
	<gtExample>
	| aScripter |

	aScripter := self forConvertTempToInst_03_hover_convert_temporary_to_instance_variable.

	aScripter click
		label: 'Click convert';
		onSpaceRoot;
		onChildNamed: #'context-menu--convert-temp-to-inst-var'.

	aScripter wait forEmptySpaceTaskQueue.

	aScripter check
		label: 'Check refactoring changes attribute';
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	^ aScripter syncContinue
]

{ #category : 'examples - create accessors' }
GtPharoMethodCoderByScripterExamples >> forCreateAccessors_03_hover_create_accessors [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forAbstractInstVar_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover abstract';
		onSpaceRoot;
		id: #'context-menu--create-accessors'.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - create accessors' }
GtPharoMethodCoderByScripterExamples >> forCreateAccessors_04_click_create_accessors [
	<gtExample>
	| aScripter |

	aScripter := self forCreateAccessors_03_hover_create_accessors.

	aScripter click
		label: 'Click create accessors';
		onSpaceRoot;
		onChildNamed: #'context-menu--create-accessors'.

	aScripter wait forEmptySpaceTaskQueue.

	aScripter check
		label: 'Check refactoring changes attribute';
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	^ aScripter syncContinue
]

{ #category : 'examples - extract temp' }
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
		onModel.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - extract temp' }
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: [ 'self printString' ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	^ aScripter syncContinue
]

{ #category : 'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_03_context_menu [
	<gtExample>
	
	^ self openContextMenu: self forExtractTemp_02_select
]

{ #category : 'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_04_hover_extract_temp [
	<gtExample>
	| aScripter |

	aScripter := self forExtractTemp_03_context_menu.

	aScripter mouseMoveOver
		label: 'Hover extract temp';
		onSpaceRoot;
		id: GtSourceCoderExtractTempVarContextMenuItemId.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_05_click_extract_temp [
	<gtExample>
	| aScripter |

	aScripter := self forExtractTemp_04_hover_extract_temp.

	aScripter click
		label: 'Click extract temp';
		onSpaceRoot;
		id: GtSourceCoderExtractTempVarContextMenuItemId.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
'method1
	| _ |
	_ := self printString.
	^ _ size' ];
		onModel.
		
	aScripter check
		label: 'Check there is no selected text';
		value: [ :aSourceEditor | aSourceEditor editor hasSelection ] equals: [ false ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
		
	aScripter check
		label: 'Check source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel.
	
	aScripter check
		label: 'Check rename editor attribute';
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.
		
	aScripter check
		label: 'Check source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
		
	aScripter check
		label: 'Check source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	
	aScripter check
		label: 'Check variable name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
		onChildNamed: GtPharoSourceCoder sourceEditorName;
		onBreadthFirstChildOfClass: GtRenameEditor.

	aScripter check
		label: 'Check variable name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		onChildNamed: GtPharoSourceCoder sourceEditorName;
		onBreadthFirstChildOfClass: GtRenameEditor.

	^ aScripter syncContinue
]

{ #category : 'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_06_type_variable_name [
	<gtExample>
	| aScripter |

	aScripter := self forExtractTemp_05_click_extract_temp.

	aScripter keyClick: BlKeyboardKey delete.
	aScripter keyClick: BlKeyboardKey backspace.
	aScripter type: 'a'.
	aScripter keyClick: BlKeyboardKey return.
	
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - extract temp' }
GtPharoMethodCoderByScripterExamples >> forExtractTemp_07_verify_source [
	<gtExample>
	| aScripter |

	aScripter := self forExtractTemp_06_type_variable_name.

	aScripter check
		label: 'Check current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
'method1
	| a |
	a := self printString.
	^ a size' ];
		onModel.
		
	aScripter check
		label: 'Check source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel.
	
	aScripter check
		label: 'Check rename editor attribute';
		value: [ :aCoderEditor |
			aCoderEditor text
				hasAttributeSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ] ]
			equals: false;
		onChildNamed: GtPharoSourceCoder sourceEditorName.
		
	aScripter check
		label: 'Check source editor is focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	
	^ aScripter syncContinue
]

{ #category : 'examples - inline message send' }
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
		onModel.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - inline message send' }
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_03_hover_inline_message_send [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forInlineMessageSend_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover inline message send';
		onSpaceRoot;
		id: #'context-menu--inline-message'.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - inline message send' }
GtPharoMethodCoderByScripterExamples >> forInlineMessageSend_04_click_inline_message_send [
	<gtExample>
	| aScripter |

	aScripter := self forInlineMessageSend_03_hover_inline_message_send.

	aScripter click
		label: 'Click inline temp';
		onSpaceRoot;
		onChildNamed: #'context-menu--inline-message'.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
'method1
	^ false' ];
		onModel.
		
	aScripter check
		label: 'Check source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel.

	^ aScripter syncContinue
]

{ #category : 'examples - inline temp' }
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
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString: '
	| str |
	str := self printString.
	^ str size' ];
		onModel.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - inline temp' }
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_03_hover_inline_temp [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forInlineTemp_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover inline temp';
		onSpaceRoot;
		id: #'context-menu--inline-temp'.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check assignment node highlighted';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute = GtPharoMethodCoder nodeHighlight ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | (aCoderEditor text asString indexOfSubCollection: 'str :=') to: (aCoderEditor text asString indexOf: $.) - 1 ];
		onChildNamed: GtSourceCoderEditorId.

	^ aScripter syncContinue
]

{ #category : 'examples - inline temp' }
GtPharoMethodCoderByScripterExamples >> forInlineTemp_04_click_inline_temp [
	<gtExample>
	| aScripter |

	aScripter := self forInlineTemp_03_hover_inline_temp.

	aScripter click
		label: 'Click inline temp';
		onSpaceRoot;
		onChildNamed: #'context-menu--inline-temp'.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
'method1
	^ self printString size' ];
		onModel.
		
	aScripter check
		label: 'Check source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel.

	^ aScripter syncContinue
]

{ #category : 'examples - rename method' }
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
		id: GtSourceCoderEditorId.

	aScripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	self checkFor: aScripter saveButtonEnabled: true.
	self checkFor: aScripter discardButtonExists: false.
	
	aScripter check
		label: 'Check editor is focused';
		satisfies: [ :anEditorElement | anEditorElement isFocused ];
		id: GtSourceCoderEditorId.
	
	aScripter check
		label: 'Check cursor position';
		value: [ :anEditorElement | anEditorElement editor cursors positions ] equals: [ #(0) ];
		id: GtSourceCoderEditorId.

	^ aScripter syncContinue
]

{ #category : 'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_02_shortcut [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordRename_01_setup.
	
	aScripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	self checkFor: aScripter saveButtonEnabled: false.
	self checkFor: aScripter renameEditorExists: true.
	self checkFor: aScripter discardButtonExists: false.

	aScripter check
		label: 'Check rename editor all selected';
		value: [ :anEditor | anEditor editor selectedText asString ] equals: [ (aScripter model attributeNamed: #dummyMethod) selector ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor.

	^ aScripter syncContinue
]

{ #category : 'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_03_move_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordRename_02_shortcut.
	
	"this positions the cursor before `:`"
	aScripter keyClick: BlKeyboardKey arrowLeft.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	self checkFor: aScripter refactoringPreviewButtonExists: false.
	
	aScripter check
		label: 'Check cursor position';
		value: [ :anEditor | anEditor editor cursors positions ] equals: [ { (aScripter model attributeNamed: #dummyMethod) selector size - 1 } ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor.

	aScripter check
		label: 'Check rename editor all selected';
		value: [ :anEditor | anEditor editor selectedText asString ] equals: [ '' ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor.

	^ aScripter syncContinue
]

{ #category : 'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_04_type [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordRename_03_move_cursor.

	aScripter type: 'New'.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	self checkFor: aScripter renameEditorExists: true.
	self checkFor: aScripter refactoringPreviewButtonExists: true.
	self checkFor: aScripter saveButtonEnabled: false.
	self checkFor: aScripter discardButtonExists: false.

	aScripter check
		label: 'Check text';
		value: [ :anEditor | anEditor text asString ] equals: [ (aScripter model attributeNamed: #dummyMethod) selector allButLast, 'New:' ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor.

	^ aScripter syncContinue
]

{ #category : 'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_05_click_preview [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordRename_04_type.

	aScripter click
		label: 'Click refactoring preview button';
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRefactoringsPreviewButton.

	aScripter wait forEmptySpaceTaskQueue.

	self checkFor: aScripter discardButtonExists: true.

	aScripter check
		label: 'Check that refactorings preview appeared';
		exists;
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId.

	^ aScripter syncContinue
]

{ #category : 'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forKeywordRename_06_click_apply [
	<gtExample>
	| aScripter |

	aScripter := self forKeywordRename_05_click_preview.

	aScripter click
		label: 'Click refactorings apply button';
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	self checkFor: aScripter renameEditorExists: false.
	self checkFor: aScripter refactoringPreviewButtonExists: false.
	self checkFor: aScripter saveButtonEnabled: true.
	self checkFor: aScripter discardButtonExists: false.

	^ aScripter syncContinue
]

{ #category : 'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_01_setup [
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
('
	^ {1}' format: { (aCoder attributeNamed: #dummyMethod) anyInstVarName })
		];
		onModel.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - protect inst var' }
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_03_hover_protect_variable [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forProtectInstVar_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover protect';
		onSpaceRoot;
		id: #'context-menu--protect-variable'.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - protect inst var' }
GtPharoMethodCoderByScripterExamples >> forProtectInstVar_04_click_Protect_variable [
	<gtExample>
	| aScripter |

	aScripter := self forProtectInstVar_03_hover_protect_variable.

	aScripter click
		label: 'Click protect variable';
		onSpaceRoot;
		onChildNamed: #'context-menu--protect-variable'.

	aScripter wait forEmptySpaceTaskQueue.

	aScripter check
		label: 'Check refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | 
				aCoderEditor text size to: aCoderEditor text size ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	^ aScripter syncContinue
]

{ #category : 'examples - remove parameter' }
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
		label: 'type in a method with argument';
		action: [ :aCoder | aCoder appendString:
(': unusedArg
	{1} := Set new' format: { (aCoder attributeNamed: #dummyMethod) anyInstVarName })
		];
		onModel.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_02_cursor [
	<gtExample>
	| aScripter |

	aScripter := self forRemoveParameter_01_setup.
	aScripter do
		label: 'Select part of the parameter node';
		action: [ :aSourceEditor |
			aSourceEditor selecter
				from: 11 to: 12;
				select ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_03_hover_remove_parameter [
	<gtExample>
	| aScripter |

	aScripter := self openContextMenu: self forRemoveParameter_02_cursor.

	aScripter mouseMoveOver
		label: 'Hover remove parameter';
		onSpaceRoot;
		id: #'context-menu--remove-parameter'.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - remove parameter' }
GtPharoMethodCoderByScripterExamples >> forRemoveParameter_04_click_remove_parameter [
	<gtExample>
	| aScripter |

	aScripter := self forRemoveParameter_03_hover_remove_parameter.

	aScripter click
		label: 'Click remove parameter';
		onSpaceRoot;
		onChildNamed: #'context-menu--remove-parameter'.

	aScripter wait forEmptySpaceTaskQueue.

	aScripter check
		label: 'Check refactoring changes attribute';
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
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
		onModel.

	aScripter do
		label: 'Save a method with argument';
		action: [ :aCoder | aCoder save ];
		onModel.
		
	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
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
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check selected text';
		value: [ :aSourceEditor | aSourceEditor editor selectedText asString ]
			equals: [ '{1} := {1} + 42' format: { (aScripter model attributeNamed:  #dummyMethod) anyInstVarName } ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_03_context_menu [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_02_select.
	aScripter secondaryClick
		label: 'Open context menu';
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_04_hover_extract_method [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_03_context_menu.

	aScripter mouseMoveOver
		label: 'Hover extract method';
		onSpaceRoot;
		id: GtMethodCoderExtractMethodContextMenuItemId.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_05_click_extract_method [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_04_hover_extract_method.

	aScripter click
		label: 'Click extract method';
		onSpaceRoot;
		onChildNamed: GtMethodCoderExtractMethodContextMenuItemId.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
('{1}: anObject
	{2} := anObject.
	self _' format: {
		(aCoder attributeNamed: #dummyMethod) selector.
		(aCoder attributeNamed:  #dummyMethod) anyInstVarName
	}) ];
		onModel.
		
	aScripter check
		label: 'Check source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel.
	
	aScripter check
		label: 'Check rename editor attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter check
		label: 'Check refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
		
	aScripter check
		label: 'Check source editor is not focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused not ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
		
	aScripter check
		label: 'Check source editor has focus';
		satisfies: [ :aCoderEditor | aCoderEditor hasFocus ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	
	aScripter check
		label: 'Check method name editor source code';
		value: [ :aNameEditor | aNameEditor text asString ] equals: '_';
		onChildNamed: GtPharoSourceCoder sourceEditorName;
		onBreadthFirstChildOfClass: GtRenameEditor.
		
	aScripter check
		label: 'Check method name editor selected text';
		value: [ :aNameEditor | aNameEditor editor selectedText asString ] equals: '_';
		onChildNamed: GtPharoSourceCoder sourceEditorName;
		onBreadthFirstChildOfClass: GtRenameEditor.

	aScripter check
		label: 'Check method name editor has focus';
		satisfies: [ :aNameEditor | aNameEditor isFocused ];
		onChildNamed: GtPharoSourceCoder sourceEditorName;
		onBreadthFirstChildOfClass: GtRenameEditor.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_06_type_method_name [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_05_click_extract_method.

	aScripter type: (self extractedUnaryMethodNameFor: aScripter model).
	
	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		onChildNamed: GtSourceCoderEditorId.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_07_01_accept_with_enter [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_06_type_method_name.

	aScripter keyClick: BlKeyboardKey return.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check current source in coder model';
		value: [ :aCoder | aCoder currentSourceString gtRemoveEmptyLines ] equals: [ :aCoder |
('{1}: anObject
	{2} := anObject.
	self {3}' format: {
		(aCoder attributeNamed: #dummyMethod) selector.
		(aCoder attributeNamed:  #dummyMethod) anyInstVarName.
		self extractedUnaryMethodNameFor: aCoder
	}) ];
		onModel.
		
	aScripter check
		label: 'Check source code modified';
		satisfies: [ :aCoder | aCoder isModified ];
		onModel.
	
	aScripter check
		label: 'Check rename editor attribute';
		value: [ :aCoderEditor |
			aCoderEditor text
				hasAttributeSuchThat: [ :eachAttribute | eachAttribute class = GtRenameEditorAttribute ] ]
			equals: false;
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter check
		label: 'Check refactoring changes attribute';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ :aCoderEditor | aCoderEditor text size to: aCoderEditor text size ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
		
	aScripter check
		label: 'Check source editor is focused';
		satisfies: [ :aCoderEditor | aCoderEditor isFocused ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_08_preview_refactoring [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_07_01_accept_with_enter.

	aScripter click
		onBreadthFirstChildOfClass: GtRefactoringsPreviewButton.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId;
		exists.

	^ aScripter syncContinue
]

{ #category : 'examples - extract method' }
GtPharoMethodCoderByScripterExamples >> forUnaryExtraction_09_apply_refactoring [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryExtraction_08_preview_refactoring.

	aScripter click
		onSpaceRoot;
		id: GtRefactoringsPreviewAcceptId.

	aScripter wait forEmptySpaceTaskQueue.

	aScripter check
		label: 'Check refactoring changes attribute does not exist';
		value: [ :aCoderEditor |
			| anInterval |
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtRefactoringChangesAttribute ]
				indicesDo: [ :aStart :anEnd | anInterval := aStart to: anEnd ].
			anInterval ]
			equals: [ nil ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter check
		onBreadthFirstChildOfClass: GtRefactoringsPreviewButton;
		notExists.

	^ aScripter syncContinue
]

{ #category : 'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forUnaryRename_01_setup [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self scripterForBlock: [
		| aCoder |
		aCoder := GtPharoMethodCoderExamples new forUnaryInstanceMethod.
		environment := aCoder attributeNamed: #dummyEnvironment.
		aCoder ].
	aScripter click
		label: 'Click on the coder editor to give it focus';
		id: GtSourceCoderEditorId.

	aScripter shortcut
		combination: BlKeyCombination arrowUp;
		id: GtSourceCoderEditorId.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check editor is focused';
		satisfies: [ :anEditorElement | anEditorElement isFocused ];
		id: GtSourceCoderEditorId.
	
	aScripter check
		label: 'Check cursor position';
		value: [ :anEditorElement | anEditorElement editor cursors positions ] equals: [ #(0) ];
		id: GtSourceCoderEditorId.

	^ aScripter syncContinue
]

{ #category : 'examples - rename method' }
GtPharoMethodCoderByScripterExamples >> forUnaryRename_02_shortcut [
	<gtExample>
	| aScripter |

	aScripter := self forUnaryRename_01_setup.
	
	aScripter shortcut
		combination: BlKeyCombination primaryR;
		id: GtSourceCoderEditorId.
	
	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		label: 'Check rename editor exists';
		exists;
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor.

	aScripter check
		label: 'Check rename editor all selected';
		value: [ :anEditor | anEditor editor selectedText asString ] equals: [ (aScripter model attributeNamed: #dummyMethod) selector ];
		id: GtSourceCoderEditorId;
		onBreadthFirstChildOfClass: GtRenameEditor.

	^ aScripter syncContinue
]

{ #category : 'examples - basic' }
GtPharoMethodCoderByScripterExamples >> methodCoder [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter set model: [ self basicMethodCoder ].
	^ aScripter
]

{ #category : 'examples - fixit class' }
GtPharoMethodCoderByScripterExamples >> openAndClickFixItActionFor: aScripter id: aBlElementId [
	"An utility method to open and click on the fixIt action with id.
	I assume that the fixit menu does not already exists"
	
	self clickFixItFor: aScripter.
	self clickFixItActionFor: aScripter id: aBlElementId
]

{ #category : 'utilities' }
GtPharoMethodCoderByScripterExamples >> openContextMenu: aScripter [

	aScripter secondaryClick
		label: 'Open context menu';
		onChildNamed: GtPharoSourceCoder sourceEditorName.

	aScripter wait forEmptySpaceTaskQueue.

	^ aScripter syncContinue
]

{ #category : 'examples - pattern highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterMethod [
	<gtExample>
	^ GtPharoMethodCoderExamples >> #a:a:a:a:
]

{ #category : 'examples - pattern highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self patternHighlighterMethod.
	aCoder := self coderOnMethod: aMethod.
	aCoder highlighter: (GtPharoImplementorPatternHighlighter forPattern: 'a:').
	^ aCoder
]

{ #category : 'examples - pattern highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self patternHighlighterMethodCoder ].
	^ aScripter syncContinue
]

{ #category : 'examples - pattern highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterMethodCoderUI_CheckUndelineAttributes [
	<gtExample>
	| aScripter |
	aScripter := self patternHighlighterMethodCoderUI.
	aScripter checks: 'Check Pattern Highlighter Source Code Style' do: [ :aStep |
		self checkFor: aStep textAttributesAt: 2 anySatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
		self checkFor: aStep numberfOfTextAttributes: 8 OfType: BlTextDecorationAttribute.
	].
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'examples - pattern highlither - print' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintMethod [
	<gtExample>

	^ GtPharoMethodCoderExamples >> #printStringReference
]

{ #category : 'examples - pattern highlither - print' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self patternHighlighterPrintMethod.
	aCoder := self coderOnMethod: aMethod.
	aCoder highlighter: (GtPharoImplementorPatternHighlighter forPattern: 'print').
	^ aCoder
]

{ #category : 'examples - pattern highlither - print' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self patternHighlighterPrintMethodCoder ].
	^ aScripter syncContinue
]

{ #category : 'examples - pattern highlither - print' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintMethodCoderUI_CheckUndelineAttributes [
	<gtExample>
	| aScripter |
	aScripter := self patternHighlighterPrintMethodCoderUI.
	aScripter checks: 'Check Pattern Highlighter Source Code Style' do: [ :aStep |
		self checkFor: aStep textAttributesAt: 1 anySatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
		self checkFor: aStep numberfOfTextAttributes: 5 OfType: BlTextDecorationAttribute.
		self checkFor: aStep textAttributesAt: 30 nonSatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
	].
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintStringMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self patternHighlighterPrintMethod.
	aCoder := self coderOnMethod: aMethod.
	aCoder highlighter: (GtPharoSelectorReferenceAndLiteralHighlighter forSelector: #printString).
	^ aCoder
]

{ #category : 'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintStringMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self patternHighlighterPrintStringMethodCoder ].
	^ aScripter syncContinue
]

{ #category : 'examples - reference highlighter' }
GtPharoMethodCoderByScripterExamples >> patternHighlighterPrintStringMethodCoderUI_CheckUndelineAttributes [
	<gtExample>
	| aScripter |
	aScripter := self patternHighlighterPrintStringMethodCoderUI.
	aScripter checks: 'Check Pattern Highlighter Source Code Style' do: [ :aStep |
		self checkFor: aStep textAttributesAt: 1 nonSatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
		self checkFor: aStep textAttributesAt: 30 anySatisfies: [ :aTextAttribute | aTextAttribute class = BlTextDecorationAttribute ].
		self checkFor: aStep numberfOfTextAttributes: 11 OfType: BlTextDecorationAttribute.
	].
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethod [
	<gtExample>
	^ GtPharoMethodCoderExamples >> #b
]

{ #category : 'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoder [
	<gtExample>
	| aMethod aCoder |
	aMethod := self referencedExampleMethod.
	aCoder := self coderOnMethod: aMethod.
	^ aCoder
]

{ #category : 'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ self referencedExampleMethodCoder asCoderViewModel ].
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI_CheckExampleAttribute [
	<gtExample>
	| aScripter |
	aScripter := self referencedExampleMethodCoderUI.
	aScripter checks: 'Check Example Status' do: [ :aStep | 
		self checkFor: aStep textExampleStatusAttributeAt: 1 ].
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI_CheckExampleExpandAttribute [
	<gtExample>
	| aScripter |
	aScripter := self referencedExampleMethodCoderUI.
	aScripter checks: 'Check Example Status and Expand Attribute' do: [ :aStep | 
		self checkFor: aStep textExpandAttributeAt: 24.
		self checkFor: aStep textExampleStatusAttributeAt: 1 ].
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI_NoExampleStatusAfterPragmaDeletion [
	<gtExample>
	| aScripter |
	aScripter := self referencedExampleMethodCoderUI.
	aScripter substeps: 'Remove Pragma' do: [ :aStep |
		aStep do
			label: 'Delete e character from <gtExample>';
			action: [ :anEditor | anEditor deleter from: 12 to: 13; delete ];
			onChildNamed: #editor;
			onBrTextEditor.
		self 
			checkFor: aStep
			numberOfMainActions: 6
			contextAction: 0.
		self checkFor: aStep absenceOfContextActionNamed: 'Play Example' ].
	aScripter checks: 'Check Example Status Is Not Present' do: [ :aStep | 
		self checkFor: aStep textExpandAttributeAt: 23.
		self 
			checkFor: aStep 
			textAttributesAt: 1 
			nonSatisfies: [ :aTextAttribute | aTextAttribute class = GtCoderExampleStatusAttribute ] ].
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'examples - referenced example' }
GtPharoMethodCoderByScripterExamples >> referencedExampleMethodCoderUI_NoExampleStatusAfterPragmaDeletion_WriteExamplePragma [
	<gtExample>
	| aScripter |
	aScripter := self referencedExampleMethodCoderUI_NoExampleStatusAfterPragmaDeletion.
	aScripter substeps: 'Insert Pragma' do: [ :aStep |
		aStep do
			label: 'Insert e character in <gtExample>';
			action: [ :anEditor | anEditor inserter at: 12; string: 'e'; insert ];
			onChildNamed: #editor;
			onBrTextEditor.
		aStep wait forEmptySpaceTaskQueue.
		self 
			checkFor: aStep
			numberOfMainActions: 5
			contextAction: 4.
		self checkFor: aStep existenceOfContextActionNamed: 'Play Example' ].
	aScripter checks: 'Check Example Status Is Present' do: [ :aStep | 
		self checkFor: aStep textExpandAttributeAt: 24.
		self checkFor: aStep textExampleStatusAttributeAt: 1. ].
	aScripter syncContinue.
	^ aScripter
]
