"
I hold a coder view model and the text currently selected in it, and I define the search actions available in the coder context menu when there is a selection (see {{gtClass:GtCoderSelectionSearchTarget}}).

Supported searches:
- literal substring, case insensitive ({{gtMethod:String>>#gtSubstringLiteralMatch}})
- literal substring, case sensitive ({{gtMethod:String>>#gtSubstringLiteralCaseSensitiveMatch}})
- substring in method source code ({{gtMethod:String>>#gtSubstringMatch}}). It goes over the source code of all methods. It is enabled by default, but as it can be slow in large images, it can be disabled with:

```
GtCoderSelectionSearch disableSubstringSearch.
```
"
Class {
	#name : #GtCoderSelectionSearch,
	#superclass : #Object,
	#instVars : [
		'coderViewModel',
		'selectedString'
	],
	#classVars : [
		'SubstringSearchEnabled'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Search'
}

{ #category : #'instance creation' }
GtCoderSelectionSearch class >> coderViewModel: aCoderViewModel [
	^ self new coderViewModel: aCoderViewModel
]

{ #category : #settings }
GtCoderSelectionSearch class >> disableSubstringSearch [
	self substringSearchEnabled: false
]

{ #category : #settings }
GtCoderSelectionSearch class >> enableSubstringSearch [
	self substringSearchEnabled: true
]

{ #category : #settings }
GtCoderSelectionSearch class >> isSubstringSearchEnabled [
	"Return true if the search in method source code (see String>>#gtSubstringMatch) is available.
	It is enabled by default. It can be slow in large images, in which case it can be disabled using #disableSubstringSearch"

	<return: #Boolean>
	^ SubstringSearchEnabled ifNil: [ true ]
]

{ #category : #settings }
GtCoderSelectionSearch class >> substringSearchEnabled: aBoolean [
	SubstringSearchEnabled := aBoolean
]

{ #category : #searching }
GtCoderSelectionSearch >> caseSensitiveLiteralSubstringFilter [
	"Methods with string or symbol literals that include the selection, matching case"

	^ self selectedString gtSubstringLiteralCaseSensitiveMatch
]

{ #category : #accessing }
GtCoderSelectionSearch >> coderViewModel [
	^ coderViewModel
]

{ #category : #accessing }
GtCoderSelectionSearch >> coderViewModel: aCoderViewModel [
	coderViewModel := aCoderViewModel.
	selectedString := nil
]

{ #category : #private }
GtCoderSelectionSearch >> computeSelectedString [
	<return: #String>
	| anInterval |
	coderViewModel ifNil: [ ^ '' ].
	coderViewModel hasSelection ifFalse: [ ^ '' ].
	anInterval := coderViewModel selectedTextInterval.
	anInterval isEmpty ifTrue: [ ^ '' ].
	^ coderViewModel coder currentSourceString
		copyFrom: anInterval first
		to: anInterval last
]

{ #category : #'gt - actions' }
GtCoderSelectionSearch >> gtSearchCaseSensitiveLiteralSubstringFor: anAction [
	<gtAction>
	self hasSearchableSelection ifFalse: [ ^ anAction noAction ].
	^ anAction button
		priority: 20;
		target: GtCoderSelectionSearchTarget;
		icon: BrGlamorousVectorIcons search;
		label: 'Literals containing (case sensitive)';
		menuItemPreview: self selectionPreview;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: self caseSensitiveLiteralSubstringFilter ]
]

{ #category : #'gt - actions' }
GtCoderSelectionSearch >> gtSearchLiteralSubstringFor: anAction [
	<gtAction>
	self hasSearchableSelection ifFalse: [ ^ anAction noAction ].
	^ anAction button
		priority: 10;
		target: GtCoderSelectionSearchTarget;
		icon: BrGlamorousVectorIcons search;
		label: 'Literals containing (case insensitive)';
		menuItemPreview: self selectionPreview;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: self literalSubstringFilter ]
]

{ #category : #'gt - actions' }
GtCoderSelectionSearch >> gtSearchSubstringFor: anAction [
	<gtAction>
	self isSubstringSearchEnabled ifFalse: [ ^ anAction noAction ].
	self hasSearchableSelection ifFalse: [ ^ anAction noAction ].
	^ anAction button
		priority: 30;
		target: GtCoderSelectionSearchTarget;
		icon: BrGlamorousVectorIcons search;
		label: 'Source code containing';
		menuItemPreview: self selectionPreview;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: self substringFilter ]
]

{ #category : #testing }
GtCoderSelectionSearch >> hasSearchableSelection [
	"Searching only makes sense if there is a selection that is not made only of whitespace"

	<return: #Boolean>
	^ self selectedString notEmpty and: [ self selectedString isAllSeparators not ]
]

{ #category : #testing }
GtCoderSelectionSearch >> isSubstringSearchEnabled [
	<return: #Boolean>
	^ self class isSubstringSearchEnabled
]

{ #category : #searching }
GtCoderSelectionSearch >> literalSubstringFilter [
	"Methods with string or symbol literals that include the selection, ignoring case"

	^ self selectedString gtSubstringLiteralMatch
]

{ #category : #printing }
GtCoderSelectionSearch >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self selectedString;
		nextPut: $)
]

{ #category : #accessing }
GtCoderSelectionSearch >> selectedString [
	"Return the text selected in the coder, or an empty string if there is no selection"

	<return: #String>
	^ selectedString ifNil: [ selectedString := self computeSelectedString ]
]

{ #category : #accessing }
GtCoderSelectionSearch >> selectedString: aString [
	"Explicitly set the string to search for (mainly for examples and tests)"

	selectedString := aString
]

{ #category : #accessing }
GtCoderSelectionSearch >> selectionPreview [
	"Return a short, single line version of the selection to be shown in menu items"

	<return: #String>
	| aString |
	aString := (self selectedString trimBoth copyReplaceAll: String cr with: ' ')
			copyReplaceAll: String lf
			with: ' '.
	^ aString size > 30
		ifTrue: [ (aString first: 30) , '...' ]
		ifFalse: [ aString ]
]

{ #category : #searching }
GtCoderSelectionSearch >> substringFilter [
	"Methods whose source code includes the selection. Can be slow in large images"

	^ self selectedString gtSubstringMatch
]
