"
Examples for creation code emitted by scoped method search filters.
"
Class {
	#name : #GtSearchScopedMethodsFiltersCreationStringExamples,
	#superclass : #GtSearchFiltersCreationStringExamples,
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #examples }
GtSearchScopedMethodsFiltersCreationStringExamples >> classScopeCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchScopedMethodsFilter new
		scope: (GtSearchScopedMethodsClassScope new itemClass: Object).
	^ self
		assertCreatioCodeFor: filter
		equals: 'GtSearchScopedMethodsFilter new scope: ((GtSearchScopedMethodsClassScope new) itemClass: Object)'
]

{ #category : #examples }
GtSearchScopedMethodsFiltersCreationStringExamples >> defaultScopeCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchScopedMethodsFilter new
		equals: 'GtSearchScopedMethodsFilter new scope: (GtSearchScopedMethodsAllScope default)'
]

{ #category : #examples }
GtSearchScopedMethodsFiltersCreationStringExamples >> packagePatternScopeCustomOrderCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchScopedMethodsFilter new
		scope: (GtSearchScopedMethodsPackagePatternScope new
			pattern: 'GToolkit-*';
			order: 17).
	^ self
		assertCreatioCodeFor: filter
		equals: 'GtSearchScopedMethodsFilter new scope: ((GtSearchScopedMethodsPackagePatternScope new) pattern: ''GToolkit-*''; order: 17)'
]
