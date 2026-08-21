"
Creation-code examples for test-suite search filters.
"
Class {
	#name : #GtSearchTestSuiteFiltersCreationStringExamples,
	#superclass : #GtSearchFiltersCreationStringExamples,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #examples }
GtSearchTestSuiteFiltersCreationStringExamples >> packageTagTestSuiteFilterCreationCode [
	<gtExample>
	| filter packageTag |
	packageTag := ('GToolkit-Pharo-TestSuite' asPackage) tagNamed: #Filters.
	filter := GtSearchPackageTagTestSuiteFilter new.
	filter packageTag: packageTag.
	^ self
		assertCreatioCodeFor: filter
		equals: 'GtSearchPackageTagTestSuiteFilter new packageTag: ((''GToolkit-Pharo-TestSuite'' asPackage) tagNamed: #Filters)'.
]

{ #category : #examples }
GtSearchTestSuiteFiltersCreationStringExamples >> packageTestSuiteFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchPackageTestSuiteFilter new.
	filter package: 'GToolkit-Pharo-TestSuite' asPackage.
	^ self
		assertCreatioCodeFor: filter
		equals: 'GtSearchPackageTestSuiteFilter new package: ''GToolkit-Pharo-TestSuite'' asPackage'.
]
