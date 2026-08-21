"
Creation-code examples for class search filters.
"
Class {
	#name : #GtSearchClassesFiltersCreationStringExamples,
	#superclass : #GtSearchFiltersCreationStringExamples,
	#category : #'GToolkit-Pharo-SearchFilters-Examples-Examples'
}

{ #category : #'examples - parameterized' }
GtSearchClassesFiltersCreationStringExamples >> classesInPackageFilterCreationCode [
	<gtExample>
	| package filter |
	package := 'GToolkit-Pharo-SearchFilters' asPackage.
	filter := GtSearchClassesInPackageFilter forPackageNamed: package name.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchClassesInPackageFilter forPackageNamed: ''GToolkit-Pharo-SearchFilters'''.
	self assert: filter package equals: package.
	^ self wrappedCreationCodeFor: filter
]

{ #category : #'examples - stateless' }
GtSearchClassesFiltersCreationStringExamples >> deprecatedClassesFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchDeprecatedClassesFilter new.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchDeprecatedClassesFilter new'.
	^ self wrappedCreationCodeFor: filter
]

{ #category : #'examples - packages' }
GtSearchClassesFiltersCreationStringExamples >> deprecatedPackagesFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchDeprecatedPackagesFilter new.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchDeprecatedPackagesFilter new'.
	^ self wrappedCreationCodeFor: filter
]

{ #category : #'examples - stateless' }
GtSearchClassesFiltersCreationStringExamples >> imageClassesFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchImageClassesFilter new.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchImageClassesFilter new'.
	^ self wrappedCreationCodeFor: filter
]

{ #category : #'examples - packages' }
GtSearchClassesFiltersCreationStringExamples >> imagePackagesFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchImagePackagesFilter new.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchImagePackagesFilter new'.
	^ self wrappedCreationCodeFor: filter
]

{ #category : #'examples - parameterized' }
GtSearchClassesFiltersCreationStringExamples >> subclassesFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchSubclassesFilter forClass: Object.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchSubclassesFilter forClass: Object'.
	self assert: filter searchClass equals: Object.
	^ self wrappedCreationCodeFor: filter
]

{ #category : #'examples - stateless' }
GtSearchClassesFiltersCreationStringExamples >> testClassesFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchTestClassesFilter new.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchTestClassesFilter new'.
	^ self wrappedCreationCodeFor: filter
]
