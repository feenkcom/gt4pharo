Class {
	#name : #GtTraitUpdateFormExamples,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtTraitUpdateFormExamples >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtTraitUpdateFormExamples >> formClass [
	^ GtTraitUpdateForm
]

{ #category : #accessing }
GtTraitUpdateFormExamples >> scripterOnSimpleForm [
	<gtExample>
	| scripter |
	scripter := self scripterWithModel: [ self simpleForm ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button is enabled';
				satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled ] ].

	^ scripter
]

{ #category : #accessing }
GtTraitUpdateFormExamples >> scripterWithClassNameAndPackageFilled [
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
GtTraitUpdateFormExamples >> simpleForm [
	<gtExample>
	^ self formClass onTrait: TAsyncFuture
]

{ #category : #examples }
GtTraitUpdateFormExamples >> simpleFormHoldsNamesAsStrings [
	"The form edits the names of a trait as text and its editors write Strings:
	it holds the names as Strings, so that a name typed back does not change the form"

	<gtExample>
	<return: #GtTraitUpdateForm>
	| form |
	form := self simpleForm.
	self
		assert: form packageAndTagName packageName
		equals: TAsyncFuture package name asString.
	self assert: (form traits allSatisfy: [ :each | each isString and: [ each isSymbol not ] ]).
	self assert: (form slots allSatisfy: [ :each | each isString and: [ each isSymbol not ] ]).
	^ form
]
