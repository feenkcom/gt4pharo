Class {
	#name : #GtParserCreationFormExample,
	#superclass : #GtCreationFormExample,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtParserCreationFormExample >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtParserCreationFormExample >> exampleParserName [
	^ 'ExampleParser'
]

{ #category : #accessing }
GtParserCreationFormExample >> exampleScannerName [
	^ 'ExampleScanner'
]

{ #category : #accessing }
GtParserCreationFormExample >> formClass [
	^ GtParserCreationForm
]

{ #category : #accessing }
GtParserCreationFormExample >> removeParserAndPackage [
	Smalltalk removeClassNamed: self exampleParserName.	Smalltalk removeClassNamed: self exampleScannerName.
	self examplePackageName asPackage removeFromSystem
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterOnSimpleForm [
	<gtExample>
	| scripter |
	scripter := self scripterWithModel: [ self simpleForm ].

	scripter assert
		label: 'Check save button is disabled';
		satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled not ];
		play.

	^ scripter
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterWithParserAccepted [
	<gtExample>
	<after: #removeParserAndPackage>
	| scripter createdClass |
	scripter := self scripterWithParserAndScannerNameAndPackageFilled.

	scripter click
		label: 'Click save button';
		// #toolbar;
		onChildAt: 1;
		play.
		
	createdClass := (Smalltalk classNamed: self exampleParserName).	
	self assert: createdClass isNotNil.
		
	createdClass := (Smalltalk classNamed: self exampleScannerName).	
	self assert: createdClass isNotNil.

	^ scripter
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterWithParserAndScannerNameAndPackageFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithParserAndScannerNameFilled.
	aDescription := scripter model packageAndTagDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	aDescription := scripter model packageAndTagDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus package editor';
		// anElementId;
		onChildAt: 1;
		play.

	scripter type
		label: 'Fill package name';
		text: self examplePackageName;
		// anElementId;
		onChildAt: 1;
		play.

	scripter assert
		label: 'Check that package is set';
		satisfies: [ :aFrame | 
			((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
				currentValue packageName = self examplePackageName ];
		play.

	^ scripter
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterWithParserAndScannerNameFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithParserNameFilled.
	aDescription := scripter model scannerDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus scanner editor';
		// anElementId;
		play.

	scripter type
		label: 'Fill scanner name';
		text: self exampleScannerName;
		// anElementId;
		play.

	scripter assert
		label: 'Assert scanner name';
		value: [ :anEditor | anEditor text asString ]
			equals: [ self exampleScannerName ];
		// anElementId;
		play.

	^ scripter
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterWithParserNameFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterOnSimpleForm.
	aDescription := scripter model parserDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus parser editor';
		// anElementId;
		play.

	scripter type
		label: 'Fill parser name';
		text: self exampleParserName;
		// anElementId;
		play.

	scripter assert
		label: 'Assert parser name';
		value: [ :anEditor | anEditor text asString ]
			equals: [ self exampleParserName ];
		// anElementId;
		play.

	^ scripter
]

{ #category : #accessing }
GtParserCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
