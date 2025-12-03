Class {
	#name : #GtPharoDummyAbstractTestCase,
	#superclass : #TestCase,
	#category : 'GToolkit-Pharo-Coder-Examples-Test Case'
}

{ #category : #accessing }
GtPharoDummyAbstractTestCase class >> isAbstract [
	^ self name = #GtPharoDummyAbstractTestCase
]

{ #category : #accessing }
GtPharoDummyAbstractTestCase >> foo [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoDummyAbstractTestCase >> testCallingFoo [

	self assert: self foo description: [ 'I may pass' ]
]

{ #category : #accessing }
GtPharoDummyAbstractTestCase >> testPassingOne [

	self assert: true description: [ 'I always pass' ]
]
