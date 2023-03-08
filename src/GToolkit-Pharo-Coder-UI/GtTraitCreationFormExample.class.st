Class {
	#name : #GtTraitCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtTraitCreationFormExample >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtTraitCreationFormExample >> exampleTraitName [
	^ 'TExampleTrait'
]

{ #category : #accessing }
GtTraitCreationFormExample >> formClass [
	^ GtTraitCreationForm
]

{ #category : #accessing }
GtTraitCreationFormExample >> removeTraitAndPackage [
	Smalltalk removeClassNamed: self exampleTraitName.
	self examplePackageName asPackage removeFromSystem
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterOnSimpleForm [
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
GtTraitCreationFormExample >> scripterWithSlotsFilled [
	<gtExample>
	| scripter aDescription |
	scripter := self scripterWithSlotsNavigated.
	aDescription := scripter model slotsDescription.

	scripter type
		label: 'Fill first slot';
		text: 'abc';
		play.

	scripter keyPress
		label: 'Tab to next slot';
		key: BlKeyboardKey tab;
		play.

	scripter type
		label: 'Fill second slot';
		text: 'bcd';
		play.
		
	scripter keyPress
		label: 'Tab to next slot again';
		key: BlKeyboardKey tab;
		play.
	
	scripter assert
		label: 'Check that slots are set';
		satisfies: [ :aFrame | 
			((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
				currentValue = {'abc' . 'bcd'} asOrderedCollection ];
		play.

	^ scripter
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterWithSlotsNavigated [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithTraitNameAndPackageFilled.
	aDescription := scripter model packageAndTagDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter keyPress
		label: 'Tab to tag editor';
		key: BlKeyboardKey tab;
		play.

	scripter keyPress
		label: 'Tab to slots';
		key: BlKeyboardKey tab;
		play.

	^ scripter
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterWithTraitAccepted [
	<after: #removeTraitAndPackage>
	<gtExample>
	| scripter createdTrait |
	scripter := self scripterWithSlotsFilled.

	scripter click
		label: 'Click save button';
		// #toolbar;
		onChildAt: 1;
		play.

	createdTrait := Smalltalk classNamed: self exampleTraitName.
	self assert: createdTrait isNotNil.
	self
		assert: (createdTrait slots collect: #name)
		equals: {'abc'.
				'bcd'}.

	^ scripter
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterWithTraitNameAndPackageFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithTraitNameFilled.
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
GtTraitCreationFormExample >> scripterWithTraitNameFilled [
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
		label: 'Fill trait name';
		text: self exampleTraitName;
		// anElementId;
		play.

	scripter assert
		label: 'Assert trait name';
		value: [ :anEditor | anEditor text asString ]
			equals: [ self exampleTraitName ];
		// anElementId;
		play.

	^ scripter
]

{ #category : #accessing }
GtTraitCreationFormExample >> scripterWithTraitNameFilledValidationFailed [
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
		label: 'Fill trait name';
		text: 'Object';
		// anElementId;
		play.

	scripter assert
		label: 'Check that trait name is invalid';
		satisfies: [ :aFrame | ((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil isValid not ];
		play.

	^ scripter
]

{ #category : #accessing }
GtTraitCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
