"
I am a {{gtClass:GtFiltersDummyObjectWithExampleStates}}.
I am used for testing purposes, see my {{gtClass:GtFiltersDummyObjectWithAllExampleStates|label=references|show=#gtAllReferencesFor:|expanded=true}}:

"
Class {
	#name : #GtFiltersDummyObjectWithAllExampleStates,
	#superclass : #GtFiltersDummyObjectWithExampleStates,
	#category : #'GToolkit-Pharo-Coder-Examples-Filters - UI'
}

{ #category : #accessing }
GtFiltersDummyObjectWithAllExampleStates >> foo [
	^ 42
]

{ #category : #examples }
GtFiltersDummyObjectWithAllExampleStates >> one [
	<gtExample>
	^ 42
]

{ #category : #examples }
GtFiltersDummyObjectWithAllExampleStates >> three [
	<gtExample>
	<noTest>
	self assert: false
]

{ #category : #examples }
GtFiltersDummyObjectWithAllExampleStates >> two [
	<gtExample>
	<noTest>
	^ 1/0
]
