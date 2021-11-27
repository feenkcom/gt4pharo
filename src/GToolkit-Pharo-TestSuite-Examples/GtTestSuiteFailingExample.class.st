Class {
	#name : #GtTestSuiteFailingExample,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #examples }
GtTestSuiteFailingExample >> example [
	<gtExample>

	self error: 'Build shall not pass'
]
