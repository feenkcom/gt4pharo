Class {
	#name : #GtClassCreationForm,
	#superclass : #GtBehaviorCreationForm,
	#instVars : [
		'superclassName',
		'classVars',
		'pools'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtClassCreationForm class >> componentName [
	^ 'Class'
]

{ #category : #accessing }
GtClassCreationForm class >> priority [
	^ 1
]

{ #category : #accessing }
GtClassCreationForm >> classVars [

	^ classVars
]

{ #category : #accessing }
GtClassCreationForm >> classVars: anObject [

	classVars := anObject
]

{ #category : #accessing }
GtClassCreationForm >> classVarsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Class vars';
		priority: 7;
		accessor: #classVars;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		classes: {String};
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil)
]

{ #category : #accessing }
GtClassCreationForm >> commit [
	| aClass |
	Smalltalk compiler evaluate: self definitionString.
	aClass := Smalltalk classNamed: self rawClassName.
	self installClassSlotsOn: aClass.
	^ aClass
]

{ #category : #accessing }
GtClassCreationForm >> defaultName [
	^ 'NameOfSubclass'
]

{ #category : #accessing }
GtClassCreationForm >> definitionString [
	| aStream aPackage |
	aStream := (String new: 800) writeStream.
	aStream nextPutAll: self superclassName.

	aStream
		nextPutAll: ' subclass: ';
		store: self rawClassName asSymbol.

	self traits isEmpty
		ifFalse: [ aStream
				cr;
				tab;
				nextPutAll: 'uses: ';
				nextPutAll: (' + ' join: self traits) ].
	aStream
		cr;
		tab;
		nextPutAll: 'instanceVariableNames: ';
		store: (' ' join: self slots).	"Class vars"
	aStream
		cr;
		tab;
		nextPutAll: 'classVariableNames: ';
		store: (' ' join: self classVars).	"Pool Dictionaries"
	aStream
		cr;
		tab;
		nextPutAll: 'poolDictionaries: ';
		store: (' ' join: self pools).

	aPackage := self commitPackage.

	aStream
		cr;
		tab;
		nextPutAll: 'package: ';
		store: aPackage categoryName asString.

	^ aStream contents
]

{ #category : #accessing }
GtClassCreationForm >> initialize [
	super initialize.

	self superclassName: 'Object'.

	classVars := OrderedCollection new.
	pools := OrderedCollection new
]

{ #category : #accessing }
GtClassCreationForm >> pools [

	^ pools
]

{ #category : #accessing }
GtClassCreationForm >> pools: anObject [

	pools := anObject
]

{ #category : #accessing }
GtClassCreationForm >> poolsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Pools';
		priority: 7;
		accessor: #pools;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		classes: {String};
		blocListStencil: (self
				taggerStencilWithCompletion: GtPoolsCompletionStrategy new
				andContextMenuBlock: nil)
]

{ #category : #accessing }
GtClassCreationForm >> superclassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Superclass';
		priority: 2;
		accessor: #superclassName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNotNil ]
			labelled: 'Unknown class';
		beRequired
]

{ #category : #accessing }
GtClassCreationForm >> superclassName [

	^ superclassName
]

{ #category : #accessing }
GtClassCreationForm >> superclassName: anObject [

	superclassName := anObject
]
