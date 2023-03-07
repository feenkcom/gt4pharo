Class {
	#name : #GtClassCreationFormExample,
	#superclass : #GtCreationFormExample,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtClassCreationFormExample >> exampleClassName [
	^ 'ExampleClass'
]

{ #category : #accessing }
GtClassCreationFormExample >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtClassCreationFormExample >> formClass [
	^ GtClassCreationForm
]

{ #category : #accessing }
GtClassCreationFormExample >> removeClassAndPackage [
	Smalltalk removeClassNamed: self exampleClassName.
	self examplePackageName asPackage removeFromSystem
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterOnSimpleForm [
	<gtExample>
	| scripter |
	scripter := self scripterWithModel: [ self simpleForm ].

	scripter check
		label: 'Check save button is disabled';
		satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled not ];
		play.

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassAccepted [
	<gtExample>
	<after: #removeClassAndPackage>
	| scripter createdClass |
	scripter := self scripterWithClassNameAndPackageFilled.

	scripter click
		label: 'Click save button';
		// #toolbar;
		onChildAt: 1;
		play.
		
	createdClass := (Smalltalk classNamed: self exampleClassName).	
	self assert: createdClass isNotNil.

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassNameAndPackageFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithClassNameFilled.
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
GtClassCreationFormExample >> scripterWithClassNameFilled [
	<gtExample>
	| scripter |
	scripter := self scripterOnSimpleForm.
	
	scripter requestFocus
		label: 'Focus name editor';
		// (GtMagritteFieldElementId new description: scripter model nameDescription);
		play.
	
	scripter type
		label: 'Fill class name';
		text: self exampleClassName;
		// (GtMagritteFieldElementId new description: scripter model nameDescription);
		play.

	scripter assert
		label: 'Assert class name';
		value: [ :anEditor | anEditor text asString ] equals: [ self exampleClassName ];
		// (GtMagritteFieldElementId new description: scripter model nameDescription);
		play.

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassNameFilledValidationFailed [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterOnSimpleForm.
	aDescription := scripter model nameDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus name editor';
		// anElementId;
		play.

	scripter type
		label: 'Fill class name';
		text: 'Object';
		// anElementId;
		play.

	scripter assert
		label: 'Check that class name is invalid';
		satisfies: [ :aFrame | ((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil isValid not ];
		play.

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
