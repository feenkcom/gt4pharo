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

	scripter type
		label: 'Fill class name';
		text: 'ExampleClass';
		id: (GtMagritteFieldElementId new description: (scripter model nameDescription)) asSymbol;
		play.

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
