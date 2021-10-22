"
I represent {{gtClass:GtPharoMethodTestCase}} state.
My subclasses define states like passed, failure, error test case execution results.

"
Class {
	#name : #GtPharoMethodTestCaseState,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoMethodTestCaseState class >> allLabels [

	^ Array streamContents: [ :aStream | 
		  self stateClassesDo: [ :eachClass | 
			  aStream nextPut: eachClass default label ] ]
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
		eachClass default label = aString ifTrue: [ ^ eachClass default ] ].

	^ GtPharoMethodAllState default
]

{ #category : #'instance creation' }
GtPharoMethodTestCaseState class >> stateFromTestResult: aTestResult [

	aTestResult ifNil: [ ^ GtPharoMethodNotExecutedState default ].

	self stateClassesDo: [ :eachStateClass | 
		(eachStateClass representsTestResult: aTestResult) ifTrue: [ 
			^ eachStateClass default ] ].

	^ GtPharoMethodNotExecutedState default
]

{ #category : #visiting }
GtPharoMethodTestCaseState >> accept: aVisitor [
	^ aVisitor visitTestCaseState: self
]

{ #category : #'api - state change' }
GtPharoMethodTestCaseState >> beSkipped: aGtPharoMethodTestCase [
	"Subclasses may react to the be-skipped request"
]

{ #category : #accessing }
GtPharoMethodTestCaseState >> color [
	"Return a color that represents a given state"
	<return: #Color>
	^ Color transparent
]

{ #category : #'api - testing' }
GtPharoMethodTestCaseState >> includesCoder: aCoder [

	^ aCoder testCase state = self
]

{ #category : #accessing }
GtPharoMethodTestCaseState >> label [
	"Return a textural representation"
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoMethodTestCaseState >> numberOfMethodsIn: aMethodsCoder [

	^ aMethodsCoder testSuite numberOfAllTestCasesWithState: self
]
