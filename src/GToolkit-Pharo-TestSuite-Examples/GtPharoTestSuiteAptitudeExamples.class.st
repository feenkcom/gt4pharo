Class {
	#name : #GtPharoTestSuiteAptitudeExamples,
	#superclass : #GtPharoFourStateAptitudeExamples,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #accessing }
GtPharoTestSuiteAptitudeExamples >> aptitudeClass [
	<gtExample>
	^ GtPharoTestSuiteAptitude
]

{ #category : #accessing }
GtPharoTestSuiteAptitudeExamples >> buttonWithAptitudeAndMethodCoders [

	<gtExample>
	| aButton |
	aButton := super buttonWithAptitudeAndMethodCoders.
	aButton action: [ :theButton | 
		theButton aptitude coderDo: [ :aCoder | 
			aCoder testSuite playSelectedFrom: theButton ] ].
			
	^ aButton
]

{ #category : #accessing }
GtPharoTestSuiteAptitudeExamples >> buttonWithAptitudeAndMethodCoders_Executed [

	<gtExample>
	| anElement |
	anElement := self buttonWithAptitudeAndMethodCoders.
	anElement aptitude testSuiteDo: [ :aTestSuite | 
		| anyOneExecuted |
		anyOneExecuted := false.
		aTestSuite allExecutableTestCasesDo: [ :aCoder :aTestCase | 
			anyOneExecuted ifFalse: [ 
				aTestCase play.
				anyOneExecuted := true ] ] ].

	^ anElement
]

{ #category : #'examples - coder' }
GtPharoTestSuiteAptitudeExamples >> methodsCoders [

	<gtExample>
	| aCoder |
	aCoder := GtClassMethodsCoder forClass: GtPharoDummyTestCase.
	
	self
		assert: aCoder coders size > 1
		description: [ 'There must be some method coders' ].

	^ aCoder
]

{ #category : #'examples - coder' }
GtPharoTestSuiteAptitudeExamples >> methodsCoders_Executed [
	<gtExample>
	<noTest>
	| aMethodsCoder anyOneExecuted |
	aMethodsCoder := self methodsCoders.

	anyOneExecuted := false.
	aMethodsCoder testSuite allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		anyOneExecuted ifFalse: [ 
			aTestCase play.
			anyOneExecuted := true ] ].

	self
		assert: anyOneExecuted
		description: 'At least one test case must be executed'.

	^ aMethodsCoder
]
