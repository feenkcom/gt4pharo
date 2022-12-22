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
GtBaselineCreationFormExample >> formClass [
	^ GtBaselineCreationForm
]

{ #category : #accessing }
GtBaselineCreationFormExample >> scripterOnSimpleForm [
	<gtExample>
	| scripter |
	scripter := BlScripter new element: self simpleForm.

	scripter check
		label: 'Check save button is disabled';
		satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled not ];
		play.

	^ scripter
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new asElement
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithBaselineAccepted [
	<gtExample>
	<noTest>
	| scripter baselineClass |
	scripter := self simpleFormWithBaselineFilled.

	scripter check
		label: 'Check save button is enabled';
		satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled ];
		play.
		
	scripter click
		label: 'Click save button';
		id: #toolbar;
		index: 1;
		play.
	
	baselineClass := (Smalltalk classNamed: self exampleBaselineName).	
	self assert: baselineClass isNotNil.
	Smalltalk removeClassNamed: self exampleBaselineName.

	^ scripter
]

{ #category : #accessing }
GtBaselineCreationFormExample >> simpleFormWithBaselineFilled [
	<gtExample>
	| scripter |
	scripter := self scripterOnSimpleForm.

	scripter click
		label: 'Select baseline editor';
		id: #field;
		play.

	scripter type
		label: 'Enter baseline name';
		text: self exampleBaselineName;
		play.
		
	"we only have one field here, so we can use anyOne"
	scripter check
		label: 'Check that baseline is set';
		satisfies: [ :aFrame | 
			(aFrame userData at: #gtmemento) cache anyOne valueOrNil currentValue
				= self exampleBaselineName ];
		play.

	^ scripter
]
