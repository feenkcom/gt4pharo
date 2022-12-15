"
nil
"
Class {
	#name : #GtParserCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'parser',
		'scanner'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtParserCreationForm >> commit [
	| category |
	category := self commitPackage categoryName.
	Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: scanner trim;
				superclass: SmaCCScanner;
				category: category ].
	^ Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: parser trim;
				superclass: SmaCCParser;
				category: category ]
]

{ #category : #accessing }
GtParserCreationForm >> defaultParser [
	^ 'SomeParser'
]

{ #category : #accessing }
GtParserCreationForm >> defaultScanner [
	^ 'SomeScanner'
]

{ #category : #initialization }
GtParserCreationForm >> initialize [
	super initialize.

	parser := self defaultParser.
	scanner := self defaultScanner
]

{ #category : #accessing }
GtParserCreationForm >> parser [

	^ parser
]

{ #category : #accessing }
GtParserCreationForm >> parser: anObject [

	parser := anObject
]

{ #category : #magritte }
GtParserCreationForm >> parserDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Parser';
		priority: 1;
		accessor: #parser;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :aValue | aValue first isUppercase ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue isAllAlphaNumerics ]
			labelled: 'Class name must be alphanumeric'
]

{ #category : #accessing }
GtParserCreationForm >> scanner [

	^ scanner
]

{ #category : #accessing }
GtParserCreationForm >> scanner: anObject [

	scanner := anObject
]

{ #category : #magritte }
GtParserCreationForm >> scannerDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Scanner';
		priority: 2;
		accessor: #scanner;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :aValue | aValue first isUppercase ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue isAllAlphaNumerics ]
			labelled: 'Class name must be alphanumeric'
]
