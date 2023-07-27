"
I exemplify {{gtClass:GtCoder}}. 
"
Class {
	#name : #GtPharoCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'exaples - add new method' }
GtPharoCoderByScripterExamples >> addMethodDropdownRemembersItsContent [
	"See [](https://github.com/feenkcom/gtoolkit/issues/3230)"
	
	<gtExample>
	| aScripter |
	aScripter := self displayThreeClassCodersWithMethodExpanded.

	aScripter click 
		label: 'Click on the add new method button';
		// (GtPagerPageElementId indexed: 2);
		// GtPharoAddNewMethodButtonId;
		play.
		
	aScripter type
		text: 'myNewMethod';
		play.
		
	aScripter assert
		label: 'Assert new method source code';
		value: [ :anEditor | anEditor text asString ]
			equals: [ :anEditor | 'myNewMethod' ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// GtSourceCoderEditorId;
		play.
		
	aScripter click
		label: 'Close the dropdown';
		// (GtPagerPageElementId indexed: 2);
		// GtBehaviorCoderBehaviorNameId;
		play.
		
	aScripter click 
		label: 'Reopen the add new method button';
		// (GtPagerPageElementId indexed: 2);
		// GtPharoAddNewMethodButtonId;
		play.
		
	aScripter assert
		label: 'Assert new method source code';
		value: [ :anEditor | anEditor text asString ]
			equals: [ :anEditor | 'myNewMethod' ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// GtSourceCoderEditorId;
		play.
	
	^ aScripter
]

{ #category : #'examples - dropdown' }
GtPharoCoderByScripterExamples >> assertDropdown: aScripter [
	aScripter do
		label: 'Setup dropdown overview';
		block: [ :aButton :aUserData | 
			aUserData
				at: BrAnchoredVisualAnalysis
				put: (BrAnchoredVisualAnalysis new
						elementWithDropdown: aButton) ];
		// (GtPagerPageElementId indexed: 2);
		// GtPharoBehaviorCoderElement;
		// BrTabGroup;
		// GtPharoSearchCodeButtonId;
		play.

	aScripter assert
		label: 'Assert dropdown bounds';
		satisfies: [ :aContentElement | 
			aContentElement topMostParent bounds inSpace asRectangle
				containsRect: aContentElement bounds inSpace asRectangle ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> closeContextMenuPressingExcapeKey [
	<gtExample>
	| aScripter |
	aScripter := self displayPharoMethodContextMenuExtentIn800x600Space.

	aScripter assert
		onSpaceRoot;
		// GtCoderContextMenuContent;
		exists;
		play.

	aScripter shortcut
		combination: BlKeyCombination escape;
		play.

	aScripter assert
		onSpaceRoot;
		// GtCoderContextMenuContent;
		notExists;
		play.

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> closeSidebarContextMenuPressingExcapeKey [
	<gtExample>
	| aScripter |
	aScripter := self displayClassSidebarContextMenu.

	aScripter assert
		onSpaceRoot;
		// GtCoderNavigationContextMenuContent;
		exists;
		play.

	aScripter shortcut
		combination: BlKeyCombination escape;
		play.

	aScripter assert
		onSpaceRoot;
		// GtCoderNavigationContextMenuContent;
		notExists;
		play.

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> closeSidebarContextMenuPressingExcapeKey_firstClickInsideOfMethodCoder [
	<gtExample>
	| aScripter |
	aScripter := self displayClassSidebarContextMenu_firstClickInsideOfMethodCoder.

	aScripter assert
		onSpaceRoot;
		// GtCoderNavigationContextMenuContent;
		exists;
		play.

	aScripter shortcut
		combination: BlKeyCombination escape;
		play.

	aScripter assert
		onSpaceRoot;
		// GtCoderNavigationContextMenuContent;
		notExists;
		play.

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

	aScripter assert
		label: 'Assert one page';
		satisfies: [ :aPager | aPager pages size = 1 ];
		onSelf;
		play.

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
			aStep click
				// GtPharoBehaviorCoderElement;
				// GtCoderToolbarElement;
				// GtPharoCopyClassElementId;
				play ].

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
			aStep click
				// GtPharoBehaviorCoderElement;
				// GtCoderToolbarElement;
				// GtCoderGitButtonId;
				play.

			aStep assert
				label: 'Assert two pages';
				satisfies: [ :aPager | aPager pages size = 2 ];
				onSelf;
				play ].

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
			aStep click
				// GtPharoBehaviorCoderElement;
				// GtCoderToolbarElement;
				// GtCoderClassHierarchyButtonId;
				play ].

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
			aStep click
				// (GtPagerPageElementId indexed: 2);
				// GtPagerMaximizeButtonElementId;
				play.
				
			aStep assert
				label: 'Assert sidebar is rendered';
				satisfies: #hasChildren;
				// GtPagerMaximizedPageElementId;
				// GtPagerToolWrapperElementId;
				id: #sidebar;
				play ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtPharoCoderByScripterExamples >> coderWithAddMethod [
	<gtExample>
	^ self coderInPager: [ GtCoderElement forMethod: GtPharoDummyClass >> #addDummyClassMethods: ]
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coder_clickOnHierarchiesButton [
	<gtExample>
	| aScripter |
	aScripter := self coder.

	aScripter
		substeps: 'Show Hierarchies'
		do: [ :aStep | 
			aStep click
				// GtPharoBehaviorCoderElement;
				// GtCoderToolbarElement;
				// GtCoderClassHierarchyButtonId;
				play ].

	^ aScripter
]

{ #category : #'exaples - add new method' }
GtPharoCoderByScripterExamples >> displayAddMethodDropdown [
	"See [](https://github.com/feenkcom/gtoolkit/issues/3233)"

	<gtExample>
	| aScripter aScrollSpotterBy |
	aScripter := self displayThreeClassCodersWithMethodExpanded.

	aScripter click 
		label: 'Click on the add new method button';
		// (GtPagerPageElementId indexed: 2);
		// GtPharoAddNewMethodButtonId;
		play.
		
	aScripter do 
		label: 'Right-side button distace';
		block: [ :aButton | 
			| aButtonBounds aSpaceBounds aDistance aPreferredExtent |
			aButtonBounds := aButton bounds inSpace asRectangle.
			aSpaceBounds := aButton space root bounds inSpace asRectangle.
			aDistance := aSpaceBounds right - aButtonBounds left.
			
			aButton aptitude withAllActorsBreadthFirstDo: [ :anAptitude | 
				(anAptitude isKindOf: BrWithAnchoredAptitude) ifTrue: [ 
					aPreferredExtent := anAptitude preferredExtent ] ].
				
			self 
				assert: [ aPreferredExtent isNotNil ] 
				description: [ '{1} kind of aptitude not found in {2}' 
					format: { BrWithAnchoredAptitude. aButton } ].
					
			aScrollSpotterBy := aPreferredExtent - aDistance.
			aScripter userData 
				at: #displayAddMethodDropdown_Scroll
				put: aScrollSpotterBy
			 ];
		// (GtPagerPageElementId indexed: 2);
		// GtPharoAddNewMethodButtonId;
		play.
		
	aScripter do 
		label: 'Scroll GtPager';
		block: [ :anInfiniteElement | 
			anInfiniteElement smoothScrollBy: aScrollSpotterBy x @ 0 ];
		// #list;
		play.
		
	aScripter do
		label: 'Setup dropdown overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithDropdown: aButton) ];
		// (GtPagerPageElementId indexed: 2);
		// GtPharoAddNewMethodButtonId;
		play.
		
	aScripter assert
		label: 'Assert dropdown bounds';
		satisfies: [ :aContentElement | 
			aContentElement topMostParent bounds inSpace asRectangle
				containsRect: aContentElement bounds inSpace asRectangle ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play.
	
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
	aScripter secondaryClick
		label: 'Display context menu';
		// GtCoderNavigationClassesHierarchyTreeElement;
		// (GtCoderNavigationClassesHierarchyTreeElementId indexed: 1);
		play.

	aScripter assert
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
		/ #content asBlocElementId;
		play
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayClassSidebarContextMenu_firstClickInsideOfMethodCoder [
	<gtExample>
	| aScripter |
	aScripter := self displayMaximizedCoderWithMethodExpanded.
	
	aScripter click
		label: 'Click inside of a method coder';
		onSpaceRoot;
		// GtPharoStreamingMethodsCoderElement;
		// (GtSourceCoderId indexed: 1);
		// GtSourceCoderEditorId;
		onChildAt: 1;
		play.
	
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
	
	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 800 @ 300 ];
		onSpace;
		play.

	self maximizePagerPane: aScripter.

	aScripter secondaryClick
		label: 'Display context menu';
		onSpaceRoot;
		// GtPharoStreamingMethodsCoderElement;
		// (GtSourceCoderId indexed: 1);
		// GtSourceCoderEditorId;
		onChildAt: 1;
		play.

	aScripter assert
		label: 'Assert context menu extent';
		value: [ :aContentElement | aContentElement extent ]
			equals: [ :aContentElement | 
				| aContextMenuQuery |
				aContextMenuQuery := aContentElement query // GtCoderContextMenuContent.
				self assert: aContextMenuQuery result size equals: 1.
				aContextMenuQuery result first extent ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play.

	^ aScripter
]

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayPharoMethodContextMenuExtentIn800x600Space [
	<gtExample>
	| aScripter |
	aScripter := self displayMaximizedCoderWithMethodExpanded.
	
	aScripter secondaryClick
		label: 'Display context menu';
		onSpaceRoot;
		// GtPharoStreamingMethodsCoderElement;
		// (GtSourceCoderId indexed: 1);
		// GtSourceCoderEditorId;
		onChildAt: 1;
		play.

	aScripter assert
		label: 'Assert context menu extent';
		value: [ :aContentElement | aContentElement extent ]
			equals: [ :aContentElement | 
				| aContextMenuQuery |
				aContextMenuQuery := aContentElement query // GtCoderContextMenuContent.
				self assert: aContextMenuQuery result size equals: 1.
				aContextMenuQuery result first extent ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play.

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
	
	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 1000 @ 600 ];
		onSpace;
		play.
	
	aScripter click 
		label: 'Click on the search code button';
		// (GtPagerPageElementId indexed: 2);
		// GtPharoBehaviorCoderElement;
		// BrTabGroup;
		// GtPharoSearchCodeButtonId;
		play.
		
	aScripter do 
		label: 'Scroll GtPager';
		block: [ :anInfiniteElement | anInfiniteElement smoothScrollBy: -370@0 ];
		// #list;
		play.
		
	aScripter do
		label: 'Setup dropdown overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithDropdown: aButton) ];
		// (GtPagerPageElementId indexed: 2);
		// GtPharoBehaviorCoderElement;
		// BrTabGroup;
		// GtPharoSearchCodeButtonId;
		play.
		
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
	
	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 1000 @ 600 ];
		onSpace;
		play.
		
	aScripter click
		label: 'Click on the search code button';
		// (GtPagerPageElementId indexed: 2);
		// GtPharoBehaviorCoderElement;
		// BrTabGroup;
		// GtPharoSearchCodeButtonId;
		play.
		
	aScripter do
		label: 'Scroll GtPager';
		block: [ :anInfiniteElement | 
			anInfiniteElement smoothScrollBy:  -371 @ 0 ];
		// #list;
		play.
		
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
			aStep click
				label: 'Click on class name';
				id: GtPagerPageElementId index: 2;
				// GtBehaviorCoderBehaviorNameId;
				play.

			aStep shortcut
				label: 'Spawn class coder';
				combination: BlKeyCombination primaryB;
				id: GtPagerPageElementId index: 2;
				// GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert pager with two panes';
				value: [ :aPager | aPager pages size ] equals: [ 3 ];
				play ].

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
			aStep click
				label: 'Click on class name';
				// GtBehaviorCoderBehaviorNameId;
				play.

			aStep shortcut
				label: 'Spawn class coder';
				combination: BlKeyCombination primaryB;
				// GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert pager with two panes';
				value: [ :aPager | aPager pages size ] equals: [ 2 ];
				play.

			aStep assert
				value: [ :anElement | (anElement query // GtPagerPageElementId) result size ]
					equals: [ 2 ];
				play ].

	^ aScripter
]

{ #category : #'examples - support' }
GtPharoCoderByScripterExamples >> maximizePagerPane: aScripter [
	<gtExample>
	aScripter click
		label: 'Maximize Coder';
		// GtPagerMaximizeButtonElementId;
		play
]

{ #category : #'examples - support' }
GtPharoCoderByScripterExamples >> setSpace800x600Extent: aScripter [
	<gtExample>
	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 800 @ 600 ];
		onSpace;
		play
]
