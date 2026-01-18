"
# Method filter examples

## Implementors

{{gtExample:GtSearchMethodFilterExamples>>#implementorsOfThisMessage}}

## Package pattern

{{gtExample:GtSearchMethodFilterExamples>>#packagePatternFilter}}

## Pragmas

{{gtExample:GtMethodsCoderExamples>>#gtExamplesFilter}}


## References

`gtReferences` can be applied to several objects. 

Class references:
{{gtExample:GtSearchMethodReferencesFilterExamples>>#referencesToSampleB|previewShow=gtItemsFor:}}

Selector references:
{{gtExample:GtSearchMethodReferencesFilterExamples>>#referencesToThisSelector}}

Number references
{{gtExample:GtSearchMethodReferencesFilterExamples>>#referencesTo42}}

## Intersection

{{gtExample:GtSearchMethodReferencesFilterExamples>>#gtExamplePragmasAndReferencesToMethodCoder}}

## Union

[[TODO]] 



"
Class {
	#name : #GtSearchMethodFilterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #asserting }
GtSearchMethodFilterExamples >> assertMethodResultTypeForFilter: aFilter [
	self assert: aFilter resultType equals: GtAsyncSearchMethodGroupStream
]

{ #category : #accessing }
GtSearchMethodFilterExamples >> astFilterExample [
	<gtExample>
	^ '^0' gtASTMatches
]

{ #category : #examples }
GtSearchMethodFilterExamples >> astPatternFilter [
	<gtExample>
	| filter |
	filter := 'filter matches: ``@a' gtASTMatches.
	self assert: filter notEmpty.
	self assert: (filter matches: thisContext method).
	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> deprecatedMethodsFilter [
	<gtExample>
	| filter |
	
	filter := GtSearchDeprecatedMethodsFilter new.
	self assert: filter notEmpty.
	self assert: (filter matches: BlElement>>#extent:).
	self assert: (filter matches: BlElement>>#margin) not.
	
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> gtExamplePragmas [
	<gtExample>
	| filter |
	filter := #gtExample gtPragmas.
	self assert: filter notEmpty.
	self assert: (filter matches: GtSearchMethodFilterExamples>>#gtExamplePragmas).
	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> implementorsOfThisMessage [
	<gtExample>
	| filter |
	filter := #implementorsOfThisMessage gtImplementors.
	self assert: filter notEmpty.
	self assert: (filter matches: GtSearchMethodFilterExamples>>#implementorsOfThisMessage).
	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> implementorsPatternFilter [
	<gtExample>
	| filter |
	filter := GtSearchImplementorPatternFilter pattern: #implementorsPattern.
	self assert: filter notEmpty.
	self assert: (filter matches: thisContext method).
	
	^ filter.
]

{ #category : #'as yet unclassified' }
GtSearchMethodFilterExamples >> intersectionFilterIsAllGtSearchMethodsFilterKind [
	<gtExample>
	| filter |
	filter := self referencesFilterIsAllGtSearchMethodsFilterKind & BlElement gtMethodsInClass.
	self assert: filter gtAreAllGtSearchMethodsFilterKind.
	^ filter
]

{ #category : #'examples - method conditions' }
GtSearchMethodFilterExamples >> methodConditionsFilter_Default [
	<gtExample>
	| filter |
	
	filter := GtSearchMethodConditionsFilter new.
	"By default all methods satisfy the filter"
	self assert: (filter matches: GtSearchMethodConditionsFilter>>#conditions).
	
	^ filter.
]

{ #category : #'examples - method conditions' }
GtSearchMethodFilterExamples >> methodConditionsFilter_OneCondition [
	<gtExample>
	| filter |
	
	filter := GtSearchMethodConditionsFilter 
		condition: [ :aMethod | aMethod numArgs isZero ].
	
	self assert: (filter matches: GtSearchMethodConditionsFilter>>#conditions).
	self assert: (filter matches: GtSearchMethodConditionsFilter>>#condition:) not.
	
	^ filter.
]

{ #category : #'examples - method conditions' }
GtSearchMethodFilterExamples >> methodConditionsFilter_SubclassRerence [
	<gtExample>
	| filter |
	
	filter := GtSearchMethodConditionsFilter new
		referenceSubclass: OrderedCollection.
	
	self assert: (filter matches: GtSearchMethodConditionsFilter>>#initialize).
	self assert: (filter matches: GtSearchMethodConditionsFilter>>#condition:) not.
	
	^ filter.
]

{ #category : #'examples - method conditions' }
GtSearchMethodFilterExamples >> methodConditionsFilter_TwoConditions [
	<gtExample>
	| filter |
	filter := GtSearchMethodConditionsFilter new
			condition: [ :aMethod | aMethod numArgs = 1 ];
			condition: [ :aMethod | aMethod protocolName = #'api - accessing' ].

	self assert: (filter matches: GtSearchMethodConditionsFilter >> #condition:).
	self
		assert: (filter matches: GtSearchMethodConditionsFilter >> #conditions) not.

	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> methodsInCategoryFilter [
	<gtExample>
	| filter |
	filter := GtSearchMethodCategoryFilter forCategory: 'examples'.
	self assert: filter notEmpty.
	self assert: (filter matches: thisContext method).
	
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> methodsInClassFilter [
	<gtExample>
	| filter |
	filter := GtSearchMethodFilterExamples gtMethodsInClass.
	self assert: filter notEmpty.
	self assert: (filter matches: GtSearchMethodFilterExamples>>#methodsInClassFilter).
	
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> methodsInPackageFilter [
	<gtExample>
	| filter |
	
	filter := 'GToolkit-Pharo-Coder-Examples' asPackage gtMethodsInPackage.
	self assert: filter notEmpty.
	self assert: (filter matches: GtSearchMethodFilterExamples>>#methodsInPackageFilter).	
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> methodsWithClassPatternFilter [
	<gtExample>
	| filter |
	filter := #FilterExamples gtClassMatches.
	self assert: filter notEmpty.
	self assert: (filter matches: GtSearchMethodFilterExamples>>#methodsWithClassPatternFilter).
	
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> methodsWithClassReferencesFilter [
	<gtExample>
	| filter |
	filter := GtSearchMethodFilterExamples gtReferences.
	self assert: filter notEmpty.
	self assert: (filter matches: GtSearchMethodFilterExamples>>#methodsWithClassReferencesFilter).
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> methodsWithSubstringLiteralFilter [
	<gtExample>
	| filter |
	filter := 'empty' gtSubstringLiteralMatch.
	self assert: filter notEmpty description: 'it should not be empty'.
	self assert: (filter matches: GtSearchMethodFilterExamples>>#methodsWithSubstringLiteralFilter).
	
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> packagePatternFilter [
	<gtExample>
	| filter |
	filter := 'coder-examples' gtPackageMatches.
	self assert: filter notEmpty.
	self assert: (filter matches: thisContext method).
	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> referencesFilterIsAllGtSearchMethodsFilterKind [
	<gtExample>
	| filter |
	filter := #childrenDo: gtReferences.
	self assert: filter gtAreAllGtSearchMethodsFilterKind.
	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> referencesOfReferences [
	<gtExample>
	| filter |
	filter := #assert: gtReferences.
	self assert: filter notEmpty.
	self assert: (filter matches: GtSearchMethodFilterExamples>>#referencesOfReferences).
	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> selectFilterIsAllGtSearchMethodsFilterKind [
	<gtExample>
	| filter |
	filter := self referencesFilterIsAllGtSearchMethodsFilterKind select: [:each | each methodClass = BlElement ].
	self assert: filter gtAreAllGtSearchMethodsFilterKind.
	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> uncategorizedMethodsFilter_doNotMatchCategorizedMethod [
	<gtExample>
	| filter |
	filter := GtSearchMethodCategoryFilter forCategory: Protocol unclassified.
	
	self assert: filter notEmpty.
	self assert: (filter matches: thisContext method) not.
	
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> uncategorizedMethodsilter_matchUncategorizedMethod [
	<gtExample>
	| filter |
	filter := GtSearchMethodCategoryFilter forCategory: Protocol unclassified.

	self assert: filter notEmpty.
	self assert: (filter 
		matches: GtFilterStubSampleA>>#uncategoriedMethodForFilter).
	
	^ filter.
]

{ #category : #'as yet unclassified' }
GtSearchMethodFilterExamples >> unionFilterIsAllGtSearchMethodsFilterKind [
	<gtExample>
	| filter |
	filter := #childrenDo: gtReferences | #children gtReferences.
	self assert: filter gtAreAllGtSearchMethodsFilterKind.
	^ filter
]
