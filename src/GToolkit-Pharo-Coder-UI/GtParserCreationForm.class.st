Class {
	#name : #GtParserCreationForm,
	#superclass : #GtPharoCreationForm,
	#instVars : [
		'parser',
		'scanner'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtParserCreationForm class >> componentName [
	^ 'Parser'
]

{ #category : #accessing }
GtParserCreationForm class >> priority [
	^ 5
]

{ #category : #callbacks }
GtParserCreationForm >> commit [
	| category scannerClass parserClass |
	category := self commitPackage categoryName.
	scannerClass := Smalltalk classInstaller
			make: [ :builder | 
				builder
					name: scanner trim;
					superclass: SmaCCScanner;
					category: category ].
	parserClass := Smalltalk classInstaller
			make: [ :builder | 
				builder
					name: parser trim;
					superclass: SmaCCParser;
					category: category ].
	(RBAddMethodChange
		compile: 'scannerClass
	^' , scanner
		in: parserClass class
		classified: #generated) execute.

	(RBAddMethodChange
		compile: 'definitionComment
	"Start 
	:
	;"'
		in: parserClass class
		classified: #generated) execute.

	^ parserClass
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

	parser := ''.
	scanner := ''
]

{ #category : #accessing }
GtParserCreationForm >> parser [

	^ parser
]

{ #category : #accessing }
GtParserCreationForm >> parser: aString [
	| isEmpty |
	isEmpty := parser isEmpty.
	parser := aString.
	isEmpty ifTrue: [ self updateScannerFromParser ]
]

{ #category : #magritte }
GtParserCreationForm >> parserDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Parser';
		priority: 1;
		accessor: #parserRope;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtPharoCodeModifier current
				critical: [ GtStringsCompletionStrategy new
						completions: (GtPrefixTree withAll: Smalltalk classNames) ] ];
		default: '';
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Parser name must be set';
		addCondition: [ :aValue | (Smalltalk classNamed: aValue asString trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :aValue | aValue isEmpty or: [ aValue asString first isUppercase ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue asString isAllAlphaNumerics ]
			labelled: 'Class name must be alphanumeric';
		beRequired
]

{ #category : #accessing }
GtParserCreationForm >> parserRope [
	"We do not mind to return a BlText instance in case of empty parser name
	since we do not allow empty class names."

	<return: #String or: #BlText>
	^ self parser
		ifEmpty: [ self parser asRopedText 
			attribute: (self ghostTextFor: self defaultParser) ]
]

{ #category : #accessing }
GtParserCreationForm >> parserRope: aBlText [
	self parser: aBlText asString
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
		accessor: #scannerRope;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtPharoCodeModifier current
				critical: [ GtStringsCompletionStrategy new
						completions: (GtPrefixTree withAll: Smalltalk classNames) ] ];
		default: '';
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Scanner name must be set';
		addCondition: [ :aValue | (Smalltalk classNamed: aValue asString trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :aValue | aValue isEmpty or: [ aValue asString first isUppercase ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue asString isAllAlphaNumerics ]
			labelled: 'Class name must be alphanumeric';
		beRequired
]

{ #category : #accessing }
GtParserCreationForm >> scannerRope [
	"We do not mind to return a BlText instance in case of empty scanner name
	since we do not allow empty class names."
	
	<return: #String or: #BlText>
	^ self scanner
		ifEmpty: [ self scanner asRopedText 
			attribute: (self ghostTextFor: self defaultScanner) ]
]

{ #category : #accessing }
GtParserCreationForm >> scannerRope: aRope [
	self scanner: aRope asString
]

{ #category : #private }
GtParserCreationForm >> updateScannerFromParser [
	self scanner ifNotEmpty: [ ^ self ].
	self parser ifEmpty: [ ^ self ].
	(self parser endsWith: 'Parser' caseSensitive: true) ifFalse: [ ^ self ].
	self scanner: (self parser first: self parser size - 6) , 'Scanner'
]
