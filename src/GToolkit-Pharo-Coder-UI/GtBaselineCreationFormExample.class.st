Class {
	#name : #GtBaselineCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

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
