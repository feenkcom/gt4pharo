Class {
	#name : #GtPharoStreamingBehaviorMethodsCoderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoStreamingBehaviorMethodsCoderExamples >> forSuperclass [
	<gtExample>
	| aMethodsCoder theMethodCoders |
	
	aMethodsCoder := GtPharoStreamingBehaviorMethodsCoder forBehavior: GtPharoCoderMockedSuperClass.
	
	self assert: aMethodsCoder behavior equals: GtPharoCoderMockedSuperClass.
	self assert: aMethodsCoder classOrMetaClass equals: GtPharoCoderMockedSuperClass.
	self assert: aMethodsCoder isForClass.
	self assert: aMethodsCoder filter equals: (GtSearchSortedMethodsInInstanceAndClassSideFilter forClass: GtPharoCoderMockedSuperClass).
	self assert: aMethodsCoder additionalFilters equals: #().
	self assert: aMethodsCoder compositeFilter equals: (GtSearchSortedMethodsInInstanceAndClassSideFilter forClass: GtPharoCoderMockedSuperClass).
	self assert: aMethodsCoder itemsStream toArray wait equals: {
		GtPharoCoderMockedSuperClass >>#instanceMethodA
	}.
	
	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 1.
	self assert: theMethodCoders first behavior equals: GtPharoCoderMockedSuperClass.
	self assert: theMethodCoders first selector equals: #instanceMethodA.

	^ aMethodsCoder
]
