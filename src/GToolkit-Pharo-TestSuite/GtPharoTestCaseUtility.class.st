Class {
	#name : #GtPharoTestCaseUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Utility'
}

{ #category : #'api - testing' }
GtPharoTestCaseUtility class >> hasConcreteSubclasses: aClass [

	aClass allSubclassesDo: [ :eachClass | 
		eachClass isAbstract ifFalse: [ ^ true ] ].

	^ false
]
