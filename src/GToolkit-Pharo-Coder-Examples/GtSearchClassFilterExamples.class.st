Class {
	#name : #GtSearchClassFilterExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #assertions }
GtSearchClassFilterExamples >> assertClassResultTypeForFilter: aFilter [
	self assert: aFilter resultType equals: GtAsyncSearchClassGroupStream.
]

{ #category : #examples }
GtSearchClassFilterExamples >> classesInCurrentPackageFilter [
	<gtExample>
	| filter |
	filter := GtSearchClassesInPackageFilter forPackageNamed: 'GToolkit-Coder-Examples-SystemS1'.
	
	self assert: (filter matches: GtSystemS1SubclassC2).
	self assert: (filter matches: Object) not.
	
	^ filter
]

{ #category : #'examples - equality' }
GtSearchClassFilterExamples >> classesInCurrentPackageFilterEquality [
	<gtExample>
	| filter |
	filter := self classesInCurrentPackageFilter.
	self assert: filter equals: filter.
	self 
		assert: filter
		equals: (GtSearchClassesInPackageFilter forPackageNamed: 'GToolkit-Coder-Examples-SystemS1').
	^ filter
	
]

{ #category : #'examples - result type' }
GtSearchClassFilterExamples >> classesInCurrentPackageFilterResultType [
	<gtExample>
	| filter |
	filter := self classesInCurrentPackageFilter.
	self assert: filter defaultFilterScope equals: (AsyncPackageBehaviorsStream package: 'GToolkit-Coder-Examples-SystemS1' asPackage).
	self assertClassResultTypeForFilter: filter.
	^ filter
]

{ #category : #examples }
GtSearchClassFilterExamples >> classesInImageFilter [
	<gtExample>
	| filter |
	filter := GtSearchImageClassesFilter new.
	
	self assert: (filter matches: GtSystemS1SubclassC2).
	self assert: (filter matches: Object).
	
	^ filter
]

{ #category : #'examples - equality' }
GtSearchClassFilterExamples >> classesInImageFilterEquality [
	<gtExample>
	| filter |
	filter := self classesInImageFilter.
	self assert: filter equals: filter.
	self assert: filter equals: GtSearchImageClassesFilter new.
	^ filter
	
]

{ #category : #'examples - result type' }
GtSearchClassFilterExamples >> classesInImageFilterResultType [
	<gtExample>
	| filter |

	filter := self classesInImageFilter.
	self assert: filter defaultFilterScope equals: AsyncImageBehaviorsStream new.
	self assertClassResultTypeForFilter: filter.

	^ filter
	
]

{ #category : #'as yet unclassified' }
GtSearchClassFilterExamples >> classFilterIsNotAllGtSearchMethodsFilterKind [
	<gtExample>
	| filter |
	filter := self classesInCurrentPackageFilter select: [:each | true ].
	self assert: filter gtAreAllGtSearchMethodsFilterKind not.
	^ filter
]

{ #category : #examples }
GtSearchClassFilterExamples >> deprecatedClassesFilter [
	<gtExample>
	| filter |
	filter := GtSearchDeprecatedClassesFilter new.
	self assert: (filter matches: GtSystemS1AnotherClassC3).
	self assert: (filter matches: GtSystemS1RootClassC1) not.
	^ filter
]

{ #category : #'examples - result type' }
GtSearchClassFilterExamples >> deprecatedClassesFilterResultType [
	<gtExample>
	| filter |
	filter := self deprecatedClassesFilter.
	self assert: filter defaultFilterScope equals: AsyncImageBehaviorsStream new.
	self assertClassResultTypeForFilter: filter.
	^ filter
]

{ #category : #examples }
GtSearchClassFilterExamples >> deprecatedClassesInPackageScopeFilter [
	<gtExample>
	"Use an intersection filter that uses the package filter as the first filter in the intersection."
	| filter |

	filter := GtSearchIntersectionFilter new
		filter: self classesInCurrentPackageFilter
		filter: GtSearchDeprecatedClassesFilter new.
	
	self assert: (filter matches: GtSystemS1AnotherClassC3).
	self assert: (filter matches: GtSystemS1RootClassC1) not.
	self assert: filter defaultFilterScope equals: filter leftFilter defaultFilterScope.
	self assertClassResultTypeForFilter: filter.

	^ filter
]

{ #category : #examples }
GtSearchClassFilterExamples >> deprecatedClassesInPackageUsingImageScopeFilter [
	<gtExample>
	"Start first with the deprecated filter. This has as scope the entire image."
	| filter |

	filter := GtSearchIntersectionFilter new
		filter: self classesInCurrentPackageFilter
		filter: GtSearchDeprecatedClassesFilter new.
	
	self assert: (filter matches: GtSystemS1AnotherClassC3).
	self assert: (filter matches: GtSystemS1RootClassC1) not.
	self assert: filter size equals: 1.
	self assert: filter defaultFilterScope equals: (AsyncPackageBehaviorsStream package: 'GToolkit-Coder-Examples-SystemS1' asPackage).
	self assertClassResultTypeForFilter: filter.
	
	^ filter
	
]

{ #category : #'examples - result' }
GtSearchClassFilterExamples >> groupResultForClassesInImageFilter [
	<gtExample>
	| filter resultStream result |

	filter := self classesInImageFilter.

	resultStream := filter result.
	self assert: resultStream class equals: GtAsyncSearchClassGroupStream.
	self assert: resultStream filter equals: filter.
	self assert: resultStream scope class equals: AsyncImageBehaviorsStream.

	result := resultStream toArray wait.

	self assert: result size equals: Smalltalk allClassesAndTraits size.
	self assert: (result includes: GtSystemS1SubclassC2).
	self assert: (result includes: Object).
	
	^ resultStream
]

{ #category : #'examples - result' }
GtSearchClassFilterExamples >> groupResultForClassesInPackageFilter [
	<gtExample>
	| filter resultStream result |
	
	filter := self classesInCurrentPackageFilter.
	
	resultStream := filter result.
	self assert: resultStream class equals: GtAsyncSearchClassGroupStream.
	self assert: resultStream filter equals: filter.
	self assert: resultStream scope equals: (AsyncPackageBehaviorsStream package: 'GToolkit-Coder-Examples-SystemS1' asPackage).
	
	result := resultStream toArray wait.

	self assert: result size equals: 5.
	self assert: (result includes: GtSystemS1SubclassC2).
	self assert: (result includes: Object) not.
	
	^ resultStream
]

{ #category : #'examples - result' }
GtSearchClassFilterExamples >> groupResultForDeprecatedClassesInPackageScopeFilter [
	<gtExample>
	| filter resultStream result |

	filter := self deprecatedClassesInPackageScopeFilter.

	resultStream := filter result.
	self assert: resultStream class equals: GtAsyncSearchClassGroupStream.
	self assert: resultStream filter equals: filter.
	self assert: resultStream scope equals: filter leftFilter result scope.

	result := resultStream toArray wait.
	self assert: result size equals: 1.
	self assert: (result includes: GtSystemS1AnotherClassC3).
	self assert: (result includes: GtSystemS1RootClassC1) not.
	
	^ resultStream
]

{ #category : #examples }
GtSearchClassFilterExamples >> testClassesFilter [
	<gtExample>
	| filter |
	filter := GtSearchTestClassesFilter new.
	
	self assert: (filter matches: BlockClosureTest).
	self assert: (filter matches: ArrayTest).
	
	^ filter
	
]

{ #category : #examples }
GtSearchClassFilterExamples >> testClassesFilterInPackage [
	<gtExample>
	| filter |
	
	filter := GtSearchIntersectionFilter new
		filter: GtSearchTestClassesFilter new
		filter: (GtSearchClassesInPackageFilter forPackageNamed: 'Kernel-Tests').
	
	self assert: (filter matches: BlockClosureTest).
	self assert: (filter matches: ArrayTest) not.
	
	^ filter
	
]
