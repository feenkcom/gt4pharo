"
I show how to search for the text selected in a coder using the `Search` submenu of the coder context menu.
The menu actions are defined by {{gtClass:GtCoderSelectionSearch}}.

The search for the selection in method source code is enabled by default, but it can be disabled (see {{gtMethod:GtCoderSelectionSearch class>>#isSubstringSearchEnabled}}). The examples do not change that setting: they only check the search in method source code if it is enabled.
"
Class {
	#name : #GtCoderSelectionSearchByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#instVars : [
		'previousSubstringSearchEnabled'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coder - Search'
}

{ #category : #steps }
GtCoderSelectionSearchByScripterExamples >> assertSearchResultsIn: aScripter areFilter: aFilter [
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert the search results are spawned in a second pane';
				value: [ :aPager | aPager pages size ] equals: 2;
				onSelf ].

	aScripter
		assertStep: [ :s | 
			s
				label: ('Assert the second pane shows {1}' format: {aFilter class name});
				value: [ :aToolElement | aToolElement searchFilter ] equals: aFilter;
				onPagerPaneWithIndex: 2;
				// GtPhlowSearchFilterToolElement ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert the search results include the method in the coder';
				satisfies: [ :aToolElement | aToolElement searchFilter includesMethod: self class >> #methodToSearchFrom ];
				onPagerPaneWithIndex: 2;
				// GtPhlowSearchFilterToolElement ]
]

{ #category : #steps }
GtCoderSelectionSearchByScripterExamples >> assertSearchSubmenuItemLabels: anArray in: aScripter [
	"The Search submenu is displayed as a simple list next to the grouped coder context menu"

	aScripter
		assertStep: [ :s | 
			s
				label: ('Assert Search submenu items: {1}' format: {anArray asCommaString});
				value: [ :aSubmenu | 
						((aSubmenu query // #'menu--label') result
							collect: [ :each | each text asString ]) asArray ]
					equals: anArray;
				onMenuContainer;
				// BrMenuItemsListElement ]
]

{ #category : #steps }
GtCoderSelectionSearchByScripterExamples >> clickSearchMenuItem: aLabel in: aScripter [
	aScripter menuStep
		clickMenuItemWithLabel: aLabel;
		onMenuContainer;
		play
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> coderOnMethodWithLiteral [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterInPagerForBlock: [ GtPharoMethodCoder forMethod: self class >> #methodToSearchFrom ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert the coder shows the method with the string literal';
				satisfies: [ :aCoder | aCoder currentSourceString includesSubstring: '''Coder Selection Search''' ];
				onModel ].

	^ aScripter
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> contextMenuWithSelection [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self selectPartOfLiteral.

	self openContextMenuIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check there is a Search menu';
				exists;
				onMenuContainer;
				onMenuItemWithLabel: 'Search' ].

	^ aScripter
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> contextMenuWithWhitespaceSelection [
	"Searching for whitespace makes no sense, so there is no Search menu"

	<gtExample>
	<return: #BlScripter>
	| aScripter aSpacePosition |
	aScripter := self coderOnMethodWithLiteral.	"select the space between ^ and the string literal"
	aSpacePosition := aScripter model currentSourceString
			indexOfSubCollection: '^ '''.
	self
		selectTextFor: aScripter
		from: aSpacePosition
		to: aSpacePosition + 1
		andCheck: ' '.

	self openContextMenuIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the context menu is open';
				exists;
				onMenuContainer ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check there is no Search menu';
				notExists;
				onMenuContainer;
				onMenuItemWithLabel: 'Search' ].

	^ aScripter
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> contextMenuWithoutSelection [
	"Searching makes sense only for a selection, so there is no Search menu without one"

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self coderOnMethodWithLiteral.

	self openContextMenuIn: aScripter.

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the context menu is open';
				exists;
				onMenuContainer ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check there is no Search menu';
				notExists;
				onMenuContainer;
				onMenuItemWithLabel: 'Search' ].

	^ aScripter
]

{ #category : #accessing }
GtCoderSelectionSearchByScripterExamples >> expectedSearchSubmenuItemLabels [
	"The search in method source code is listed only if it is enabled"

	| theLabels |
	theLabels := #('Literals containing (case insensitive) Selection Search' 'Literals containing (case sensitive) Selection Search').

	^ GtCoderSelectionSearch isSubstringSearchEnabled
		ifTrue: [ theLabels , #('Source code containing Selection Search') ]
		ifFalse: [ theLabels ]
]

{ #category : #steps }
GtCoderSelectionSearchByScripterExamples >> hoverSearchMenuIn: aScripter [
	aScripter menuStep
		hoverMenuItemWithLabel: 'Search';
		onMenuContainer;
		play
]

{ #category : #'examples - subject' }
GtCoderSelectionSearchByScripterExamples >> methodToSearchFrom [
	"The coder in the examples shows this method.
	The examples select a part of the string literal below and search for it"

	^ 'Coder Selection Search'
]

{ #category : #steps }
GtCoderSelectionSearchByScripterExamples >> openContextMenuIn: aScripter [
	aScripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open coder context menu';
				id: GtSourceCoderEditorId ]
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> searchLiteralsCaseInsensitive [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self searchSubmenu.

	self
		clickSearchMenuItem: 'Literals containing (case insensitive) Selection Search'
		in: aScripter.

	self
		assertSearchResultsIn: aScripter
		areFilter: 'Selection Search' gtSubstringLiteralMatch.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert the search ignores case';
				value: [ :aToolElement | aToolElement searchFilter caseSensitive ]
					equals: false;
				onPagerPaneWithIndex: 2;
				// GtPhlowSearchFilterToolElement ].

	^ aScripter
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> searchLiteralsCaseSensitive [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self searchSubmenu.

	self
		clickSearchMenuItem: 'Literals containing (case sensitive) Selection Search'
		in: aScripter.

	self
		assertSearchResultsIn: aScripter
		areFilter: 'Selection Search' gtSubstringLiteralCaseSensitiveMatch.	"Filter equality ignores case, so check the case sensitivity explicitly"
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert the search matches case';
				value: [ :aToolElement | aToolElement searchFilter caseSensitive ]
					equals: true;
				onPagerPaneWithIndex: 2;
				// GtPhlowSearchFilterToolElement ].

	^ aScripter
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> searchSourceCode [
	"The search in method source code is enabled by default, but it can be disabled
	as it can be slow in large images. There is nothing to search for when it is disabled"

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self searchSubmenu.
	GtCoderSelectionSearch isSubstringSearchEnabled ifFalse: [ ^ aScripter ].

	self
		clickSearchMenuItem: 'Source code containing Selection Search'
		in: aScripter.

	self
		assertSearchResultsIn: aScripter
		areFilter: 'Selection Search' gtSubstringMatch.

	^ aScripter
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> searchSubmenu [
	"The Search submenu offers the literal searches and, if enabled, the search in method source code.
	Each item shows the selected text next to its label"

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self contextMenuWithSelection.

	self hoverSearchMenuIn: aScripter.

	self
		assertSearchSubmenuItemLabels: self expectedSearchSubmenuItemLabels
		in: aScripter.

	^ aScripter
]

{ #category : #examples }
GtCoderSelectionSearchByScripterExamples >> selectPartOfLiteral [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self coderOnMethodWithLiteral.

	self selectText: 'Selection Search' in: aScripter.

	^ aScripter
]

{ #category : #steps }
GtCoderSelectionSearchByScripterExamples >> selectText: aString in: aScripter [
	"Select the first occurrence of aString in the coder source code"

	| aStartPosition |
	aStartPosition := (aScripter model currentSourceString
			indexOfSubCollection: aString) - 1.
	self
		selectTextFor: aScripter
		from: aStartPosition
		to: aStartPosition + aString size
		andCheck: aString
]
