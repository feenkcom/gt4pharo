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
				/ BrAnchoredOuterContainer;
				// GtPharoSideTagId;
				onTopMost ].
				
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the instance-side button';
				onSpaceRoot;
				/ BrAnchoredOuterContainer;
				/ BrAnchoredElement;
				/ #content;
				/ BrButton ].

	aScripter methodCoder
		onSpaceRoot;
		/ BrAnchoredOuterContainer;
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
				// BrAnchoredOuterContainer;
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
				// BrAnchoredOuterContainer;
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
				/ BrAnchoredOuterContainer;
				// GtPharoSideTagId;
				onTopMost ].
				
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the class-side button';
				onSpaceRoot;
				/ BrAnchoredOuterContainer;
				/ BrAnchoredElement;
				/ #content;
				/ BrButton ].

	aScripter methodCoder
		onSpaceRoot;
		/ BrAnchoredOuterContainer;
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
		/ BrAnchoredOuterContainer;
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
		doStep: [ :s | 
			s
				label: 'Setup dropdown overview';
				block: [ :aButton :aUserData | 
					aUserData
						at: BrAnchoredVisualAnalysis
						put: (BrAnchoredVisualAnalysis new elementWithDropdown: aButton) ];
				// (GtPagerPageElementId indexed: 2);
				// GtPharoBehaviorCoderElement;
				// BrTabGroup;
				// GtPharoSearchCodeButtonId ].

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
GtPharoCoderByScripterExamples >> closeContextMenuPressingExcapeKey [
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
GtPharoCoderByScripterExamples >> closeSidebarContextMenuPressingExcapeKey [
	<gtExample>
	| aScripter |
	aScripter := self displayClassSidebarContextMenu.

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				// GtCoderNavigationContextMenuContent;
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
GtPharoCoderByScripterExamples >> closeSidebarContextMenuPressingExcapeKey_firstClickInsideOfMethodCoder [
	<gtExample>
	| aScripter |
	aScripter := self displayClassSidebarContextMenu_firstClickInsideOfMethodCoder.

	aScripter
		assertStep: [ :s | 
			s
				onSpaceRoot;
				// GtCoderNavigationContextMenuContent;
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

{ #category : #'exaples - add new method' }
GtPharoCoderByScripterExamples >> displayAddMethodDropdown [
	"See [](https://github.com/feenkcom/gtoolkit/issues/3233)"

	<gtExample>
	| aScripter aScrollSpotterBy |
	aScripter := self displayThreeClassCodersWithMethodExpanded.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on the add new method button';
				// (GtPagerPageElementId indexed: 2);
				// GtPharoAddNewMethodButtonId ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Right-side button distace';
				block: [ :aButton | 
					| aButtonBounds aSpaceBounds aDistance aPreferredExtent |
					aButtonBounds := aButton bounds inSpace asRectangle.
					aSpaceBounds := aButton space root bounds inSpace asRectangle.
					aDistance := aSpaceBounds right - aButtonBounds left.

					aButton aptitude
						withAllActorsBreadthFirstDo: [ :anAptitude | 
							(anAptitude isKindOf: BrWithAnchoredAptitude)
								ifTrue: [ aPreferredExtent := anAptitude preferredExtent ] ].

					self
						assert: [ aPreferredExtent isNotNil ]
						description: [ '{1} kind of aptitude not found in {2}'
								format: {BrWithAnchoredAptitude.
										aButton} ].

					aScrollSpotterBy := aPreferredExtent - aDistance.
					aScripter userData
						at: #displayAddMethodDropdown_Scroll
						put: aScrollSpotterBy ];
				// (GtPagerPageElementId indexed: 2);
				// GtPharoAddNewMethodButtonId ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Scroll GtPager';
				block: [ :anInfiniteElement | anInfiniteElement smoothScrollBy: aScrollSpotterBy x @ 0 ];
				// #list ].

	aScripter
		doStep: [ :s | 
			s
				label: 'Setup dropdown overview';
				block: [ :aButton :aUserData | 
					aUserData
						at: BrAnchoredVisualAnalysis
						put: (BrAnchoredVisualAnalysis new elementWithDropdown: aButton) ];
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
				// BrAnchoredOuterContainer;
				// BrAnchoredElement;
				/ #content asBlocElementId ].

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
				label: 'Assert context menu extent';
				value: [ :aContentElement | aContentElement extent ]
					equals: [ :aContentElement | 
						| aContextMenuQuery |
						aContextMenuQuery := aContentElement query
								// GtCoderNavigationContextMenuContent.
						self assert: aContextMenuQuery result size equals: 1.
						aContextMenuQuery result first extent ];
				onSpaceRoot;
				// BrAnchoredOuterContainer;
				// BrAnchoredElement;
				/ #content asBlocElementId ]
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

	aScripter
		doStep: [ :s | 
			s
				label: 'Setup dropdown overview';
				block: [ :aButton :aUserData | 
					aUserData
						at: BrAnchoredVisualAnalysis
						put: (BrAnchoredVisualAnalysis new elementWithDropdown: aButton) ];
				// (GtPagerPageElementId indexed: 2);
				// GtPharoBehaviorCoderElement;
				// BrTabGroup;
				// GtPharoSearchCodeButtonId ].

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

	aScripter click
		// GtPharoHeaderProviderBehaviorId;
		play.

	self assert: events size equals: 1.
	self assert: objectToSpawn equals: method.

	^ aScripter
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
