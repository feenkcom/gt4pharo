Class {
	#name : #GtSearchMethodsContainedInClassFilterExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #assertions }
GtSearchMethodsContainedInClassFilterExamples >> assertMethodResultTypeForFilter: aFilter [
	self assert: aFilter resultType equals: GtAsyncSearchMethodGroupStream
]

{ #category : #accessing }
GtSearchMethodsContainedInClassFilterExamples >> inheritedMethodsWithTraits [
	<gtExample>
	^ self
		testFilter: ((GtSearchInheritedMethodsFilter forClass: GtBytecodeDebugger)
				withSuperclassesUpTo: ProtoObject)
		shouldInclude: {GtStackDebuggerElement >> #initializePanes.
				BlElement >> #zIndex:.
				BlElement >> #addEventFilter:.
				BlElement class >> #assert:}
		shouldExclude: {(Smalltalk at: #TraitedClass) >> #rebuildMethodDictionary}
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterExamples >> methodOnlyIncludedOnceInFilter [
	<gtExample>
	| filter |
	filter := (GtSearchMethodsInClassFilter forClass: Object) withSuperclasses
			withSubclasses & thisContext method selector gtImplementors.
	self assert: filter contents size equals: 1.
	^ filter
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterExamples >> methodOnlyIncludedOnceInInstVarFilter [
	<gtExample>
	| filter methods |
	filter := GtSearchInstanceSlotReferenceFilter
			forClass: OrderedCollection
			andVariable: 'array'.
	methods := filter contents.
	self assert: methods size equals: methods asSet size.
	^ filter
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterExamples >> methodsInClassFilter [
	<gtExample>
	^ self
		testFilter: (GtSearchMethodsInClassFilter forClass: GtSystemS1SubclassC2)
		shouldInclude: {GtSystemS1SubclassC2 >> #stubMethodInClassC2S1}
		shouldExclude: {GtSystemS1SubclassC2 class >> #stubMethodOnClassSideOfC2S1}
]

{ #category : #'examples - equality' }
GtSearchMethodsContainedInClassFilterExamples >> methodsInClassFilterEquality [
	<gtExample>
	| filter |
	filter := self methodsInClassFilter.
	self assert: filter equals: filter.
	self 
		assert: filter
		equals: (GtSearchMethodsInClassFilter forClass: GtSystemS1SubclassC2).
	^ filter
]

{ #category : #'examples - result type' }
GtSearchMethodsContainedInClassFilterExamples >> methodsInClassFilterResultType [
	<gtExample>
	| filter |
	filter := self methodsInClassFilter.
	self assertMethodResultTypeForFilter: filter.
	self assert: filter notEmpty.
	^ filter
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterExamples >> methodsInClassOnBothSidesFilter [
	<gtExample>
	^ self
		testFilter: (GtSearchMethodsInInstanceAndClassSideFilter
				forClass: GtSystemS1SubclassC2)
		shouldInclude: {GtSystemS1SubclassC2 >> #stubMethodInClassC2S1.
				GtSystemS1SubclassC2 class >> #stubMethodOnClassSideOfC2S1}
		shouldExclude: {}
]

{ #category : #'examples - equality' }
GtSearchMethodsContainedInClassFilterExamples >> methodsInClassOnBothSidesFilterEquality [
	<gtExample>
	| filter |
	filter := self methodsInClassOnBothSidesFilter.
	self assert: filter equals: filter.
	self 
		assert: filter
		equals: (GtSearchMethodsInInstanceAndClassSideFilter forClass: GtSystemS1SubclassC2).
	^ filter
]

{ #category : #accessing }
GtSearchMethodsContainedInClassFilterExamples >> methodsInClassUpToFilter [
	<gtExample>
	^ self
		testFilter: ((GtSearchMethodsInClassFilter forClass: OrderedCollection)
				withSuperclassesUpTo: Collection)
		shouldInclude: {OrderedCollection >> #add:.
				SequenceableCollection >> #first.
				Collection >> #add:.}
		shouldExclude: {
				Object >> #->.
				thisContext method}
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterExamples >> methodsInTwoClassesBothSidesUnionFilter [
	<gtExample>
	^self
		testFilter: (GtSearchUnionFilter new
				filter: (GtSearchMethodsInInstanceAndClassSideFilter forClass: GtSystemS1SubclassC2)
				filter: (GtSearchMethodsInInstanceAndClassSideFilter forClass: GtSystemS1AnotherClassC3))
		shouldInclude: {GtSystemS1AnotherClassC3 >> #oneMethodOnS1C3.
				GtSystemS1AnotherClassC3 class >> #isDeprecated.
				GtSystemS1SubclassC2 >> #stubMethodInClassC2S1.
				GtSystemS1SubclassC2 class >> #stubMethodOnClassSideOfC2S1}
		shouldExclude: {}
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterExamples >> methodsInTwoClassesUnionFilter [
	<gtExample>
	^ self
		testFilter: (GtSearchUnionFilter new
				filter: (GtSearchMethodsInClassFilter forClass: GtSystemS1SubclassC2)
				filter: (GtSearchMethodsInClassFilter forClass: GtSystemS1AnotherClassC3))
		shouldInclude: {GtSystemS1AnotherClassC3 >> #oneMethodOnS1C3.
				GtSystemS1SubclassC2 >> #stubMethodInClassC2S1}
		shouldExclude: {GtSystemS1AnotherClassC3 class >> #isDeprecated.
				GtSystemS1SubclassC2 class >> #stubMethodOnClassSideOfC2S1}
]

{ #category : #'examples - result type' }
GtSearchMethodsContainedInClassFilterExamples >> methodsInTwoClassesUnionFilterResultType [
	<gtExample>
	| filter |
	filter := self methodsInTwoClassesUnionFilter.
		
	self assertMethodResultTypeForFilter: filter.
		
	^ filter
]

{ #category : #accessing }
GtSearchMethodsContainedInClassFilterExamples >> methodsWithAllSuperclasses [
	<gtExample>
	^ self
		testFilter: ((GtSearchMethodsInClassFilter forClass: GtBytecodeDebugger) 
	withSuperclasses
	withSubclasses)
		shouldInclude: {GtStackDebuggerElement >> #initializePanes}
		shouldExclude: {}
]

{ #category : #'examples - result' }
GtSearchMethodsContainedInClassFilterExamples >> resultGroupForMethodsInClassFilter [
	<gtExample>
	| filter resultStream result |

	filter := self methodsInClassFilter.
	resultStream := filter result.
	
	self assert: resultStream class equals: GtAsyncSearchMethodGroupStream.
	self assert: resultStream filter equals: filter.
	
	result := resultStream toArray wait.
	self 
		assert: result size 
		equals: (GtSystemS1SubclassC2 instanceSide methods size).
	self assert: (result includes: GtSystemS1SubclassC2>>#stubMethodInClassC2S1).
	self assert: (result includes: GtSystemS1SubclassC2 class>>#stubMethodOnClassSideOfC2S1) not.

	^ resultStream
]

{ #category : #'examples - result' }
GtSearchMethodsContainedInClassFilterExamples >> resultGroupForMethodsInTwoClassesBothSidesUnionFilter [
	<gtExample>
	| filter resultStream result |

	filter := self methodsInTwoClassesBothSidesUnionFilter.

	resultStream := filter result.
	self assert: resultStream class equals: GtAsyncSearchMethodGroupStream.
	self assert: resultStream filter equals: filter.

	result := resultStream toArray wait.
	self 
		assert: result size 
		equals: (GtSystemS1SubclassC2 instanceSide methods size 
			+ GtSystemS1SubclassC2 classSide methods size
			+ GtSystemS1AnotherClassC3 instanceSide methods size
			+ GtSystemS1AnotherClassC3 classSide methods size).
	self assert: (result includes: GtSystemS1AnotherClassC3 class>>#isDeprecated).
	self assert: (result includes: GtSystemS1SubclassC2>>#stubMethodInClassC2S1).
	self assert: (result includes: GtSystemS1SubclassC2 class>>#stubMethodOnClassSideOfC2S1).

	^ resultStream
]

{ #category : #'examples - result' }
GtSearchMethodsContainedInClassFilterExamples >> resultGroupForMethodsInTwoClassesUnionFilter [
	<gtExample>
	| filter resultStream result |

	filter := self methodsInTwoClassesUnionFilter.

	resultStream := filter result.
	self assert: resultStream class equals: GtAsyncSearchMethodGroupStream.
	self assert: resultStream filter equals: filter.

	result := resultStream toArray wait.

	self 
		assert: result size
		equals: (GtSystemS1SubclassC2 instanceSide methods size 
			+ GtSystemS1AnotherClassC3 instanceSide methods size).

	self assert: (result includes: GtSystemS1AnotherClassC3>>#oneMethodOnS1C3).
	self assert: (result includes: GtSystemS1AnotherClassC3 class>>#isDeprecated) not.
	self assert: (result includes: GtSystemS1SubclassC2>>#stubMethodInClassC2S1).

	^ resultStream
]

{ #category : #accessing }
GtSearchMethodsContainedInClassFilterExamples >> testFilter: filter shouldInclude: inMethods shouldExclude: outMethods [
	"Checks that the filter includes and excludes some methods and the results reflect the same"

	| result |
	result := filter result toArray wait.
	inMethods
		do: [ :each | self assert: ((filter matches: each) and: [ result includes: each ]) ].
	outMethods
		do: [ :each | 
			self
				assert: ((filter matches: each) or: [ result includes: each ])
				equals: false ].
	^ filter
]
