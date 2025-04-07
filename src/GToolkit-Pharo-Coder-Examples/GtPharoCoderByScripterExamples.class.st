"
I exemplify {{gtClass:GtCoder}}. 
"
Class {
	#name : #GtPharoCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - evaluation context' }
GtPharoCoderByScripterExamples >> addBackNewInstanceSideMethod [
	"See https://github.com/feenkcom/gtoolkit/issues/4257"

	<gtExample>
	| aScripter anInstanceSideMethod aClassSideMethod anObject aMethodsCoderQuery |
	aScripter := self addNewClassSideMethod.
	anInstanceSideMethod := GtPharoDummyTwoObject >> #sum21Reference.
	aClassSideMethod := GtPharoDummyTwoObject class >> #sum21Reference.
	
	aMethodsCoderQuery := aScripter element query // GtPharoStreamingMethodsCoderElement.
	anObject := aMethodsCoderQuery anyOne streamingCodersViewModel selfObjectIfNone: [ self error: 'Self object must be defined' ].
	
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the switch method side button';
				onSpaceRoot;
				onDropdown: true;
				// GtPharoSideTagId;
				onTopMost ].
				
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the instance-side button';
				onSpaceRoot;
				onDropdown: true;
				@ 2;
				onBrButtonName: 'instance' ].

	aScripter methodCoder
		onSpaceRoot;
		onDropdown: true;
		// GtSourceCoderEditorId;
		assertSelfObjectIs: anObject;
		assertTargetBehaviorIs: anObject class instanceSide;
		clickOnMethodCoderExpander: 1 insideDo: [ :aMethodCoder | 
			aMethodCoder 
				assertCompiledMethodIs: anInstanceSideMethod;
				assertSelfObjectIs: anObject;
				assertTargetBehaviorIs: anObject class instanceSide ];
		play.

	^ aScripter
]

{ #category : #'exaples - add new method' }
GtPharoCoderByScripterExamples >> addMethodDropdownRemembersItsContent [
	"See [](https://github.com/feenkcom/gtoolkit/issues/3230)"

	<gtExample>
	| aScripter |
	aScripter := self displayThreeClassCodersWithMethodExpanded.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the add new method button';
				// (GtPagerPageElementId indexed: 2);
				// GtPharoAddNewMethodButtonId ].

	aScripter
		typeStep: [ :s | 
			s
				text: 'myNewMethod' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert new method source code';
				value: [ :anEditor | anEditor text asString ]
					equals: [ :anEditor | 'myNewMethod' ];
				onSpaceRoot;
				onDropdown: true;
				// GtSourceCoderEditorId ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Close the dropdown';
				// (GtPagerPageElementId indexed: 2);
				// GtBehaviorCoderBehaviorNameId ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Reopen the add new method button';
				// (GtPagerPageElementId indexed: 2);
				// GtPharoAddNewMethodButtonId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert new method source code';
				value: [ :anEditor | anEditor text asString ]
					equals: [ :anEditor | 'myNewMethod' ];
				onSpaceRoot;
				onDropdown: true;
				// GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoCoderByScripterExamples >> addNewClassSideMethod [
	"See https://github.com/feenkcom/gtoolkit/issues/4257"

	<gtExample>
	| aScripter anInstanceSideMethod aClassSideMethod anObject aMethodsCoderQuery |
	aScripter := self addNewInstanceSideMethod.
	anInstanceSideMethod := GtPharoDummyTwoObject >> #sum21Reference.
	aClassSideMethod := GtPharoDummyTwoObject class >> #sum21Reference.
	
	aMethodsCoderQuery := aScripter element query // GtPharoStreamingMethodsCoderElement.
	anObject := aMethodsCoderQuery anyOne streamingCodersViewModel selfObjectIfNone: [ self error: 'Self object must be defined' ].
	
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the switch method side button';
				onSpaceRoot;
				onDropdown: true;
				// GtPharoSideTagId;
				onTopMost ].
				
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the class-side button';
				onSpaceRoot;
				onDropdown: true;
				@ 2;
				onBrButtonName: 'class' ].

	aScripter methodCoder
		onSpaceRoot;
		onDropdown: true;
		// GtSourceCoderEditorId;
		assertSelfObjectIs: anObject class instanceSide;
		assertTargetBehaviorIs: anObject class classSide;
		clickOnMethodCoderExpander: 1 insideDo: [ :aMethodCoder | 
			aMethodCoder 
				assertCompiledMethodIs: aClassSideMethod;
				assertSelfObjectIs: anObject class instanceSide;
				assertTargetBehaviorIs: anObject class classSide ];
		play.

	^ aScripter
]

{ #category : #'examples - evaluation context' }
GtPharoCoderByScripterExamples >> addNewInstanceSideMethod [
	"See https://github.com/feenkcom/gtoolkit/issues/4257"

	<gtExample>
	| aScripter anInstanceSideMethod aClassSideMethod anObject aMethodsCoderQuery |
	aScripter := self coderWithDummyTwoObjectInstanceInPager.
	anInstanceSideMethod := GtPharoDummyTwoObject >> #sum21Reference.
	aClassSideMethod := GtPharoDummyTwoObject class >> #sum21Reference.

	aMethodsCoderQuery := aScripter element query // GtPharoStreamingMethodsCoderElement.
	anObject := aMethodsCoderQuery anyOne streamingCodersViewModel selfObjectIfNone: [ self error: 'Self object must be defined' ].
	
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the add new method button';
				// (GtPagerPageElementId indexed: 1);
				// GtPharoAddNewMethodButtonId ].

	aScripter methodCoder
		onSpaceRoot;
		onDropdown: true;
		// GtSourceCoderEditorId;
		click;
		assertHasFocus;
		selectAll;
		typeText: 'newMethod self ', #sum21Reference;
		assertSelfObjectIs: anObject;
		assertTargetBehaviorIs: anObject class;
		clickOnMethodCoderExpander: 1 insideDo: [ :aMethodCoder | 
			aMethodCoder 
				assertCompiledMethodIs: anInstanceSideMethod;
				assertSelfObjectIs: anObject;
				assertTargetBehaviorIs: anObject class ];
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
GtPharoCoderByScripterExamples >> assertDropdown: aScripter [

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert dropdown bounds';
				satisfies: [ :aContentElement | 
					| aTopMostRectangle |
					aTopMostRectangle := aContentElement topMostParent bounds inSpace
							asRectangle.
					(aTopMostRectangle containsRect: aContentElement bounds inSpace asRectangle)
						and: [ aContentElement children
								allSatisfy: [ :aChild | aTopMostRectangle containsRect: aChild bounds inSpace asRectangle ] ] ];
				onSpaceRoot;
				onDropdown: true ]
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> cancelRenameClassInIndex [
	<gtExample>
	<after: #cleanUp>
	| scripter |
	scripter := self startRenamingClassInIndex.
	scripter
		keyPressStep: [ :s | 
			s
				label: 'Cancel rename';
				key: BlKeyboardKey escape ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check editor is removed';
				notExists;
				onSpaceRoot;
				id: #renameClassEditor ].
	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> checkClassListIn: scripter containsName: aSymbol exists: aBoolean [
	scripter
		checkStep: [ :s | 
			aBoolean ifTrue: [ s exists ] ifFalse: [ s notExists ].
			s
				label: 'Check class list has ' , aSymbol;
				// GtCoderClassesTreeElement;
				// BrLabel;
				@ [ :each | each text asString = aSymbol asString ] ]
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> checkCompletionUpdatesForNewInstanceVariables [
	<gtExample>
	| scripter |
	scripter := self displayMaximizedCoderWithMethodExpanded.
	scripter
		doStep: [ :step | 
			step
				label: 'Reset text';
				// GtSourceCoderEditorId;
				block: [ :editor | 
					editor editor
						text: 'a ^aaa' asRopedText;
						moveCursorTo: 6 ] ].
	(scripter keyDown: BlKeyboardKey controlLeft) play.
	(scripter keyPress: BlKeyboardKey space) play.
	(scripter keyUp: BlKeyboardKey controlLeft) play.
	scripter
		checkStep: [ :s | 
			s
				onSpaceRoot;
				id: #'completion-list';
				do: [ :element | 
					| items item i |
					i := 1.
					items := element items.
					[ item isNil and: [ i < items size ] ]
						whileTrue: [ (items at: i) label = 'aaazzz'
								ifTrue: [ item := items at: i ]
								ifFalse: [ i := i + 1 ] ].
					self assert: item isNil ] ].
	(scripter keyPress: BlKeyboardKey escape) play.
	[ GtPharoDummyClass addInstVarNamed: 'aaazzz'.
	(scripter keyDown: BlKeyboardKey controlLeft) play.
	(scripter keyPress: BlKeyboardKey space) play.
	(scripter keyUp: BlKeyboardKey controlLeft) play.
	scripter
		checkStep: [ :s | 
			s
				onSpaceRoot;
				id: #'completion-list';
				do: [ :element | 
					| items item i |
					i := 1.
					items := element items.
					[ item isNil and: [ i < items size ] ]
						whileTrue: [ (items at: i) label = 'aaazzz'
								ifTrue: [ item := items at: i ]
								ifFalse: [ i := i + 1 ] ].
					self assert: item notNil ] ].
	(scripter keyPress: BlKeyboardKey escape) play ]
		ensure: [ GtPharoDummyClass removeInstVarNamed: 'aaazzz' ].
	(scripter keyDown: BlKeyboardKey controlLeft) play.
	(scripter keyPress: BlKeyboardKey space) play.
	(scripter keyUp: BlKeyboardKey controlLeft) play.
	scripter
		checkStep: [ :s | 
			s
				onSpaceRoot;
				id: #'completion-list';
				do: [ :element | 
					| items item i |
					i := 1.
					items := element items.
					[ item isNil and: [ i < items size ] ]
						whileTrue: [ (items at: i) label = 'aaazzz'
								ifTrue: [ item := items at: i ]
								ifFalse: [ i := i + 1 ] ].
					self assert: item isNil ] ].
	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> checkPackageListIn: scripter containsName: aSymbol [
	scripter
		checkStep: [ :s | 
			s
				label: 'Check package list has ' , aSymbol;
				exists;
				// GtCoderPackagesTreeElement;
				// BrLabel;
				@ [ :each | each text asString = aSymbol asString ] ]
]

{ #category : #'examples - refactoring' }
GtPharoCoderByScripterExamples >> checkSelectionForExtractTemporary [
	<gtExample>
	| scripter source method from to |
	method := self class >> #sampleMethodForRefactoringExample.
	scripter := self coderInPager: [ GtCoderElement forMethod: method ].
	source := method sourceCode.
	from := source indexOfSubCollection: 'e:'.
	to := source indexOf: $n startingAt: from.
	self
		selectTextFor: scripter
		from: from - 1
		to: to
		andCheck: 'e: 16 n'.
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Display context menu';
				// GtPharoStreamingMethodsCoderElement;
				// GtSourceCoderExpandedContentElement;
				// GtSourceCoderEditorId ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check extract temporary exists';
				onSpaceRoot;
				exists;
				// BrMenuTextLabelElement;
				// BrLabel;
				@ [ :each | each text asString beginsWith: 'Extract temporary ' ] ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Start extract temporary';
				onSpaceRoot;
				// BrMenuTextLabelElement;
				// BrLabel;
				@ [ :each | each text asString beginsWith: 'Extract temporary ' ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check refactored code';
				// GtPharoStreamingMethodsCoderElement;
				// GtSourceCoderExpandedContentElement;
				// GtSourceCoderEditorId;
				value: [ :editor | 
						| ast node |
						ast := GtPharoParser parse: editor text asString.
						ast
							withAllNodesOfType: GtPharoAssignmentNode
							do: [ :n | n variable source = '_' ifTrue: [ node := n value ] ].
						node source ]
					equals: 'value printStringBase: 16 nDigits: 2' ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check rename editor exists';
				exists;
				// GtRenameEditor ].
	scripter
		keyPressStep: [ :s | 
			s
				label: 'Cancel extract';
				key: BlKeyboardKey escape ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check rename editor removed';
				notExists;
				// GtRenameEditor ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check source reverted';
				// GtPharoStreamingMethodsCoderElement;
				// GtSourceCoderExpandedContentElement;
				// GtSourceCoderEditorId;
				value: [ :editor | editor text asString ] equals: source ].


	from := source indexOf: $,.	"Now test a binary selector"
	to := from + 5.
	self
		selectTextFor: scripter
		from: from - 1
		to: to
		andCheck: ', '' = '.
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Display context menu';
				// GtPharoStreamingMethodsCoderElement;
				// GtSourceCoderExpandedContentElement;
				// GtSourceCoderEditorId ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check extract temporary exists';
				onSpaceRoot;
				exists;
				// BrMenuTextLabelElement;
				// BrLabel;
				@ [ :each | each text asString beginsWith: 'Extract temporary ' ] ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Start extract temporary';
				onSpaceRoot;
				// BrMenuTextLabelElement;
				// BrLabel;
				@ [ :each | each text asString beginsWith: 'Extract temporary ' ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check refactored code';
				// GtPharoStreamingMethodsCoderElement;
				// GtSourceCoderExpandedContentElement;
				// GtSourceCoderEditorId;
				value: [ :editor | 
						| ast node |
						ast := GtPharoParser parse: editor text asString.
						ast
							withAllNodesOfType: GtPharoAssignmentNode
							do: [ :n | n variable source = '_' ifTrue: [ node := n value ] ].
						node source ]
					equals: '(value printStringBase: 16 nDigits: 2) , '' = ''''0F''''''' ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check rename editor exists';
				exists;
				// GtRenameEditor ].
	^ scripter
]

{ #category : #'as yet unclassified' }
GtPharoCoderByScripterExamples >> checkSlotsUpdateAfterClassChange [
	<gtExample>
	| scripter aScripter |
	aScripter := self
			coderInPager: [ GtCoderElement
					forMethod: GtCoderNavigationExamplesWithScripter >> #coderWithIndex ].
	self setSpace800x600Extent: aScripter.
	self maximizePagerPane: aScripter.
	scripter := aScripter.
	scripter
		clickStep: [ :s | 
			s
				// #slots;
				label: 'Click slots' ].
	scripter
		checkStep: [ :s | 
			s
				// GtCoderSlotsGroupedListElement;
				label: 'Slots list is empty';
				do: [ :list | self assert: list maxSelectionIndex equals: 0 ] ].
	[ GtCoderNavigationExamplesWithScripter addInstVarNamed: 'aaazzz'.
	scripter
		checkStep: [ :s | 
			s
				// GtCoderSlotsGroupedListElement;
				label: 'Slots list is empty';
				do: [ :list | self assert: list maxSelectionIndex > 0 ] ] ]
		ensure: [ GtCoderNavigationExamplesWithScripter removeInstVarNamed: 'aaazzz' ].
	scripter
		checkStep: [ :s | 
			s
				// GtCoderSlotsGroupedListElement;
				label: 'Slots list is empty';
				do: [ :list | self assert: list maxSelectionIndex equals: 0 ] ].
	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> classHierarchyInIndexUpdatesClassListOnClassChanges [
	<gtExample>
	<after: #cleanUp>
	| scripter cls package packages |
	scripter := self setupForPackageTests.
	packages := environment dummyPackages
			asSortedCollection: [ :a :b | a packageName < b packageName ].
	package := packages first.
	cls := package anyDummyClass realClass.
	scripter
		clickStep: [ :s | 
			s
				label: 'Switch to class hierarchy';
				// BrTab;
				@ [ :each | each label asString = 'Class Hierarchy' ] ].
	self
		checkClassListIn: scripter
		containsName: #OrderedCollection
		exists: false.

	cls superclass: OrderedCollection.
	scripter pulse.
	
	self
		checkClassListIn: scripter
		containsName: #OrderedCollection
		exists: true.

	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> classHierarchyIndexSelectionDoesNotUpdateClassList [
	<gtExample>
	<after: #cleanUp>
	| scripter cls package packages |
	scripter := self setupForPackageTests.
	packages := environment dummyPackages
			asSortedCollection: [ :a :b | a packageName < b packageName ].
	package := packages first.
	cls := package anyDummyClass realClass.
	scripter
		clickStep: [ :s | 
			s
				label: 'Switch to class hierarchy';
				// BrTab;
				@ [ :each | each label asString = 'Class Hierarchy' ] ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check hierarchy only has limited classes';
				notExists;
				// GtCoderClassesTreeElement;
				// BrLabel;
				@ [ :each | 
					#('ProtoObject' 'Object' 'Temporary*Class*')
						noneSatisfy: [ :e | e match: each text asString ] ] ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Select Object';
				// GtCoderClassesTreeElement;
				// BrLabel;
				@ [ :each | each text asString = 'Object' ] ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check hierarchy only has limited classes';
				notExists;
				// GtCoderClassesTreeElement;
				// BrLabel;
				@ [ :each | 
					#('ProtoObject' 'Object' 'Temporary*Class*')
						noneSatisfy: [ :e | e match: each text asString ] ] ].

	^ scripter
]

{ #category : #'examples - evaluation context' }
GtPharoCoderByScripterExamples >> classSideMethodsShouldHaveSelfAsBehaviorNotAnInstance [
	"See https://github.com/feenkcom/gtoolkit/issues/4127"

	<gtExample>
	| aScripter aClassSideMethod aReferencedMethod |
	aScripter := self coderWithDummyTwoObjectInstanceInPager.
	aClassSideMethod := GtPharoDummyTwoObject class >> #sum21Reference.
	aReferencedMethod := GtPharoDummyOneObject class >> #sum21.

	aScripter pager
		setPageAt: 1 widthInSpaceRatio: 1.0;
		play.

	aScripter methodsCoder
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: aClassSideMethod;
		scrollToCompiledMethod: aClassSideMethod;
		forCompiledMethod: aClassSideMethod
			do: [ :aMethodCoder | 
				aMethodCoder
					clickOnMethodCoderExpander: 1
					insideDo: [ :aStep1 | aStep1 assertCompiledMethodIs: aReferencedMethod ] ];
		scrollToCompiledMethod: aClassSideMethod;
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoCoderByScripterExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> closeContextMenuPressingEscapeKey [
	<gtExample>
	| aScripter |
	aScripter := self displayPharoMethodContextMenuExtentIn800x600Space.

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				// BrMenuSteppedElement;
				onThisOrBreadthFirstChildOfKind: BrList;
				exists ].

	aScripter shortcut
		combination: BlKeyCombination escape;
		play.

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				// BrMenuSteppedElement;
				notExists ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> closeSidebarContextMenuPressingEscapeKey [
	<gtExample>
	| aScripter |
	aScripter := self displayClassSidebarContextMenu.

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				onDropdown: true;
				// BrMenuItemsListElement;
				exists ].

	aScripter shortcut
		combination: BlKeyCombination escape;
		play.

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				// GtCoderNavigationContextMenuContent;
				notExists ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> closeSidebarContextMenuPressingEscapeKey_firstClickInsideOfMethodCoder [
	<gtExample>
	| aScripter |
	aScripter := self displayClassSidebarContextMenu_firstClickInsideOfMethodCoder.

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				onDropdown: true;
				// BrMenuItemsListElement;
				exists ].

	aScripter shortcut
		combination: BlKeyCombination escape;
		play.

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				onDropdown: true;
				notExists ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtPharoCoderByScripterExamples >> coder [
	<gtExample>
	^ self scripterForBlock: [ GtCoderElement forClass: GtPharoDummyClass ]
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager [
	<gtExample>
	^ self coderInPager: [ GtCoderElement forClass: GtPharoDummyClass ]
]

{ #category : #'examples - support' }
GtPharoCoderByScripterExamples >> coderInPager: aCoderOrBlock [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPager createWrappedOn: aCoderOrBlock value ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert one page';
				satisfies: [ :aPager | aPager pages size = 1 ];
				onSelf ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager_clickOnCopyClassButton [
	<gtExample>
	| aScripter |
	aScripter := self coderInPager.

	aScripter
		substeps: 'Click on Copy Class'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						// GtPharoBehaviorCoderElement;
						// GtCoderToolbarElement;
						// GtPharoCopyClassElementId ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager_clickOnGitButton [
	<gtExample>
	| aScripter |
	aScripter := self coderInPager.

	aScripter
		substeps: 'Go to Git'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						// GtPharoBehaviorCoderElement;
						// GtCoderToolbarElement;
						// GtCoderGitButtonId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert two pages';
						satisfies: [ :aPager | aPager pages size = 2 ];
						onSelf ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager_clickOnHierarchiesButton [
	<gtExample>
	| aScripter |
	aScripter := self coderInPager.

	aScripter
		substeps: 'Show Hierarchies'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						// GtPharoBehaviorCoderElement;
						// GtCoderToolbarElement;
						// GtCoderClassHierarchyButtonId ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager_gitExpanded [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self coderInPager_clickOnGitButton.

	aScripter
		substeps: 'Expand Git'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						// (GtPagerPageElementId indexed: 2);
						// GtPagerMaximizeButtonElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert sidebar is rendered';
						satisfies: #hasChildren;
						// GtPagerMaximizedPageElementId;
						// GtPagerToolWrapperElementId;
						id: #sidebar ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtPharoCoderByScripterExamples >> coderWithAddMethod [
	<gtExample>
	^ self coderInPager: [ GtCoderElement forMethod: GtPharoDummyClass >> #addDummyClassMethods: ]
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderWithDummyTwoObjectInstanceInPager [
	<gtExample>
	^ self coderInPager: [ GtCoderElement forObject: GtPharoDummyTwoObject new ]
]

{ #category : #'examples - scrolling' }
GtPharoCoderByScripterExamples >> coderWithVeryLongMethod [
	<gtExample>
	| aScripter |
	aScripter := self
			coderInPager: [ GtCoderElement forObject: GtPharoDummyFiveObject new ].

	aScripter pager
		setPageAt: 1 widthInSpaceRatio: 1.0;
		play.
	aScripter methodsCoder
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: self veryLongMethod;
		forCompiledMethod: self veryLongMethod
			do: [ :aMethodCoder | 
				aMethodCoder editor
					// GtSourceCoderEditorId;
					assertFullyVisibleParagraphAt: #first
						hasText: self veryLongMethodFirstLineString;
					assertFullyVisibleParagraphAt: #last
						hasNotText: self veryLongMethodLastLineString ];
		play.

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coder_clickOnHierarchiesButton [
	<gtExample>
	| aScripter |
	aScripter := self coder.

	aScripter
		substeps: 'Show Hierarchies'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						// GtPharoBehaviorCoderElement;
						// GtCoderToolbarElement;
						// GtCoderClassHierarchyButtonId ] ].

	^ aScripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> convertToSiblingInIndex [
	<gtExample>
	<after: #cleanUp>
	| rootClass class scripter step className |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2.
	rootClass := environment anyDummyRootClass.
	class := rootClass realClass.
	className := class name.
	scripter := self coderInPager: [ GtCoderElement forClass: class ].
	self maximizePagerPane: scripter.
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open class menu';
				// GtCoderClassesTreeItemElement;
				@ [ :each | each theClass = class ] ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Has convert to sibling menu item';
				exists;
				onSpaceRoot;
				// #'menu--list';
				// #'menu--label';
				@ [ :each | each text asString = ('Convert to sibling ' , className) ] ].

	step := scripter menuStep.
	step label: 'Hover convert to sibling'.
	step hoverMenuItem
		onSpaceRoot;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = ('Convert to sibling ' , className) ].
	step play.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check rename editor is visible';
				onSpaceRoot;
				exists;
				// #refactoringEditor ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Click in rename editor';
				onSpaceRoot;
				// #refactoringEditor ].


	scripter
		checkStep: [ :s | 
			s
				label: 'Check editor has focus';
				onSpaceRoot;
				// #refactoringEditor;
				hasFocus ].

	scripter
		keyPressStep: [ :s | 
			s
				label: 'Move to end';
				key: BlKeyboardKey end ].
	scripter
		typeStep: [ :s | 
			s
				label: 'Enter new class name';
				text: '1234' ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Refactoring preview does not exists';
				notExists;
				// #preview;
				@ [ :each | each isKindOf: GtRefactoringsPreviewButton ] ].
				
	scripter
		keyPressStep: [ :s | 
			s
				label: 'Open refactoring preview';
				key: BlKeyboardKey return ].

	(Delay forMilliseconds: 100) wait.	"Wait for preview to appear"
	scripter pulse.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button exists';
				exists;
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].

	^ scripter
]

{ #category : #'exaples - add new method' }
GtPharoCoderByScripterExamples >> displayAddMethodDropdown [
	"See [](https://github.com/feenkcom/gtoolkit/issues/3233)"

	<gtExample>
	| aScripter aScrollSpotterBy aButtonBoundsInSpace |
	aScripter := self displayThreeClassCodersWithMethodExpanded.

	aScripter menuStep prepareSteppedLayoutDropdownAnalyzer
		// (GtPagerPageElementId indexed: 2);
		// GtPharoAddNewMethodButtonId;
		play.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the add new method button';
				// (GtPagerPageElementId indexed: 2);
				// GtPharoAddNewMethodButtonId ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Compute right-side button distace';
				block: [ :aButton | 
					| aButtonBounds aSpaceBounds aDistance |
					aButtonBoundsInSpace := aButton boundsInSpace.
					aButtonBounds := aButton bounds inSpace asRectangle.
					aSpaceBounds := aButton space root bounds inSpace asRectangle.
					aDistance := aSpaceBounds right - aButtonBounds right.
					aScrollSpotterBy := aDistance negated ];
				// (GtPagerPageElementId indexed: 2);
				// GtPharoAddNewMethodButtonId ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Scroll GtPager';
				block: [ :anInfiniteElement | anInfiniteElement smoothScrollBy: aScrollSpotterBy @ 0 ];
				// #list ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert the add new method button moved';
				satisfies: [ :aButton | 
						(aButton boundsInSpace left closeTo: aButtonBoundsInSpace left precision: 1.0)
							not ]
					description: [ :aButton | 
						'Button did not move, original position is {1}, new position is {2}, scrolled by {3}'
							format: {aButtonBoundsInSpace left.
									aButton boundsInSpace left.
									aScrollSpotterBy} ];
				// (GtPagerPageElementId indexed: 2);
				// GtPharoAddNewMethodButtonId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert dropdown bounds';
				satisfies: [ :aContentElement | 
					aContentElement topMostParent bounds inSpace asRectangle
						containsRect: aContentElement bounds inSpace asRectangle ];
				onSpaceRoot;
				onDropdown: true;
				onChildAt: 2 ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayClassSidebarContextMenu [
	<gtExample>
	| aScripter |
	aScripter := self displayMaximizedCoderWithMethodExpanded.
	self displayClassSidebarContextMenu: aScripter.
	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayClassSidebarContextMenu: aScripter [
	<gtExample>
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Display context menu';
				// GtCoderClassesTreeElement;
				// (GtCoderNavigationClassesTreeElementId indexed: 1) ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert context menu bounds';
				satisfies: [ :aContentElement | 
					(aContentElement isVisibleFullyInParent: aContentElement parent)
						and: [ aContentElement isVisibleInSpace ] ];
				onSpaceRoot;
				onDropdown: true;
				onChildAt: 2 ]
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayClassSidebarContextMenu_firstClickInsideOfMethodCoder [
	<gtExample>
	| aScripter |
	aScripter := self displayMaximizedCoderWithMethodExpanded.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click inside of a method coder';
				onSpaceRoot;
				// GtPharoStreamingMethodsCoderElement;
				// (GtSourceCoderId indexed: 1);
				// GtSourceCoderEditorId;
				onChildAt: 1 ].

	self displayClassSidebarContextMenu: aScripter.
	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayMaximizedCoderWithMethodExpanded [
	<gtExample>
	| aScripter |
	aScripter := self coderWithAddMethod.
	self setSpace800x600Extent: aScripter.
	self maximizePagerPane: aScripter.
	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayPharoMethodContextMenuExtentIn800x345Space [
	<gtExample>
	| aScripter |
	aScripter := self coderWithAddMethod.

	aScripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 800 @ 345 ];
				onSpace ].

	self maximizePagerPane: aScripter.

	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Display context menu';
				onSpaceRoot;
				// GtPharoStreamingMethodsCoderElement;
				// (GtSourceCoderId indexed: 1);
				// GtSourceCoderEditorId;
				onChildAt: 1 ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert context menu extent';
				satisfies: [ :aSteppedElement | 
					| aMenuElement |
					aMenuElement := aSteppedElement childAt: 1.
					aMenuElement isVisibleInSpace and: [
						aMenuElement isVisibleFullyInParent: aSteppedElement ] ]
					description: [ :aSteppedElement | 
						'Context menu element is not fully visible in its stepped element parent: {1}'
							format: { aSteppedElement childAt: 1 } ];
				onSpaceRoot;
				// BrMenuSteppedElement ].

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayPharoMethodContextMenuExtentIn800x600Space [
	<gtExample>
	| aScripter |
	aScripter := self displayMaximizedCoderWithMethodExpanded.

	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Display context menu';
				onSpaceRoot;
				// GtPharoStreamingMethodsCoderElement;
				// (GtSourceCoderId indexed: 1);
				// GtSourceCoderEditorId;
				onChildAt: 1 ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert context menu extent';
				satisfies: [ :aSteppedElement | 
					| aMenuElement |
					aMenuElement := aSteppedElement childAt: 1.
					aMenuElement isVisibleInSpace and: [
						aMenuElement isVisibleFullyInParent: aSteppedElement ] ]
					description: [ :aSteppedElement | 
						'Context menu element is not fully visible in its stepped element parent: {1}'
							format: { aSteppedElement childAt: 1 } ];
				onSpaceRoot;
				// BrMenuSteppedElement ].

	^ aScripter
]

{ #category : #'examples - dropdown' }
GtPharoCoderByScripterExamples >> displaySecondPaneMethodSpotterDropdown [
	"Dropdown is displayed on the second pane.
	The first and the third pane are partially visible.
	The dropdown should be placed to the bottom left."

	<gtExample>
	| aScripter |
	aScripter := self displayThreeClassCodersWithMethodExpanded.

	aScripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 1000 @ 600 ];
				onSpace ].

	aScripter menuStep prepareSteppedLayoutDropdownAnalyzer
		// (GtPagerPageElementId indexed: 2);
		// GtPharoBehaviorCoderElement;
		// BrTabGroup;
		// GtPharoSearchCodeButtonId;
		play.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the search code button';
				// (GtPagerPageElementId indexed: 2);
				// GtPharoBehaviorCoderElement;
				// BrTabGroup;
				// GtPharoSearchCodeButtonId ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Scroll GtPager';
				block: [ :anInfiniteElement | anInfiniteElement smoothScrollBy: -370 @ 0 ];
				// #list ].

	self assertDropdown: aScripter.

	^ aScripter
]

{ #category : #'examples - dropdown' }
GtPharoCoderByScripterExamples >> displaySecondPaneMethodSpotterDropdown_scrolledByOnePixel [
	"Dropdown is displayed on the second pane.
	The first and the third pane are partially visible.
	The dropdown should be placed to the bottom left."

	<gtExample>
	| aScripter |
	aScripter := self displayThreeClassCodersWithMethodExpanded.

	aScripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 1000 @ 600 ];
				onSpace ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the search code button';
				// (GtPagerPageElementId indexed: 2);
				// GtPharoBehaviorCoderElement;
				// BrTabGroup;
				// GtPharoSearchCodeButtonId ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Scroll GtPager';
				block: [ :anInfiniteElement | anInfiniteElement smoothScrollBy: -371 @ 0 ];
				// #list ].

	self assertDropdown: aScripter.

	^ aScripter
]

{ #category : #'examples - coder' }
GtPharoCoderByScripterExamples >> displayThreeClassCodersWithMethodExpanded [
	<gtExample>
	| aScripter |
	aScripter := self displayTwoClassCodersWithMethodExpanded.

	aScripter
		substeps: 'Open the second coder pane'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on class name';
						id: GtPagerPageElementId index: 2;
						// GtBehaviorCoderBehaviorNameId ].

			aStep shortcut
				label: 'Spawn class coder';
				combination: BlKeyCombination primaryB;
				id: GtPagerPageElementId index: 2;
				// GtBehaviorCoderBehaviorNameId;
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pager with two panes';
						value: [ :aPager | aPager pages size ] equals: [ 3 ] ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtPharoCoderByScripterExamples >> displayTwoClassCodersWithMethodExpanded [
	<gtExample>
	| aScripter |
	aScripter := self coderWithAddMethod.
	self setSpace800x600Extent: aScripter.
	self maximizePagerPane: aScripter.

	aScripter
		substeps: 'Open the second coder pane'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on class name';
						// GtBehaviorCoderBehaviorNameId ].

			aStep shortcut
				label: 'Spawn class coder';
				combination: BlKeyCombination primaryB;
				// GtBehaviorCoderBehaviorNameId;
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pager with two panes';
						value: [ :aPager | aPager pages size ] equals: [ 2 ] ].

			aStep
				assertStep: [ :s | 
					s
						value: [ :anElement | (anElement query // GtPagerPageElementId) result size ]
							equals: [ 2 ] ] ].

	^ aScripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> doubleClickInClassHierarchy [
	<gtExample>
	| scripter |
	scripter := self
			coderInPager: [ GtCoderElement forClass: SequenceableCollection ].
	scripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 2400 @ 1000 ];
				onSpace ].
	self maximizePagerPane: scripter.
	scripter
		clickStep: [ :s | 
			s
				label: 'Switch to class hierarchy';
				// #Sidebar;
				// BrTab;
				@ [ :each | each label asString = 'Class Hierarchy' ] ].
	self isClass: SequenceableCollection selectedIn: scripter.
	scripter
		doubleClickStep: [ :s | 
			s
				label: 'Double click ArrayedCollection';
				// GtCoderNavigationClassesTreeElementId;
				// BrLabel;
				@ [ :each | each text asString = 'ArrayedCollection' ] ].
	self isClass: ArrayedCollection selectedIn: scripter.
	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> doubleClickInClasses [
	<gtExample>
	| scripter |
	scripter := self
			coderInPager: [ GtCoderElement forClass: SequenceableCollection ].
	scripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 2400 @ 1000 ];
				onSpace ].
	self maximizePagerPane: scripter.
	self isClass: SequenceableCollection selectedIn: scripter.
	scripter
		doubleClickStep: [ :s | 
			s
				label: 'Double click ArrayedCollection';
				// GtCoderNavigationClassesTreeElementId;
				// BrLabel;
				@ [ :each | each text asString = 'ArrayedCollection' ] ].
	self isClass: ArrayedCollection selectedIn: scripter.
	^ scripter
]

{ #category : #'examples - scrolling' }
GtPharoCoderByScripterExamples >> editAndScrollToEndOfVeryLongMethod [
	"Related to https://github.com/feenkcom/gtoolkit/issues/4267"

	<gtExample>
	| aScripter |
	aScripter := self coderWithVeryLongMethod.

	aScripter methodsCoder
		forCompiledMethod: self veryLongMethod
			do: [ :aMethodCoder | 
				aMethodCoder do
					label: 'Insert empty lines';
					block: [ :anEditor | 
						anEditor navigator
							moveTo: 79;
							apply.
						anEditor inserter
							atCursor;
							text: (String
									streamContents: [ :aStream | 7 timesRepeat: [ aStream nextPutAll: OSPlatform current lineEnding ] ]);
							insert ];
					onParentStepTarget: aMethodCoder;
					// GtSourceCoderEditorId.

				aMethodCoder editor
					// GtSourceCoderEditorId;
					assertFullyVisibleParagraphAt: #first
						hasText: self veryLongMethodFirstLineString;
					assertFullyVisibleParagraphAt: #last
						hasNotText: self veryLongMethodLastLineString.
					
				aMethodCoder mouseWheel
					downBy: 30;
					onParentStepTarget: aMethodCoder;
					// GtSourceCoderEditorId.
					
				aMethodCoder mouseWheel
					downBy: 10;
					onParentStepTarget: aMethodCoder;
					// GtSourceCoderEditorId.
					
				aMethodCoder editor
					// GtSourceCoderEditorId;
					assertFullyVisibleParagraphAt: #first
						hasNotText: self veryLongMethodFirstLineString;
					assertFullyVisibleParagraphAt: #last
						hasText: self veryLongMethodLastLineString.

				aMethodCoder assert
					label: 'Assert visible toolbar';
					do: [ :aCoderElement | 
						| aQuery aToolbar |
						aQuery := aCoderElement query // #actions.
						self
							assert: aQuery isEmpty not
							description: [ 'Actions toolbar must exists' ].
						self assert: aQuery result size equals: 1.
						aToolbar := aQuery anyOne.
						self
							assert: aToolbar isVisibleInSpace
							description: ('Actions must be visible in space: {1}' format: {aToolbar}).
						aToolbar
							allParentsDo: [ :aParent | 
								self
									assert: (aToolbar isVisibleFullyInParent: aParent)
									description: ('Actions `{1}` must be visible in parent `{2}`'
											format: {aToolbar.
													aParent}) ] ];
					onParentStepTarget: aMethodCoder;
					// GtSourceCoderExpandedContentElement ];
		assertNumberOfVisibleMethodsIsExactly: 3;
		assertScrollableDo: [ :aScrollable | 
			self
				assert: aScrollable children first textualCoderViewModel compiledMethod
				equals: GtPharoDummyFiveObject >> #veryLongMethod.
			self
				assert: aScrollable children second textualCoderViewModel compiledMethod
				equals: GtPharoDummyFiveObject >> #yetAnotherLongMethod.
			self
				assert: aScrollable children third textualCoderViewModel compiledMethod
				equals: GtPharoDummyFiveObject class>>#sum21Reference ];
		// GtPharoStreamingMethodsCoderElement;
		play.

	^ aScripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> extractSuperclassInIndex [
	<gtExample>
	<after: #cleanUp>
	| rootClass class scripter step className |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2.
	rootClass := environment anyDummyLeafClass.
	class := rootClass realClass.
	className := class name.
	scripter := self coderInPager: [ GtCoderElement forClass: class ].
	self maximizePagerPane: scripter.
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open class menu';
				// GtCoderClassesTreeItemElement;
				@ [ :each | each theClass = class ] ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Has extract superclass menu item';
				exists;
				onSpaceRoot;
				// #'menu--list';
				// #'menu--label';
				@ [ :each | each text asString = ('Extract superclass ' , className) ] ].

	step := scripter menuStep.
	step label: 'Hover extract superclass'.
	step hoverMenuItem
		onSpaceRoot;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = ('Extract superclass ' , className) ].
	step play.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check rename editor is visible';
				onSpaceRoot;
				exists;
				// #refactoringEditor ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Click in rename editor';
				onSpaceRoot;
				// #refactoringEditor ].


	scripter
		checkStep: [ :s | 
			s
				label: 'Check editor has focus';
				onSpaceRoot;
				// #refactoringEditor;
				hasFocus ].

	scripter
		keyPressStep: [ :s | 
			s
				label: 'Move to end';
				key: BlKeyboardKey end ].
	scripter
		typeStep: [ :s | 
			s
				label: 'Enter new class name';
				text: '1234' ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Refactoring preview does not exists';
				notExists;
				// #preview;
				@ [ :each | each isKindOf: GtRefactoringsPreviewButton ] ].
				
	scripter
		keyPressStep: [ :s | 
			s
				label: 'Open refactoring preview';
				key: BlKeyboardKey return ].

	(Delay forMilliseconds: 100) wait.	"Wait for preview to appear"
	scripter pulse.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button exists';
				exists;
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].

	^ scripter
]

{ #category : #'examples - evaluation context' }
GtPharoCoderByScripterExamples >> instanceSideMethodsExpandsInstanceSideMethods [
	"Accompanying example for https://github.com/feenkcom/gtoolkit/issues/4127"

	<gtExample>
	| aScripter anInstanceSideMethod aReferencedMethod aClassSideMethod |
	aScripter := self coderWithDummyTwoObjectInstanceInPager.
	anInstanceSideMethod := GtPharoDummyTwoObject >> #sum21Reference.
	aClassSideMethod := GtPharoDummyTwoObject class >> #sum21Reference.
	aReferencedMethod := GtPharoDummyOneObject >> #sum21.

	aScripter pager
		setPageAt: 1 widthInSpaceRatio: 1.0;
		play.

	aScripter methodsCoder
		// GtPharoStreamingMethodsCoderElement;
		expandAndFocusCompiledMethod: anInstanceSideMethod;
		scrollToCompiledMethod: anInstanceSideMethod;
		forCompiledMethod: anInstanceSideMethod
			do: [ :aMethodCoder | 
				aMethodCoder
					clickOnMethodCoderExpander: 1
					insideDo: [ :aStep1 | aStep1 assertCompiledMethodIs: aReferencedMethod ] ];
		scrollToCompiledMethod: aClassSideMethod;
		play.

	^ aScripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> isClass: class selectedIn: scripter [
	scripter
		checkStep: [ :s | 
			s
				label: 'Check ' , class name , ' is selected';
				exists;
				// GtCoderClassesTreeElement;
				@ [ :each | each selectedClass = class ] ]
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> isPackageNamed: aString selectedIn: scripter [
	scripter
		checkStep: [ :s | 
			s
				label: 'Check package (' , aString , ') is selected';
				// GtCoderPackagesTreeElement;
				@ [ :each | each selectedPackage name = aString asSymbol ] ]
]

{ #category : #'examples - support' }
GtPharoCoderByScripterExamples >> maximizePagerPane: aScripter [
	<gtExample>
	aScripter
		clickStep: [ :s | 
			s
				label: 'Maximize Coder';
				// GtPagerMaximizeButtonElementId ]
]

{ #category : #'examples - coder' }
GtPharoCoderByScripterExamples >> methodsCoderOnClassMethodSpawn [
	<gtExample>
	| aScripter objectToSpawn method events |
	events := OrderedCollection new.
	method := Object class >> #initialize.
	aScripter := self
			scripterForBlock: [ GtPharoStreamingMethodsCoderElement new
					streamingCodersViewModel: (GtPharoStreamingMethodsCoderViewModel new
							streamingCodersModel: (GtPharoStreamingMethodsCoder
									forFilter: #initialize gtImplementors & Object class gtMethodsInClass)) ].

	aScripter element
		when: GtPhlowObjectToSpawn
		do: [ :event | 
			events add: event.
			objectToSpawn := event object ].

	"For some reason we need to wait to propagate search filter changes.
	Is there any background computation that the UI is not aware of?"
	aScripter wait forEnqueuedSpaceTaskTimeout: 1 second; play.
	aScripter wait forEmptySpaceTaskQueueTimeout: 1 second; play.
			
	aScripter click
		// GtPharoHeaderProviderBehaviorId;
		play.

	self assert: events size equals: 1.
	self assert: objectToSpawn equals: method.

	^ aScripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> removeClassInIndex [
	<gtExample>
	<after: #cleanUp>
	| rootClass class scripter step className |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	rootClass := environment anyDummyLeafClass.
	class := rootClass realClass.
	className := class name.
	scripter := self coderInPager: [ GtCoderElement forClass: class ].
	self maximizePagerPane: scripter.
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open class menu';
				// GtCoderClassesTreeItemElement;
				@ [ :each | each theClass = class ] ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Has remove class menu item';
				exists;
				onSpaceRoot;
				// #'menu--list';
				// #'menu--label';
				@ [ :each | each text asString = ('Remove class ' , className) ] ].

	step := scripter menuStep.
	step label: 'Hover remove class'.
	step hoverMenuItem
		onSpaceRoot;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = ('Remove class ' , className) ].
	step play.

	scripter
		checkStep: [ :s | 
			s
				label: 'Has remove class button';
				exists;
				onSpaceRoot;
				// BrMenuSteppedElement;
				// #removeButton ].
	self assert: (Smalltalk includesKey: className) equals: true.

	scripter
		clickStep: [ :s | 
			s
				label: 'Remove class';
				onSpaceRoot;
				// BrMenuSteppedElement;
				// #removeButton ].
	(Delay forMilliseconds: 500) wait.
	scripter pulse.

	self assert: (Smalltalk includesKey: className) equals: false.

	scripter
		checkStep: [ :s | 
			s
				label: 'Has removed context menu';
				notExists;
				onSpaceRoot;
				// #'menu--list' ].

	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> removePackageInIndex [
	<gtExample>
	<after: #cleanUp>
	| scripter package packageName step |
	scripter := self setupForPackageTests.
	package := environment anyDummyPackage realPackage.
	packageName := package name.
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open package menu';
				// GtCoderPackagesTreeItemElement;
				@ [ :each | each packageOrTag = package ] ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Has remove package menu item';
				exists;
				onSpaceRoot;
				// #'menu--list';
				// #'menu--label';
				@ [ :each | each text asString = ('Remove package ' , packageName) ] ].

	step := scripter menuStep.
	step label: 'Hover remove package'.
	step hoverMenuItem
		onSpaceRoot;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = ('Remove package ' , packageName) ].
	step play.

	scripter
		checkStep: [ :s | 
			s
				label: 'Has remove package button';
				exists;
				onSpaceRoot;
				// BrMenuSteppedElement;
				// #removeButton ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Remove package';
				onSpaceRoot;
				// BrMenuSteppedElement;
				// #removeButton ].
	(Delay forMilliseconds: 500) wait.
	scripter pulse.

	self
		assert: (RPackageOrganizer default includesPackageNamed: packageName)
		equals: false.

	scripter
		checkStep: [ :s | 
			s
				label: 'Has removed context menu';
				notExists;
				onSpaceRoot;
				// #'menu--list' ].

	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> removeSelectorInIndex [
	<gtExample>
	<after: #cleanUp>
	| method scripter step |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	method := environment anyDummyUnaryMethod realMethod.
	scripter := self coderInPager: [ GtCoderElement forMethod: method ].
	self maximizePagerPane: scripter.
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open selector menu';
				// GtCoderMethodsGroupedListElement;
				// BrLabel;
				@ [ :each | each text asString = method selector asString ] ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Has remove method menu item';
				exists;
				onSpaceRoot;
				// #'menu--list';
				// #'menu--label';
				@ [ :each | each text asString = ('Remove method ' , method selector) ] ].

	step := scripter menuStep.
	step label: 'Hover remove method'.
	step hoverMenuItem
		onSpaceRoot;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = ('Remove method ' , method selector) ].
	step play.

	scripter
		checkStep: [ :s | 
			s
				label: 'Has remove method button';
				exists;
				onSpaceRoot;
				// BrMenuSteppedElement;
				// #removeButton ].
	self assert: method isInstalled equals: true.

	scripter
		clickStep: [ :s | 
			s
				label: 'Remove method';
				onSpaceRoot;
				// BrMenuSteppedElement;
				// #removeButton ].
	(Delay forMilliseconds: 500) wait.
	scripter pulse.

	self assert: method isInstalled equals: false.

	scripter
		checkStep: [ :s | 
			s
				label: 'Has removed context menu';
				notExists;
				onSpaceRoot;
				// #'menu--list' ].

	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> renameClassInIndex [
	<gtExample>
	<after: #cleanUp>
	| scripter |
	scripter := self startRenamingClassInIndex.
	scripter
		keyPressStep: [ :s | 
			s
				label: 'Open refactoring preview';
				key: BlKeyboardKey return ].

	(Delay forMilliseconds: 100) wait.	"Wait for preview to appear"
	scripter pulse.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button exists';
				exists;
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Perform refactoring';
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].
	(Delay forMilliseconds: 500) wait.
	scripter pulse.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check refactoring apply button does not exists';
				onSpaceRoot;
				notExists;
				id: GtRefactoringsPreviewAcceptId ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check editor is removed';
				notExists;
				onSpaceRoot;
				id: #renameClassEditor ].
	self
		checkClassListIn: scripter
		containsName: environment anyDummyLeafClass realClass name
		exists: true.
	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> renamePackageInIndex [
	<gtExample>
	<after: #cleanUp>
	| scripter package step packageName |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	package := environment anyDummyPackage realPackage.
	packageName := package name.
	scripter := self coderInPager: [ GtCoderElement forPackage: package ].
	scripter
		doStep: [ :s1 | 
			s1
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 2400 @ 1000 ];
				onSpace ].
	self maximizePagerPane: scripter.
	self checkPackageListIn: scripter containsName: packageName.
	scripter
		secondaryClickStep: [ :s1 | 
			s1
				label: 'Open package menu';
				// GtCoderPackagesTreeElement;
				// BrLabel;
				@ [ :each | each text asString = packageName ] ].

	step := scripter menuStep.
	step label: 'Hover rename package'.
	step hoverMenuItem
		onSpaceRoot;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = ('Rename package ' , packageName) ].
	step play.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check rename editor is visible';
				onSpaceRoot;
				exists;
				// #refactoringEditor ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Click in rename editor';
				onSpaceRoot;
				// #refactoringEditor ].


	scripter
		checkStep: [ :s | 
			s
				label: 'Check editor has focus';
				onSpaceRoot;
				// #refactoringEditor;
				hasFocus ].
	scripter
		keyPressStep: [ :s | 
			s
				label: 'Move to end';
				key: BlKeyboardKey end ].
	scripter
		typeStep: [ :s | 
			s
				label: 'Enter new package name';
				text: '1234' ].

	scripter
		keyPressStep: [ :s | 
			s
				label: 'Show refactoring preview';
				key: BlKeyboardKey return ].

	(Delay forMilliseconds: 100) wait.	"Wait for preview to appear"
	scripter pulse.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button exists';
				exists;
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Perform refactoring';
				onSpaceRoot;
				id: GtRefactoringsPreviewAcceptId ].

	(Delay forMilliseconds: 300) wait.
	scripter pulse.
	
	scripter
		checkStep: [ :s | 
			s
				label: 'Check refactoring apply button does not exists';
				onSpaceRoot;
				notExists;
				id: GtRefactoringsPreviewAcceptId ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check editor is removed';
				notExists;
				id: #renameClassEditor ].
	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> repackageClassUpdatesIndex [
	<gtExample>
	<after: #cleanUp>
	| scripter cls package newPackage packages |
	scripter := self setupForPackageTests.
	packages := environment dummyPackages
			asSortedCollection: [ :a :b | a packageName < b packageName ].
	package := packages first.
	newPackage := packages second.
	cls := package anyDummyClass.
	scripter
		clickStep: [ :s | 
			s
				label: 'Expand class definition';
				id: GtSourceCoderExpanderToggleId ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Activate package editor';
				id: #package ].
	scripter
		typeStep: [ :s | 
			s
				label: 'Enter new package name';
				text: newPackage packageName ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Save changes';
				id: (GtMagritteActionElementId new
						description: (MAActionDescription new label: 'Create')) ].
	self isPackageNamed: newPackage packageName selectedIn: scripter.


	cls realClass category: package packageName.	"Updating outside of coder, also should update"
	scripter pulse.
	self isPackageNamed: package packageName selectedIn: scripter.

	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> repackageNonSelectedClassInPackageUpdatesIndex [
	<gtExample>
	<after: #cleanUp>
	| scripter cls package newPackage packages |
	scripter := self setupForPackageTests.
	packages := environment dummyPackages
			asSortedCollection: [ :a :b | a packageName < b packageName ].
	package := packages first.
	newPackage := packages second.
	cls := package dummyClasses detect: [ :each | each ~~ package anyDummyClass ].


	cls realClass category: newPackage packageName.	"Changing non-selected class doesn't change package"
	scripter pulse.
	self isPackageNamed: package packageName selectedIn: scripter.
	scripter
		checkStep: [ :s | 
			s
				label: 'Class list should contain ' , package anyDummyClass className;
				// GtCoderClassesTreeElement;
				@ [ :each | each containsClass: package anyDummyClass realClass ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Class list should not contain ' , cls className;
				// GtCoderClassesTreeElement;
				@ [ :each | (each containsClass: cls realClass) not ] ].

	^ scripter
]

{ #category : #'examples - refactoring' }
GtPharoCoderByScripterExamples >> sampleMethodForRefactoringExample [
	| value stream |
	value := 15.
	stream := WriteStream on: String new.
	stream nextPutAll: (value printStringBase: 16 nDigits: 2) , ' = ''0F'''.
	^ stream contents
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> selectClassInCoderUpdatesIndex [
	<gtExample>
	| scripter |
	scripter := self coderInPager: [ GtCoderElement new ].
	scripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 1400 @ 1000 ];
				onSpace ].
	self maximizePagerPane: scripter.
	scripter
		checkStep: [ :s | 
			s
				label: 'No package is selected';
				// GtCoderPackagesTreeElement;
				@ [ :each | each selectedPackage isNil ] ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Select a package';
				onBreadthFirstChildOfClass: GtPackagesCoderElement;
				// #coder;
				// #scrollable;
				onChildAt: 1 ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Package is selected';
				// GtCoderPackagesTreeElement;
				@ [ :each | each selectedPackage notNil ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Class list not empty';
				// GtCoderClassesTreeElement;
				// #scrollable;
				@ [ :each | each children notEmpty ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Class is not selected';
				// GtCoderClassesTreeElement;
				@ [ :each | each selectedClass isNil ] ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Select a class';
				onBreadthFirstChildOfClass: GtClassCardElement ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Class is selected';
				// GtCoderClassesTreeElement;
				@ [ :each | each selectedClass notNil ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Class is selected';
				// GtCoderClassesTreeElement;
				@ [ :each | each selectedClass notNil ] ].
	^ scripter
]

{ #category : #'examples - support' }
GtPharoCoderByScripterExamples >> setSpace800x600Extent: aScripter [
	<gtExample>
	aScripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 800 @ 600 ];
				onSpace ]
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> setupForPackageTests [
	| scripter class cls package packages |
	environment := GtPharoDummiesGenerator withPackages: 2 classHierarchy: 2.
	packages := environment dummyPackages
			asSortedCollection: [ :a :b | a packageName < b packageName ].
	package := packages first.
	cls := package anyDummyClass.
	class := cls realClass.
	scripter := self coderInPager: [ GtCoderElement forClass: class ].
	scripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 1400 @ 1000 ];
				onSpace ].
	self maximizePagerPane: scripter.
	self isPackageNamed: package packageName selectedIn: scripter.
	^ scripter
]

{ #category : #'examples - index' }
GtPharoCoderByScripterExamples >> startRenamingClassInIndex [
	<gtExample>
	<after: #cleanUp>
	| scripter class rootClass step |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	rootClass := environment anyDummyLeafClass.
	class := rootClass realClass.
	scripter := self coderInPager: [ GtCoderElement forClass: class ].
	scripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 2400 @ 1000 ];
				onSpace ].
	self maximizePagerPane: scripter.
	self
		checkClassListIn: scripter
		containsName: class name
		exists: true.
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open class menu';
				// GtCoderNavigationClassesTreeElementId;
				// BrLabel;
				@ [ :each | each text asString = class name ] ].

	step := scripter menuStep.
	step label: 'Hover rename class'.
	step hoverMenuItem
		onSpaceRoot;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = ('Rename class ' , class name) ].
	step play.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check rename editor is visible';
				onSpaceRoot;
				exists;
				// #refactoringEditor ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Click in rename editor';
				onSpaceRoot;
				// #refactoringEditor ].


	scripter
		checkStep: [ :s | 
			s
				label: 'Check editor has focus';
				onSpaceRoot;
				// #refactoringEditor;
				hasFocus ].

	scripter
		keyPressStep: [ :s | 
			s
				label: 'Move to end';
				key: BlKeyboardKey end ].
	scripter
		typeStep: [ :s | 
			s
				label: 'Enter new class name';
				text: '1234' ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Refactoring preview does not exists';
				notExists;
				// #preview;
				@ [ :each | each isKindOf: GtRefactoringsPreviewButton ] ].
	^ scripter
]

{ #category : #accessing }
GtPharoCoderByScripterExamples >> undoRedoRemoveClass [
	<gtExample>
	<after: #cleanUp>
	| rootClass coder class className selectors classSelectors |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	rootClass := environment anyDummyLeafClass.
	class := rootClass realClass.
	selectors := class selectors asSortedCollection asArray.
	classSelectors := class class selectors asSortedCollection asArray.
	className := rootClass realClass name.
	coder := GtCoderElement forClass: rootClass realClass.
	self assert: (Smalltalk includesKey: className).
	coder
		allChildrenBreadthFirstDetect: [ :each | each isKindOf: GtPharoBehaviorCoderElement ]
		ifFound: [ :elmt | elmt coderViewModel coder removeClass ]
		ifNone: [ self error: 'Could not find element' ].
	self assert: (Smalltalk includesKey: className) not.
	GtRefactoryChangeManager instance undoChange.
	self assert: (Smalltalk includesKey: className).
	self
		assert: (Smalltalk at: className) selectors asSortedCollection asArray = selectors.
	self
		assert: (Smalltalk at: className) class selectors asSortedCollection asArray
				= classSelectors.
	GtRefactoryChangeManager instance redoChange.
	self assert: (Smalltalk includesKey: className) not.
	^ coder
]

{ #category : #accessing }
GtPharoCoderByScripterExamples >> undoRedoRemoveClassInIndex [
	"Remove class button is occluded by other buttons. To fix this example
	we will need to implement a smart action bar that collapses buttons under a hamburger menu when there is no enough space"
	<gtExample>
	<noTest>
	<after: #cleanUp>
	| scripter rootClass class className selectors classSelectors |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	rootClass := environment anyDummyLeafClass.
	class := rootClass realClass.
	selectors := class selectors asSortedCollection asArray.
	classSelectors := class class selectors asSortedCollection asArray.
	className := rootClass realClass name.
	scripter := self
			scripterForBlock: [ GtCoderElement forClass: rootClass realClass ].
	scripter
		doStep: [ :s | 
			s
				label: 'Show sidebar';
				action: [ :el | el showSidebar ] ].
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Pick remove class';
				id: GtCoderNavigationClassesTreeElementId ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Click remove class';
				onSpaceRoot;
				// [ :each | 
					(each isKindOf: BrLabel)
						and: [ (each text asString beginsWith: 'Remove class')
								and: [ each
										allParentsDetect: [ :p | p isKindOf: GtCoderNavigationContextMenuContent ]
										ifFound: [ :p | true ]
										ifNone: [ false ] ] ] ] ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Click remove preview';
				// [ :each | 
					(each isKindOf: GtPreviewChangeButton)
						and: [ each
								allParentsDetect: [ :p | p isKindOf: GtCoderClassesTreeElement ]
								ifFound: [ :p | true ]
								ifNone: [ false ] ] ] ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Remove class';
				onSpaceRoot;
				id: #'change-button-action' ].
	scripter
		doStep: [ :s | 
			s
				label: 'Undo & Redo';
				action: [ :el | 
					self assert: (Smalltalk includesKey: className) not.
					GtRefactoryChangeManager instance undoChange.
					self assert: (Smalltalk includesKey: className).
					self
						assert: (Smalltalk at: className) selectors asSortedCollection asArray = selectors.
					self
						assert: (Smalltalk at: className) class selectors asSortedCollection asArray
								= classSelectors.
					GtRefactoryChangeManager instance redoChange.
					self assert: (Smalltalk includesKey: className) not ] ].
	^ scripter
]

{ #category : #'examples - scrolling' }
GtPharoCoderByScripterExamples >> veryLongMethod [
	<gtExample>
	^ GtPharoDummyFiveObject >> #veryLongMethod
]

{ #category : #'examples - scrolling' }
GtPharoCoderByScripterExamples >> veryLongMethodFirstLineString [
	<gtExample>
	| aLine |
	aLine := self veryLongMethod sourceCode lines first.
	self assert: (aLine includesSubstring: self veryLongMethod selector asString).
	^ aLine
]

{ #category : #'examples - scrolling' }
GtPharoCoderByScripterExamples >> veryLongMethodLastLineString [
	<gtExample>
	| aLine |
	aLine := self veryLongMethod sourceCode lines last.
	self assert: (aLine includesSubstring: '^').
	^ aLine
]
