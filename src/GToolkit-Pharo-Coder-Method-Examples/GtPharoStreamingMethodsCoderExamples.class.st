Class {
	#name : #GtPharoStreamingMethodsCoderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoStreamingMethodsCoderExamples >> forClassWithTrait [
	<gtExample>
	| aMethodsCoder theMethodCoders |
	aMethodsCoder := GtPharoStreamingMethodsCoder
			forBehavior: GtPharoDummyObjectFour.

	self assert: aMethodsCoder behavior equals: GtPharoDummyObjectFour.
	self assert: aMethodsCoder classOrMetaClass equals: GtPharoDummyObjectFour.
	self assert: aMethodsCoder isForClass.
	self
		assert: aMethodsCoder filter
		equals: ((GtSearchInheritedMethodsFilter forClass: GtPharoDummyObjectFour)
				withSuperclassesUpTo: ProtoObject).
	self
		assert: aMethodsCoder additionalFilters
		equals: {(GtSearchInheritedMethodsFilter forClass: GtPharoDummyObjectFour)
					withSuperclassesUpTo: GtPharoDummyObjectFour.
					GtSearchMethodCategoryFilter forCategory: GtAllProtocol defaultName }.

	self
		assert: aMethodsCoder itemsStream toArray wait
		equals: {GtPharoDummyObjectFour >> #instanceSideMethodOne.
				GtPharoDummyObjectFour >> #instanceSideMethodTwo.
				GtPharoDummyObjectFour class >> #classSideMethodOne.
				GtPharoDummyObjectFour class >> #classSideMethodTwo}.

	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 4.
	self assert: theMethodCoders first behavior equals: GtPharoDummyObjectFour.
	self assert: theMethodCoders first selector equals: #instanceSideMethodOne.
	self assert: theMethodCoders second behavior equals: GtPharoDummyObjectFour.
	self assert: theMethodCoders second selector equals: #instanceSideMethodTwo.
	self
		assert: theMethodCoders third behavior
		equals: GtPharoDummyObjectFour class.
	self assert: theMethodCoders third selector equals: #classSideMethodOne.
	self
		assert: theMethodCoders fourth behavior
		equals: GtPharoDummyObjectFour class.
	self assert: theMethodCoders fourth selector equals: #classSideMethodTwo.

	^ aMethodsCoder
]

{ #category : #examples }
GtPharoStreamingMethodsCoderExamples >> forSuperclass [
	<gtExample>
	| aMethodsCoder theMethodCoders |
	aMethodsCoder := GtPharoStreamingMethodsCoder
			forBehavior: GtPharoCoderMockedSuperclass.

	self assert: aMethodsCoder behavior equals: GtPharoCoderMockedSuperclass.
	self
		assert: aMethodsCoder classOrMetaClass
		equals: GtPharoCoderMockedSuperclass.
	self assert: aMethodsCoder isForClass.
	self
		assert: aMethodsCoder filter
		equals: ((GtSearchInheritedMethodsFilter forClass: GtPharoCoderMockedSuperclass)
				withSuperclassesUpTo: ProtoObject).
	self
		assert: aMethodsCoder additionalFilters
		equals: {(GtSearchInheritedMethodsFilter forClass: GtPharoCoderMockedSuperclass)
					withSuperclassesUpTo: GtPharoCoderMockedSuperclass.
					GtSearchMethodCategoryFilter forCategory: GtAllProtocol defaultName}.
	self
		assert: aMethodsCoder itemsStream toArray wait
		equals: {GtPharoCoderMockedSuperclass >> #instanceMethodA.
				GtPharoCoderMockedSuperclass >> #instanceMethodB.
				GtPharoCoderMockedSuperclass class >> #classMethodA.
				GtPharoCoderMockedSuperclass class >> #classMethodB}.

	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 4.
	self
		assert: theMethodCoders first behavior
		equals: GtPharoCoderMockedSuperclass.
	self assert: theMethodCoders first selector equals: #instanceMethodA.
	self
		assert: theMethodCoders second behavior
		equals: GtPharoCoderMockedSuperclass.
	self assert: theMethodCoders second selector equals: #instanceMethodB.
	self
		assert: theMethodCoders third behavior
		equals: GtPharoCoderMockedSuperclass class.
	self assert: theMethodCoders third selector equals: #classMethodA.
	self
		assert: theMethodCoders fourth behavior
		equals: GtPharoCoderMockedSuperclass class.
	self assert: theMethodCoders fourth selector equals: #classMethodB.
	^ aMethodsCoder
]

{ #category : #examples }
GtPharoStreamingMethodsCoderExamples >> forTrait [
	<gtExample>
	| aMethodsCoder theMethodCoders |
	aMethodsCoder := GtPharoStreamingMethodsCoder
			forBehavior: TGtPharoDummyTraitFour.

	self assert: aMethodsCoder behavior equals: TGtPharoDummyTraitFour.
	self
		assert: aMethodsCoder classOrMetaClass
		equals: TGtPharoDummyTraitFour.
	self assert: aMethodsCoder isForClass.
	self
		assert: aMethodsCoder filter
		equals: ((GtSearchInheritedMethodsFilter forClass: TGtPharoDummyTraitFour)
				withSuperclassesUpTo: ProtoObject).
	self
		assert: aMethodsCoder additionalFilters
		equals: {(GtSearchInheritedMethodsFilter forClass: TGtPharoDummyTraitFour)
					withSuperclassesUpTo: TGtPharoDummyTraitFour.
					GtSearchMethodCategoryFilter forCategory: GtAllProtocol defaultName}.
					
	self
		assert: aMethodsCoder itemsStream toArray wait
		equals: {TGtPharoDummyTraitFour >> #instanceSideMethodOne.
				TGtPharoDummyTraitFour class >> #classSideMethodOne}.
				
	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 2.
	self
		assert: theMethodCoders first behavior
		equals: TGtPharoDummyTraitFour.
	self assert: theMethodCoders first selector equals: #instanceSideMethodOne.
	self
		assert: theMethodCoders second behavior
		equals: TGtPharoDummyTraitFour classTrait.
	self assert: theMethodCoders second selector equals: #classSideMethodOne.
	
	^ aMethodsCoder
]
