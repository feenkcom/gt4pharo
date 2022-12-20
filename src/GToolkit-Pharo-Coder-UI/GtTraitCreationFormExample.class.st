Class {
	#name : #GtTraitCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtTraitCreationFormExample >> scripterOnSimpleForm [
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
GtTraitCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new asElement
]
