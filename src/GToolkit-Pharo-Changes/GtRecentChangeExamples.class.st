Class {
	#name : #GtRecentChangeExamples,
	#superclass : #Object,
	#traits : 'TGtExampleAssertable',
	#classTraits : 'TGtExampleAssertable classTrait',
	#category : #'GToolkit-Pharo-Changes-Examples'
}

{ #category : #accessing }
GtRecentChangeExamples >> simpleChange [
	<gtExample>
	| change methodChange |
	methodChange := GtRecentMethodChangeExamples new simpleMethodChange.
	change := GtRecentChange
			class: GtRecentChange
			methods: {methodChange} asOrderedCollection.

	self assert: change size equals: 1.
	self assert: change isEmpty equals: false.
	self shouldnt: [ change ifEmpty: [ self error: 'this should not be executed' ] ] raise: Error.

	change remove: methodChange method.

	self assert: change size equals: 0.
	self assert: change isEmpty.
	self should: [ change ifEmpty: [ self error: 'this should be executed' ] ] raise: Error.

	^ change
]
