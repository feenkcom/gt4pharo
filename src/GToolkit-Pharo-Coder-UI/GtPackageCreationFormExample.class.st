Class {
	#name : #GtPackageCreationFormExample,
	#superclass : #GtCreationFormExample,
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
GtPackageCreationFormExample >> removePackage [
	self examplePackageName asPackage removeFromSystem
]

{ #category : #accessing }
GtPackageCreationFormExample >> scripterOnSimpleForm [
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
GtPackageCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithPackageAdded [
	<gtExample>
	<after: #removePackage>
	| scripter createdPackage |
	scripter := self simpleFormWithPackageFilled.

	scripter
		clickStep: [ :s | 
			s
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].

	createdPackage := self examplePackageName asPackageIfAbsent: nil.
	self assert: createdPackage isNotNil.

	^ scripter
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithPackageFilled [
	<gtExample>
	| scripter |
	scripter := self scripterOnSimpleForm.

	scripter
		clickStep: [ :s | 
			s
				label: 'Select package editor';
				// (GtMagritteFieldElementId new
						description: scripter model packageAndTagDescription);
				// #package ].

	scripter
		typeStep: [ :s | 
			s
				label: 'Enter package name';
				text: self examplePackageName ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check that package is set';
				satisfies: [ :aFrame | 
					(aFrame userData at: #gtmemento) cache anyOne valueOrNil currentValue
						packageName = self examplePackageName ] ].

	^ scripter
]

{ #category : #accessing }
GtPackageCreationFormExample >> simpleFormWithPackageFilledValidationFailed [
	<gtExample>
	| scripter |
	scripter := self scripterOnSimpleForm.

	scripter
		clickStep: [ :s | 
			s
				label: 'Select package editor';
				// (GtMagritteFieldElementId new
						description: scripter model packageAndTagDescription);
				// #package ].

	scripter
		typeStep: [ :s | 
			s
				label: 'Enter package name';
				text: 'Kernel' ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check that package is invalid';
				satisfies: [ :aFrame | (aFrame userData at: #gtmemento) cache anyOne valueOrNil isValid not ] ].

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
