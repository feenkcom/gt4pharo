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
					aContentElement topMostParent bounds inSpace asRectangle
						containsRect: aContentElement bounds inSpace asRectangle ];
				onSpaceRoot;
				// BrAnchoredOuterContainer;
				// BrAnchoredElement;
				/ #content asBlocElementId ]
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
GtPharoCoderByScripterExamples >> displayPharoMethodContextMenuExtentIn800x300Space [
	<gtExample>
	| aScripter |
	aScripter := self coderWithAddMethod.

	aScripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 800 @ 300 ];
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
