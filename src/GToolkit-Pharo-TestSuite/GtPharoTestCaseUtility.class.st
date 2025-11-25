Class {
	#name : #GtPharoTestCaseUtility,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-TestSuite-Utility'
}

{ #category : #'api - testing' }
GtPharoTestCaseUtility class >> canExecuteTestCase: aCompiledMethod [
	aCompiledMethod ifNil: [ ^ false ].
	aCompiledMethod methodClass isTestCase ifFalse: [ ^ false ].
	(aCompiledMethod methodClass isAbstract
		and: [ (self hasConcreteSubclasses: aCompiledMethod methodClass) not ])
		ifTrue: [ ^ false ].

	^ aCompiledMethod selector isTestSelector
]

{ #category : #'api - testing' }
GtPharoTestCaseUtility class >> hasConcreteSubclasses: aClass [

	aClass allSubclassesDo: [ :eachClass | 
		eachClass isAbstract ifFalse: [ ^ true ] ].

	^ false
]
