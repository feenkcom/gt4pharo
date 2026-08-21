"
Examples for creation code emitted by basic search filters.
"
Class {
	#name : #GtSearchBasicFiltersCreationStringExamples,
	#superclass : #GtSearchFiltersCreationStringExamples,
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #examples }
GtSearchBasicFiltersCreationStringExamples >> blockFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchBlockFilter forBlock: [ :each | each = 42 ].
	^ self
		assertCreatioCodeFor: filter
		equals: 'GtSearchBlockFilter forBlock: [ :each | each = 42 ]'
]

{ #category : #examples }
GtSearchBasicFiltersCreationStringExamples >> composedAndFilterSubstringAndExampleCreationCode [
	<gtExample>
	| filter |
	filter := 'home' gtSubstringLiteralMatch & #gtExample gtPragmas.
	^ self assertCreatioCodeFor: filter
		equals: ('''home'' gtSubstringLiteralMatch & #gtExample gtPragmas')
]

{ #category : #examples }
GtSearchBasicFiltersCreationStringExamples >> disjunctionFilterCreationCode [
	<gtExample>
	| filter |
	filter := 'home' gtSubstringLiteralMatch - #gtExample gtPragmas.
	^ self
		assertCreatioCodeFor: filter
		equals: '(''home'' gtSubstringLiteralMatch) - (#gtExample gtPragmas)'
]

{ #category : #examples }
GtSearchBasicFiltersCreationStringExamples >> intersectionFilterCreationCode [
	<gtExample>
	| filter |
	filter := 'home' gtSubstringLiteralMatch & #gtExample gtPragmas.
	^ self
		assertCreatioCodeFor: filter
		equals: '(''home'' gtSubstringLiteralMatch) & (#gtExample gtPragmas)'
]

{ #category : #examples }
GtSearchBasicFiltersCreationStringExamples >> labeledFilterCreationCode [
	<gtExample>
	| filter |
	filter := 'home' gtSubstringLiteralMatch labeled: 'Home methods'.
	^ self
		assertCreatioCodeFor: filter
		equals: '(''home'' gtSubstringLiteralMatch) labeled: ''Home methods'''
]

{ #category : #examples }
GtSearchBasicFiltersCreationStringExamples >> negationFilterCreationCode [
	<gtExample>
	| filter |
	filter := 'home' gtSubstringLiteralMatch not.
	^ self
		assertCreatioCodeFor: filter
		equals: '(''home'' gtSubstringLiteralMatch) not'
]

{ #category : #examples }
GtSearchBasicFiltersCreationStringExamples >> nullFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchNullFilter new
		equals: 'GtSearchNullFilter new'
]

{ #category : #examples }
GtSearchBasicFiltersCreationStringExamples >> unionFilterCreationCode [
	<gtExample>
	| filter |
	filter := 'home' gtSubstringLiteralMatch | #gtExample gtPragmas.
	^ self
		assertCreatioCodeFor: filter
		equals: '(''home'' gtSubstringLiteralMatch) | (#gtExample gtPragmas)'
]
