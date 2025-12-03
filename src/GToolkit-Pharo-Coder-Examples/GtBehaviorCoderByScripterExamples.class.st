Class {
	#name : #GtBehaviorCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#instVars : [
		'environment'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClass [
	<gtExample>
	<after: #cleanUp>
	| aDummyClass aBehaviorCoder |
	
	environment := GtPharoDummyEnvironment withPackages: 2 classes: 2.
	aDummyClass := environment anyDummyClass.

	aBehaviorCoder := GtPharoBehaviorCoder forClass: aDummyClass realClass.
	aBehaviorCoder attributeNamed: #dummyEnvironment put: environment.
	aBehaviorCoder attributeNamed: #dummyClass put: aDummyClass.

	^ aBehaviorCoder
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ self classCoderForClass ].
	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_advices_removeClass_01_showAdvices [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter click
		label: 'Click advice button';
		// GtFixItButton;
		play.
		
	aScripter check
		label: 'Assert remove class advice is present';
		onSpaceRoot;
		// BrLabel;
		@ [:aLabel |
			aLabel text asString = ('Remove ', aScripter model behavior name)];
		exists;
		play.
	
	aScripter click
		label: 'Click remove class advice';
		onSpaceRoot;
		// BrLabel;
		@ [:aLabel |
			aLabel text asString = ('Remove ', aScripter model behavior name)];
		play.
		
	self
		assert: (Smalltalk globals 
			hasClassNamed: (aScripter model behavior name)) not.

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_click_add_method [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Add new method'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click add method button';
						id: GtPharoAddNewMethodButtonId ] ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_click_expand_definition [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Expand class definition'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click expand class definition';
						id: GtSourceCoderExpanderToggleId ] ].
	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_click_slot [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI_click_expand_definition.
	aScripter
		substep: ''
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						// (GtMagritteFieldElementId new description: GtBehaviorCreationForm new slotsDescription) ] ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_copyClassName [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Copy class name with a shortcut'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click class name';
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep shortcut
				combination: BlKeyCombination primaryC;
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert clipboard has class name';
						value: [ Clipboard clipboardText ]
							equals: [ :aCoder | (aCoder attributeNamed: #dummyClass) className ];
						onModel ] ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_deleteClass_01_clickButton [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter menuStep
		openContextMenu;
		// GtBehaviorCoderBehaviorNameId;
		play.

	aScripter menuStep
		label: 'Click remove class button';
		hoverMenuItemWithId: #'coder--context-menu-remove-class';
		onPopover;
		play.

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_deleteClass_02_clickButton_confirmRemoval [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI_deleteClass_01_clickButton.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click the confirmation button';
				onPopover;
				// #'removeButton' ].

	self
		assert: (Smalltalk globals 
			hasClassNamed: (aScripter model behavior name)) not.

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_displayBehaviorView [
	"See https://github.com/feenkcom/gtoolkit/issues/4722"
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter click
		label: 'Display class definition view';
		// GtPhlowCompositeViewElementId;
		// BrTab;
		@ [ :eachTab | eachTab label characters = 'Definition' ];
		play.

	aScripter assert
		label: 'Assert definition snippet coder is displayed';
		value: [ :anElement | anElement textualCoderViewModel coderModel class ]
			equals: GtPharoBehaviorDefinitionSnippetCoder;
		// GtPhlowCompositeViewElementId;
		// GtSourceCoderEditorId;
		play.
	
	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_displayBehaviorView_addInstVar [
	"See https://github.com/feenkcom/gtoolkit/issues/4722"

	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI_displayBehaviorView.

	aScripter click
		label: 'Click to get editor focus';
		// GtPhlowCompositeViewElementId;
		// GtSourceCoderEditorId;
		play.

	self
		forPharo12AndNewer: [ aScripter do
				label: 'Insert a new instance variable name';
				block: [ :anEditor | 
					| anIndex |
					anIndex := anEditor text finder
							substring: 'slots:';
							search.
					self assert: anIndex isZero not.
					anEditor editor navigator
						moveTo: anIndex;
						apply.
					anEditor editor navigator
						moveToLineEnd;
						apply.
					anEditor editor navigator
						moveLeft;
						apply.
					anEditor editor navigator
						moveLeft;
						apply.
					anEditor editor inserter
						atCursor;
						string: '. #newInstVar';
						insert ];
				// GtPhlowCompositeViewElementId;
				// GtSourceCoderEditorId;
				play ]
		forPharo11: [ aScripter do
				label: 'Insert a new instance variable name';
				block: [ :anEditor | 
					| anIndex |
					anIndex := anEditor text finder
							substring: 'instanceVariableNames:';
							search.
					self assert: anIndex isZero not.
					anEditor editor navigator
						moveTo: anIndex;
						apply.
					anEditor editor navigator
						moveToLineEnd;
						apply.
					anEditor editor navigator
						moveLeft;
						apply.
					anEditor editor inserter
						atCursor;
						string: ' newInstVar';
						insert ];
				// GtPhlowCompositeViewElementId;
				// GtSourceCoderEditorId;
				play ].

	aScripter assert
		label: 'Assert coder is modified';
		satisfies: [ :anEditor | anEditor textualCoderViewModel isModified ];
		// GtPhlowCompositeViewElementId;
		// GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_displayBehaviorView_addInstVar_compile [
	"See https://github.com/feenkcom/gtoolkit/issues/4722"

	<gtExample>
	| aScripter existingSlots |
	aScripter := self classCoderForClassUI_displayBehaviorView_addInstVar.


	aScripter do
		label: 'Store number of existing instance-side slots';
		block: [ :aCoder | existingSlots := aCoder behavior slots ];
		onModel;
		play.

	aScripter click
		label: 'Click compile class definition button';
		// GtPhlowCompositeViewElementId;
		// GtSourceCoderDoItActionId;
		play.

	aScripter assert
		label: 'Assert coder is modified';
		satisfies: [ :anEditor | anEditor textualCoderViewModel isModified not ];
		// GtPhlowCompositeViewElementId;
		// GtSourceCoderEditorId;
		play.
		
	aScripter assert
		label: 'Assert number of new instance-side slots';
		value: [ :aCoder | aCoder behavior slots size ] equals: existingSlots size + 1;
		onModel;
		play.

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_renameClass_01_doubleClick [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Make class name editable with a double click'
		do: [ :aStep | 
			aStep doubleClick
				label: 'Click class name';
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name is editable';
						satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
						id: GtBehaviorCoderBehaviorNameId ] ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_renameClass_01_shortcut [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Make class name editable with a shortcut'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click class name';
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep shortcut
				combination: BlKeyCombination primaryR;
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name is editable';
						satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ] ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_renameClass_02_type_new_class_name [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI_renameClass_01_shortcut.

	aScripter
		substep: 'Type new class name'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert apply preview button does not exist yet';
						value: [ :anElement | anElement visibility ] equals: BlVisibility gone;
						id: GtBehaviorCoderBehaviorNameApplyPreviewId ].

			(aStep type: (aScripter model attributeNamed: #dummyClass) className , 'New')
				label: 'Click class name';
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name is editable';
						satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert entered name';
						value: [ :aClassNameEditor | aClassNameEditor text asString ]
							equals: [ (aScripter model attributeNamed: #dummyClass) className , 'New' ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert apply preview button exists';
						value: [ :anElement | anElement visibility ] equals: BlVisibility visible;
						id: GtBehaviorCoderBehaviorNameApplyPreviewId ] ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_renameClass_03_click_rename_preview [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI_renameClass_02_type_new_class_name.

	aScripter
		substep: 'Click rename preview'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click apply preview button';
						id: GtBehaviorCoderBehaviorNameApplyPreviewId;
						/ #previewCheckButton ] ].

	aScripter menuStep
		assertMenuContainerExist;
		play.

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderInPagerForClassUI [
	<gtExample>
	| aScripter |

	aScripter := self scripterInPagerForBlock: [ 
		self classCoderForClass ].
	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderInPagerForClassUI_browseClassMethodImplementors [
	"See https://github.com/feenkcom/gtoolkit/issues/4231"

	<gtExample>
	| aScripter aBehavior aMethod aNewMethod aNewSourceCode |
	aScripter := self classCoderInPagerForClassUI.

	aBehavior := aScripter model behavior classSide.
	aMethod := aBehavior methods anyOne.

	aScripter methodsCoder
		onPagerPaneWithIndex: 1;
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: aMethod;
		forCompiledMethod: aMethod
			do: [ :aMethodCoderStep | aMethodCoderStep browseImplementors ];
		play.

	aScripter methodsCoder
		onPagerPaneWithIndex: 2;
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: aMethod;
		scrollToCompiledMethod: aMethod;
		forCompiledMethod: aMethod
			do: [ :aMethodCoderStep | 
				aMethodCoderStep
					moveCursorToEnd;
					typeText: ' self yourself';
					formatCode;
					assertCoderIsModified;
					clickOnSaveButton;
					assertCoderIsWithouthModifications;
					editorTextDo: [ :aText | aNewSourceCode := aText asString ] ];
		play.

	self assert: (aNewSourceCode includesSubstring: 'self yourself').
	aNewMethod := aBehavior methodDict at: aMethod selector.
	self assert: aNewMethod sourceCode ~= aMethod sourceCode.
	self assert: aNewMethod sourceCode equals: aNewSourceCode.

	aScripter methodsCoder
		onPagerPaneWithIndex: 1;
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: aMethod;
		forCompiledMethod: aNewMethod
			do: [ :aMethodCoderStep | aMethodCoderStep assertEditorTextAsStringIs: aNewSourceCode ];
		play.

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderInPagerForClassUI_browseInstanceMethodImplementors [
	"See https://github.com/feenkcom/gtoolkit/issues/4231"

	<gtExample>
	| aScripter aBehavior aMethod aNewMethod aNewSourceCode |
	aScripter := self classCoderInPagerForClassUI.

	aBehavior := aScripter model behavior.
	aMethod := aBehavior methods detect: [ :e | e selector = #method2: ].

	aScripter methodsCoder
		onPagerPaneWithIndex: 1;
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: aMethod;
		forCompiledMethod: aMethod
			do: [ :aMethodCoderStep | aMethodCoderStep browseImplementors ];
		play.

	aScripter methodsCoder
		onPagerPaneWithIndex: 2;
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: aMethod;
		scrollToCompiledMethod: aMethod;
		forCompiledMethod: aMethod
			do: [ :aMethodCoderStep | 
				aMethodCoderStep
					moveCursorToEnd;
					typeText: ' self yourself';
					formatCode;
					assertCoderIsModified;
					clickOnSaveButton;
					assertCoderIsWithouthModifications;
					editorTextDo: [ :aText | aNewSourceCode := aText asString ] ];
		play.

	self assert: (aNewSourceCode includesSubstring: 'self yourself').
	aNewMethod := aBehavior methodDict at: aMethod selector.
	self assert: aNewMethod sourceCode ~= aMethod sourceCode.
	self assert: aNewMethod sourceCode equals: aNewSourceCode.

	aScripter methodsCoder
		onPagerPaneWithIndex: 1;
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: aMethod;
		forCompiledMethod: aNewMethod
			do: [ :aMethodCoderStep | aMethodCoderStep assertEditorTextAsStringIs: aNewSourceCode ];
		play.

	^ aScripter
]

{ #category : #utilities }
GtBehaviorCoderByScripterExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]
