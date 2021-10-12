Class {
	#name : #GtPharoMethodTestCase,
	#superclass : #Object,
	#instVars : [
		'methodCoder',
		'result'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'instance creation' }
GtPharoMethodTestCase class >> forMethodCoder: aMethodCoder [

	^ self new methodCoder: aMethodCoder
]

{ #category : #'accessing - coder' }
GtPharoMethodTestCase >> behavior [
	^ self methodCoder behavior
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> canExecute [

	^ self methodCoder isNotNil and: [ 
		  self compiledMethod isNotNil and: [ 
			  self behavior isTestCase and: [ 
				  self behavior isAbstract not and: [ 
					  self compiledMethod isTestMethod ] ] ] ]
]

{ #category : #'accessing - coder' }
GtPharoMethodTestCase >> compiledMethod [
	^ self methodCoder compiledMethod
]

{ #category : #'api - execution' }
GtPharoMethodTestCase >> debug [

	self methodCoder ensureSave ifFalse: [ ^ self ].

	self rawDebug
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> hasResult [
	^ self result isNotNil
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> isError [

	^ self hasResult and: [ 
		  self result
			  isErrorFor: self behavior
			  selector: self methodSelector ]
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> isFailure [

	^ self hasResult and: [ 
		  self result
			  isFailureFor: self behavior
			  selector: self methodSelector ]
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> isPassed [

	^ self hasResult and: [ 
		  self result
			  isPassedFor: self behavior
			  selector: self methodSelector ]
]

{ #category : #accessing }
GtPharoMethodTestCase >> isSkipped [

	^ self hasResult and: [ self result skippedCount isZero not ]
]

{ #category : #accessing }
GtPharoMethodTestCase >> methodCoder [
	^ methodCoder
]

{ #category : #accessing }
GtPharoMethodTestCase >> methodCoder: aMethodCoder [ 
	methodCoder := aMethodCoder
]

{ #category : #'accessing - coder' }
GtPharoMethodTestCase >> methodSelector [
	^ self methodCoder currentSelector
]

{ #category : #'api - execution' }
GtPharoMethodTestCase >> play [

	self methodCoder ensureSave ifFalse: [ ^ self ].

	self rawPlay.
	self methodCoder notifyObjectSpawn: self.
]

{ #category : #execution }
GtPharoMethodTestCase >> rawDebug [
	self result: self testCaseInstance debug
]

{ #category : #execution }
GtPharoMethodTestCase >> rawPlay [
	self result: self testCaseInstance run.
]

{ #category : #'accessing - test case' }
GtPharoMethodTestCase >> result [
	<return: #TestResult>
	^ result
]

{ #category : #'accessing - test case' }
GtPharoMethodTestCase >> result: aTestCase [ 
	result := aTestCase
]

{ #category : #'accessing - test case' }
GtPharoMethodTestCase >> testCaseInstance [

	^ instance ifNil: [ 
		  instance := self behavior selector: self methodSelector ]
]
