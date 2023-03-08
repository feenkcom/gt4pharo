Class {
	#name : #GtClassUpdateFormExamples,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtClassUpdateFormExamples >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtClassUpdateFormExamples >> formClass [
	^ GtClassUpdateForm
]

{ #category : #accessing }
GtClassUpdateFormExamples >> scripterOnSimpleForm [
	<gtExample>
	| scripter |
	scripter := self scripterWithModel: [ self simpleForm ].

	scripter check
		label: 'Check save button is enabled';
		satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled ];
		play.

	^ scripter
]

{ #category : #accessing }
GtClassUpdateFormExamples >> scripterWithClassNameAndPackageFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterOnSimpleForm.
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
GtClassUpdateFormExamples >> simpleForm [
	<gtExample>
	^ self formClass onClass: Object
]
