"
I represent {{gtClass:GtPharoMethodTestCase}} state.
My subclasses define states like passed, failure, error test case execution results.

"
Class {
	#name : #GtPharoMethodTestCaseState,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #visiting }
GtPharoMethodTestCaseState class >> accept: aVisitor [
	^ aVisitor visitTestCaseState: self
]

{ #category : #accessing }
GtPharoMethodTestCaseState class >> allLabels [

	^ Array streamContents: [ :aStream | 
		  self stateClassesDo: [ :eachClass | 
			  aStream nextPut: eachClass label ] ]
]

{ #category : #accessing }
GtPharoMethodTestCaseState class >> allStates [

	^ Array streamContents: [ :aStream | 
		  self stateClassesDo: [ :eachClass | 
			  aStream nextPut: eachClass ] ]
]

{ #category : #accessing }
GtPharoMethodTestCaseState class >> allTestCasesIn: aTestSuite [
	<return: #TAsyncFuture>

	^ aTestSuite allTestCasesWithState: self
]

{ #category : #'api - state change' }
GtPharoMethodTestCaseState class >> beSkipped: aGtPharoMethodTestCase [
	"Subclasses may react to the be-skipped request"
]

{ #category : #'api - testing' }
GtPharoMethodTestCaseState class >> includesCoder: aCoder [

	^ aCoder testCase state = self
]

{ #category : #'api - testing' }
GtPharoMethodTestCaseState class >> includesTestCase: aPharoTestCase [
	<return: #Boolean>

	^ aPharoTestCase canExecute and: [ aPharoTestCase state = self ]
]

{ #category : #accessing }
GtPharoMethodTestCaseState class >> label [
	"Return a textural representation"
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoMethodTestCaseState class >> numberOfMethodsIn: aTestSuite [
	<return: #TAsyncFuture>

	^ aTestSuite numberOfAllTestCasesWithState: self
]

{ #category : #testing }
GtPharoMethodTestCaseState class >> representsTestResult: aTestResult [
	^ self subclassResponsibility
]

{ #category : #enumerating }
GtPharoMethodTestCaseState class >> stateClassesDo: aBlock [

	self allSubclassesDo: [ :eachClass | 
		eachClass isAbstract ifFalse: [ aBlock value: eachClass ] ]
]

{ #category : #accessing }
GtPharoMethodTestCaseState class >> stateFromLabel: aLabel [

	| aString |
	aString := aLabel asString.
	self stateClassesDo: [ :eachClass | 
		eachClass label = aString ifTrue: [ ^ eachClass ] ].

	^ GtPharoMethodTestCaseAllState
]

{ #category : #'instance creation' }
GtPharoMethodTestCaseState class >> stateFromTestResult: aTestResult [

	aTestResult ifNil: [ ^ GtPharoMethodNotExecutedState ].

	self stateClassesDo: [ :eachStateClass | 
		(eachStateClass representsTestResult: aTestResult) ifTrue: [ 
			^ eachStateClass ] ].

	^ GtPharoMethodNotExecutedState
]
