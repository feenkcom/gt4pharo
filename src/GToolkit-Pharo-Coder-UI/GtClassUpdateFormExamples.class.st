Class {
	#name : #GtClassUpdateFormExamples,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #assertions }
GtClassUpdateFormExamples >> assertNoExampleClass [
	self assert: (Smalltalk hasClassNamed: self exampleClassName) not
]

{ #category : #'examples - settup' }
GtClassUpdateFormExamples >> ensureExampleClass [
	<gtExample>
	<after: #removeClassAndPackage>
	
	
	((Object << self exampleClassName)
		package: self examplePackageName)
		install.
	
	self assert: (Smalltalk hasClassNamed: self exampleClassName).
	
	^ self exampleClassName asClass
]

{ #category : #accessing }
GtClassUpdateFormExamples >> exampleClassName [
	^ #ExampleClass
]

{ #category : #accessing }
GtClassUpdateFormExamples >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtClassUpdateFormExamples >> formClass [
	^ GtClassUpdateForm
]

{ #category : #accessing }
GtClassUpdateFormExamples >> removeClassAndPackage [
	Smalltalk removeClassNamed: self exampleClassName.
	
	{self examplePackageName} do: [ :aPackageName |
		self packageOrganizer  
			packageNamed:  aPackageName
			ifPresent: [ :aPackage |
				aPackage removeFromSystem ] ]
]

{ #category : #accessing }
GtClassUpdateFormExamples >> scripterOnSimpleForm [
	<gtExample>
	| scripter |
	scripter := self scripterWithModel: [ self simpleFormOnObject ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button is enabled';
				satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled ] ].

	^ scripter
]

{ #category : #accessing }
GtClassUpdateFormExamples >> scripterOnSimpleFormOnObject [
	<gtExample>
	| scripter |
	scripter := self scripterOnSimpleForm.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button is enabled';
				satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled ] ].

	^ scripter
]

{ #category : #accessing }
GtClassUpdateFormExamples >> scripterSaveActionWithNoEditHasNoEffect [
	<gtExample>
	| scripter exampleClass curentHash |
	
	self assertNoExampleClass.
	
	exampleClass := self ensureExampleClass.
	curentHash := exampleClass identityHash.
	scripter := self scripterWithModel: [ self simpleForm ].
	
	scripter
		clickStep: [ :s | 
			s
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].
				
	self 
		assert: curentHash 
		equals: self exampleClassName asClass identityHash. 

	^ scripter
]

{ #category : #accessing }
GtClassUpdateFormExamples >> scripterSaveActionWithNoEditHasNoEffect_onClassWithClassSlots [
	<gtExample>
	| scripter exampleClass curentHash |
	
	self assertNoExampleClass.
	
	exampleClass := self ensureExampleClass.
	(exampleClass superclass class << exampleClass class
		slots: { #default }) install.
	
	curentHash := exampleClass identityHash.
	scripter := self scripterWithModel: [ self simpleForm ].
	
	scripter
		clickStep: [ :s | 
			s
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].
				
	self 
		assert: curentHash 
		equals: self exampleClassName asClass identityHash. 

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
GtClassUpdateFormExamples >> simpleForm [
	^ self formClass onClass: self exampleClassName asClass
]

{ #category : #accessing }
GtClassUpdateFormExamples >> simpleFormOnObject [
	^ self formClass onClass: Object
]
