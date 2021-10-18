Class {
	#name : #GtPharoTestSuiteAptitudeExamples,
	#superclass : #GtPharoFourStateAptitudeExamples,
	#category : #'GToolkit-Pharo-Coder-Examples-Test Case'
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
		aTestSuite executableTestCasesDo: [ :aCoder :aTestCase | 
			anyOneExecuted ifFalse: [ 
				aTestCase play.
				anyOneExecuted := true ] ] ].

	^ anElement
]
