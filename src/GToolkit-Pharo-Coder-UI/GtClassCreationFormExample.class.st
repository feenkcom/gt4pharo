Class {
	#name : #GtClassCreationFormExample,
	#superclass : #GtCreationFormExample,
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

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button is disabled';
				satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled not ] ].

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassAccepted [
	<gtExample>
	<after: #removeClassAndPackage>
	| scripter createdClass |
	scripter := self scripterWithClassNameAndPackageFilled.

	scripter
		clickStep: [ :s | 
			s
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].

	createdClass := Smalltalk classNamed: self exampleClassName.
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

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill package name';
				text: self examplePackageName;
				// anElementId;
				onChildAt: 1 ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Check that package is set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue packageName = self examplePackageName ] ].

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> scripterWithClassNameFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterOnSimpleForm.
	aDescription := scripter model nameDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus name editor';
		// anElementId;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill class name';
				text: self exampleClassName;
				// anElementId ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert class name';
				value: [ :anEditor | anEditor text asString ]
					equals: [ self exampleClassName ];
				// anElementId ].

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

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill class name';
				text: 'Object';
				// anElementId ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Check that class name is invalid';
				satisfies: [ :aFrame | ((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil isValid not ] ].

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
