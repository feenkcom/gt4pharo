Class {
	#name : #GtPharoDummyTestCase,
	#superclass : #TestCase,
	#category : 'GToolkit-Pharo-Coder-Examples-Test Case'
}

{ #category : #accessing }
GtPharoDummyTestCase >> setUp [
	super setUp.
	Object new.
]

{ #category : #accessing }
GtPharoDummyTestCase >> testErroringOne [
	
	self assert: 1/0 description: [ 'I am a test case with an error' ].
]

{ #category : #accessing }
GtPharoDummyTestCase >> testFailingOne [
	
	self assert: false description: [ 'I am a test case with an error' ].
]

{ #category : #accessing }
GtPharoDummyTestCase >> testNewOne [
	self assert: true
]

{ #category : #accessing }
GtPharoDummyTestCase >> testPassedOne [

	self assert: true description: [ 'I should be true' ].
]

{ #category : #accessing }
GtPharoDummyTestCase >> testSecondNewOne [
	self assert: false
]

{ #category : #accessing }
GtPharoDummyTestCase >> testSkippedOne [

	<noTest>
	self assert: true description: [ 'I should be true' ]
]
