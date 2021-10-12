Class {
	#name : #GtPharoDummyTestCase,
	#superclass : #TestCase,
	#category : #'GToolkit-Pharo-Coder-Examples-Test Case'
}

{ #category : #accessing }
GtPharoDummyTestCase >> setUp [
	super setUp.
	Object new.
]

{ #category : #accessing }
GtPharoDummyTestCase >> testPassedOne [

	self assert: true description: [ 'I should be true' ].
]
