Class {
	#name : #GtSearchNegationFilterExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #examples }
GtSearchNegationFilterExamples >> negationSearchFilter [
	<gtExample>
	| basicFilter negationFilter |
	basicFilter := GtSearchDeprecatedPackagesFilter new.
	negationFilter := basicFilter not.
	
	self assert: (negationFilter notEmpty).
	self assert: (negationFilter matches: 'GToolkit-Coder-Examples' asPackage).
	
	^ negationFilter.
]

{ #category : #examples }
GtSearchNegationFilterExamples >> negationSearchFilterExplicitDefinition [
	<gtExample>
	| basicFilter negationFilter |
	basicFilter := GtSearchDeprecatedPackagesFilter new.
	negationFilter := GtSearchNegationFilter new
		originalFilter: basicFilter.
	
	self assert: (negationFilter notEmpty).
	self assert: (negationFilter matches: 'GToolkit-Coder' asPackage).
	
	^ negationFilter.
]
