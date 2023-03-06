Class {
	#name : #GtPackageCreationFormExample,
	#superclass : #GtCreationFormExample,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtPackageCreationFormExample >> examplePackageName [
	^ 'MyExamplePackage'
]

{ #category : #accessing }
GtPackageCreationFormExample >> formClass [
	^ GtPackageCreationForm
]

{ #category : #accessing }
GtPackageCreationFormExample >> scripterOnSimpleForm [
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
GtPackageCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithPackageFilled [
	<gtExample>
	| scripter |
	scripter := self scripterOnSimpleForm.

	scripter click
		label: 'Select package editor';
		// (GtMagritteFieldElementId new description: scripter model packageAndTagDescription);
		// #package;
		play.

	scripter type
		label: 'Enter package name';
		text: self examplePackageName;
		play.
		
	scripter check
		label: 'Check that package is set';
		satisfies: [ :aFrame | 
			(aFrame userData at: #gtmemento) cache anyOne valueOrNil currentValue packageName
				= self examplePackageName ];
		play.

	^ scripter
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithTagNavigated [
	<gtExample>
	| scripter |
	scripter := self simpleFormWithPackageFilled.

	scripter shortcut
		label: 'Navigate to tag';
		combination: BlKeyCombination tab;
		play.

	^ scripter
]
