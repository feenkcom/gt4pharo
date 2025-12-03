Class {
	#name : #GtPharoDummySubTestCase,
	#superclass : #GtPharoDummyTestCase,
	#category : 'GToolkit-Pharo-Coder-Examples-Test Case'
}

{ #category : #accessing }
GtPharoDummySubTestCase >> testErroringSubOne [

	self assert: false description: [ 'I always fail' ]
]

{ #category : #accessing }
GtPharoDummySubTestCase >> testSubOne [

	self assert: true description: [ 'I should be true' ]
]
