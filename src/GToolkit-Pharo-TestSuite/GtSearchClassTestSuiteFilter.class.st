Class {
	#name : #GtSearchClassTestSuiteFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'testCaseClass'
	],
	#category : 'GToolkit-Pharo-TestSuite-Filters'
}

{ #category : #accessing }
GtSearchClassTestSuiteFilter >> includesMethod: aCompiledMethod [

	^ ((aCompiledMethod methodClass includesBehavior: self testCaseClass) 
		   or: [ 
		   self testCaseClass includesBehavior: aCompiledMethod methodClass ]) 
		  and: [ 
			  (aCompiledMethod methodClass inheritsFrom: TestCase) and: [ 
				  aCompiledMethod selector isTestSelector ] ]
]

{ #category : #accessing }
GtSearchClassTestSuiteFilter >> initialize [

	super initialize.
	testCaseClass := TestCase
]

{ #category : #accessing }
GtSearchClassTestSuiteFilter >> testCaseClass [
	^ testCaseClass
]

{ #category : #accessing }
GtSearchClassTestSuiteFilter >> testCaseClass: aClass [

	self
		assert: [ aClass instanceSide isTestCase ]
		description: [ aClass asString , ' must be a test case' ].
		
	testCaseClass := aClass instanceSide
]
