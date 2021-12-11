Class {
	#name : #GtPharoStreamingMethodsCoderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoStreamingMethodsCoderExamples >> forSuperclass [
	<gtExample>
	| aMethodsCoder theMethodCoders |
	
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: GtPharoCoderMockedSuperclass.
	
	self assert: aMethodsCoder behavior equals: GtPharoCoderMockedSuperclass.
	self assert: aMethodsCoder classOrMetaClass equals: GtPharoCoderMockedSuperclass.
	self assert: aMethodsCoder isForClass.
	self assert: aMethodsCoder filter equals: (GtSearchSortedMethodsInInstanceAndClassSideFilter forClass: GtPharoCoderMockedSuperclass).
	self assert: aMethodsCoder additionalFilters equals: #().
	self assert: aMethodsCoder compositeFilter equals: (GtSearchSortedMethodsInInstanceAndClassSideFilter forClass: GtPharoCoderMockedSuperclass).
	self assert: aMethodsCoder itemsStream toArray wait equals: {
		GtPharoCoderMockedSuperclass >> #instanceMethodA.
		GtPharoCoderMockedSuperclass >> #instanceMethodB.
		GtPharoCoderMockedSuperclass class >> #classMethodA.
		GtPharoCoderMockedSuperclass class >> #classMethodB.
	}.
	
	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 4.
	self assert: theMethodCoders first behavior equals: GtPharoCoderMockedSuperclass.
	self assert: theMethodCoders first selector equals: #instanceMethodA.
	self assert: theMethodCoders second behavior equals: GtPharoCoderMockedSuperclass.
	self assert: theMethodCoders second selector equals: #instanceMethodB.
	self assert: theMethodCoders third behavior equals: GtPharoCoderMockedSuperclass class.
	self assert: theMethodCoders third selector equals: #classMethodA.
	self assert: theMethodCoders fourth behavior equals: GtPharoCoderMockedSuperclass class.
	self assert: theMethodCoders fourth selector equals: #classMethodB.
	^ aMethodsCoder
]
