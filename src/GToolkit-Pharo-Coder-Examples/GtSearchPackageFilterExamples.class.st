Class {
	#name : #GtSearchPackageFilterExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Filters'
}

{ #category : #asserting }
GtSearchPackageFilterExamples >> assertPackageResultTypeForFilter: aFilter [
	self assert: aFilter resultType equals: GtAsyncSearchPackageGroupStream
]

{ #category : #accessing }
GtSearchPackageFilterExamples >> deprecatedPackagesFilter [
	<gtExample>
	| filter |
	
	filter := GtSearchDeprecatedPackagesFilter new.
	
	"self assert: (filter matches: (RPackageOrganizer default packages 
		select: [ :aPackage | 
			aPackage name beginsWith: 'Spec2-ObservableSlot']) anyOne)."
	self assert: (filter matches: 'GToolkit-Docs' asPackage) not.
	
	^ filter.
]

{ #category : #'examples - result' }
GtSearchPackageFilterExamples >> groupResultForPackagesInImageFilter [
	<gtExample>
	| filter resultStream result |

	filter := self packagesInImageFilter.
	resultStream := filter result.
	
	self assert: (resultStream isKindOf: GtAsyncSearchPackageGroupStream).
	self assert: resultStream filter equals: filter.
	self assert: resultStream scope equals: AsyncImagePackagesStream new.
	
	result := resultStream toArray wait.
	self assert: result size equals: self packageOrganizer packages size.
	self assert: (result includes: 'GToolkit-Coder-Examples' asPackage).
	self assert: (result includes: (Package named: 'A-Package-ThatDoesNotExist')) not.
	
	^ resultStream
]

{ #category : #examples }
GtSearchPackageFilterExamples >> packagesInImageFilter [
	<gtExample>
	| filter |
	filter := GtSearchImagePackagesFilter new.
	
	self assert: (filter matches: 'GToolkit-Coder-Examples' asPackage).
	self assert: (filter matches: (Package named: 'A-Package-ThatDoesNotExist')) not.
	
	self assert: filter defaultFilterScope equals: AsyncImagePackagesStream new.
	self assertPackageResultTypeForFilter: filter.
	
	^ filter
]

{ #category : #examples }
GtSearchPackageFilterExamples >> packagesInImageFilterEqualityExample [
	<gtExample>
	| filter |
	filter := self packagesInImageFilter.
	self 
		assert: filter
		equals:  GtSearchImagePackagesFilter new.
	^ filter
]
