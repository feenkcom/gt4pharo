Class {
	#name : #GtParserCreationFormExample,
	#superclass : #GtCreationFormExample,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtParserCreationFormExample >> formClass [
	^ GtParserCreationForm
]

{ #category : #accessing }
GtParserCreationFormExample >> scripterOnSimpleForm [
	<gtExample>
	| scripter |
	scripter := self scripterWithModel: [ self simpleForm ].

	scripter assert
		label: 'Check save button is disabled';
		satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled not ];
		play.

	^ scripter
]

{ #category : #accessing }
GtParserCreationFormExample >> simpleForm [
	<gtExample>
	^ self formClass new
]
