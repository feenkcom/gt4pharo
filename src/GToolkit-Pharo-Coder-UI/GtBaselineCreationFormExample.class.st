Class {
	#name : #GtBaselineCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtBaselineCreationFormExample >> exampleBaselineName [
	^ 'BaselineOfMyExample'
]

{ #category : #accessing }
GtBaselineCreationFormExample >> exampleBaselineNameTaken [
	^ 'BaselineOfGToolkit'
]

{ #category : #accessing }
GtBaselineCreationFormExample >> formClass [
	^ GtBaselineCreationForm
]

{ #category : #accessing }
GtBaselineCreationFormExample >> removeBaseline [
	Smalltalk removeClassNamed: self exampleBaselineName.
	self exampleBaselineName asPackage removeFromSystem
]

{ #category : #accessing }
GtBaselineCreationFormExample >> scripterOnSimpleForm [
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
GtBaselineCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithBaselineAccepted [
	<gtExample>
	<after: #removeBaseline>
	| scripter baselineClass |
	scripter := self simpleFormWithBaselineFilled.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button is enabled';
				satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled ] ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Click save button';
				id: #toolbar;
				onChildAt: 1 ].

	baselineClass := Smalltalk classNamed: self exampleBaselineName.
	self assert: baselineClass isNotNil.

	^ scripter
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithBaselineFilled [
	<gtExample>
	| scripter |
	scripter := self scripterOnSimpleForm.

	scripter
		clickStep: [ :s | 
			s
				label: 'Select baseline editor';
				// (GtMagritteFieldElementId new description: scripter model baselineDescription) ].

	scripter
		typeStep: [ :s | 
			s
				label: 'Enter baseline name';
				text: self exampleBaselineName ].	"we only have one field here, so we can use anyOne"
	scripter
		assertStep: [ :s | 
			s
				label: 'Check that baseline is set';
				satisfies: [ :aFrame | 
					(aFrame userData at: #gtmemento) cache anyOne valueOrNil currentValue
						= self exampleBaselineName ] ].

	^ scripter
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithBaselineFilledValidationFailed [
	<gtExample>
	| scripter |
	scripter := self scripterOnSimpleForm.

	scripter
		clickStep: [ :s | 
			s
				label: 'Select baseline editor';
				// (GtMagritteFieldElementId new description: scripter model baselineDescription) ].

	scripter
		typeStep: [ :s | 
			s
				label: 'Enter baseline name';
				text: self exampleBaselineNameTaken ].	"we only have one field here, so we can use anyOne"
	scripter
		assertStep: [ :s | 
			s
				label: 'Check that baseline is invalid';
				satisfies: [ :aFrame | (aFrame userData at: #gtmemento) cache anyOne valueOrNil isValid not ] ].

	^ scripter
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithEditingCancelled [
	<gtExample>
	| scripter |
	scripter := self simpleFormWithBaselineFilled.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check cancel button is enabled';
				satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 2) isEnabled ] ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Click cancel button';
				id: #toolbar;
				onChildAt: 2 ].	"we only have one field here, so we can use anyOne"
	scripter
		assertStep: [ :s | 
			s
				label: 'Check that baseline is reset';
				satisfies: [ :aFrame | 
					(aFrame userData at: #gtmemento) cache anyOne valueOrNil currentValue asString
						= '' ] ].

	^ scripter
]
