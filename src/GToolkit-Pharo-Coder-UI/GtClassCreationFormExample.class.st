Class {
	#name : #GtClassCreationFormExample,
	#superclass : #GtCreationFormExample,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtClassCreationFormExample >> formClass [
	^ GtClassCreationForm
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
		text: 'ExampleClass';
		// (GtMagritteFieldElementId new description: scripter model nameDescription);
		play.

	scripter assert
		label: 'Assert class name';
		value: [ :anEditor | anEditor text asString ] equals: [ 'ExampleClass' ];
		// (GtMagritteFieldElementId new description: scripter model nameDescription);
		play.

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
