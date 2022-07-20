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
	| change |
	change := GtRecentChange class: GtRecentChange methods: { GtRecentChange >> #gtChildren } asOrderedCollection.
	
	self assert: change size equals: 1.
	self shouldnt: [ change ifEmpty: [ self error: 'works' ] ] raise: Error.
	
	change remove: GtRecentChange >> #gtChildren.
	
	self assert: change size equals: 0.
	self should: [ change ifEmpty: [ self error: 'works' ] ] raise: Error.
	
	^ change
]
