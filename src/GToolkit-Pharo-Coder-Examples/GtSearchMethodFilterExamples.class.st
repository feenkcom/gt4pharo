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
	self assert: (filter matches: thisContext method).
	^ filter
]

{ #category : #examples }
GtSearchMethodFilterExamples >> implementorsOfThisMessage [
	<gtExample>
	| filter |
	filter := #implementorsOfThisMessage gtImplementors.
	self assert: filter notEmpty.
	self assert: (filter matches: thisContext method).
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
GtSearchMethodFilterExamples >> methodsInPackageFilter [
	<gtExample>
	| filter |
	
	filter := GtSearchMethodsInPackageFilter new package: (thisContext method package).
	self assert: filter notEmpty.
	self assert: (filter matches: thisContext method).	
	^ filter.
]

{ #category : #examples }
GtSearchMethodFilterExamples >> methodsWithClassPatternFilter [
	<gtExample>
	| filter |
	filter := GtSearchMethodsWithClassPatternFilter pattern: #FilterExamples.
	self assert: filter notEmpty.
	self assert: (filter matches: thisContext method).
	
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
