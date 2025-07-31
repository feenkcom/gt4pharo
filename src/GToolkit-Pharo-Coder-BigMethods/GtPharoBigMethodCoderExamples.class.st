Class {
	#name : #GtPharoBigMethodCoderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-BigMethods-Examples'
}

{ #category : #'as yet unclassified' }
GtPharoBigMethodCoderExamples >> forClassWithBigMethod [
	<gtExample>
	| aMethodsCoder theMethodCoders |
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: GtBigMethodTestClass.
	self
		assert: aMethodsCoder itemsStream toArray wait
		equals: {GtBigMethodTestClass >> #reduceTable.
				GtBigMethodTestClass >> #testMethod1.
				GtBigMethodTestClass >> #testMethod2}.

	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 3.
	self
		assert: theMethodCoders first class
		equals: GtPharoBigMethodCoder.
	self assert: theMethodCoders first selector equals: #reduceTable.
	self
		assert: theMethodCoders second class
		equals: GtPharoMethodCoder.
	self assert: theMethodCoders second selector equals: #testMethod1.
	self
		assert: theMethodCoders third class
		equals: GtPharoMethodCoder.
	self assert: theMethodCoders third selector equals: #testMethod2.
	^ aMethodsCoder
]

{ #category : #'as yet unclassified' }
GtPharoBigMethodCoderExamples >> forClassWithUnsearchableMethod [
	<gtExample>
	| aMethodsCoder theMethodCoders aCompiledMethod aClass |
	"Create a method which is unsearchable"
	aClass := GtBigMethodTestClass copy.
	aClass compileAllFrom: GtBigMethodTestClass.
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: aClass.
	aCompiledMethod := aClass >> #reduceTable infect: 'isSourceSearchable ^false'.
	
	self
		assert: aMethodsCoder itemsStream toArray wait
		equals: {aClass >> #reduceTable.
				aClass >> #testMethod1.
				aClass >> #testMethod2}.

	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 3.
	self assert: theMethodCoders first class equals: GtPharoMethodCoder.
	self assert: theMethodCoders first selector equals: #reduceTable.
	self assert: theMethodCoders second class equals: GtPharoMethodCoder.
	self assert: theMethodCoders second selector equals: #testMethod1.
	self assert: theMethodCoders third class equals: GtPharoMethodCoder.
	self assert: theMethodCoders third selector equals: #testMethod2.
	^ aMethodsCoder
]
