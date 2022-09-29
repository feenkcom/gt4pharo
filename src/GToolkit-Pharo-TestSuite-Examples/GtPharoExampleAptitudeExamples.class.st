Class {
	#name : #GtPharoExampleAptitudeExamples,
	#superclass : #GtPharoFourStateAptitudeExamples,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #accessing }
GtPharoExampleAptitudeExamples >> aptitudeClass [
	<gtExample>
	^ GtPharoExampleAptitude
]

{ #category : #accessing }
GtPharoExampleAptitudeExamples >> buttonWithAptitudeAndMethodCoders [

	<gtExample>
	| aButton |
	aButton := super buttonWithAptitudeAndMethodCoders.
	aButton action: [ :theButton | 
		theButton aptitude coderDo: [ :aCoder | 
			aCoder testSuite playSelectedFrom: theButton ] ].
			
	^ aButton
]

{ #category : #accessing }
GtPharoExampleAptitudeExamples >> buttonWithAptitudeAndMethodCoders_Executed [

	<gtExample>
	| anElement |
	anElement := self buttonWithAptitudeAndMethodCoders.
	anElement aptitude examplerDo: [ :anExampler | 
		| anyOneExecuted |
		anyOneExecuted := false.
		anExampler allExecutableExampleCodersDo: [ :aCoder :anExample | 
			anyOneExecuted ifFalse: [ 
				anExample run.
				anyOneExecuted := true ] ] ].

	^ anElement
]

{ #category : #'examples - coder' }
GtPharoExampleAptitudeExamples >> methodsCoders [
	<gtExample>
	| aCoder |
	aCoder := GtClassMethodsCoder forClass: GtPharoMethodTestCaseExamples.
	
	self
		assert: aCoder coders size > 1
		description: [ 'There must be some method coders' ].

	^ aCoder
]
