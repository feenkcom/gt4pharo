Class {
	#name : #GtSearchPackageTagTestSuiteFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'packageTag'
	],
	#category : 'GToolkit-Pharo-TestSuite-Filters'
}

{ #category : #accessing }
GtSearchPackageTagTestSuiteFilter >> includesMethod: aCompiledMethod [
	(aCompiledMethod methodClass inheritsFrom: TestCase) ifFalse: [ 
		^ false ].
	aCompiledMethod selector isTestSelector ifFalse: [ ^ false ].
	
	^ (self packageTag includesClass: aCompiledMethod methodClass)
]

{ #category : #accessing }
GtSearchPackageTagTestSuiteFilter >> package [
	^ self packageTag package
]

{ #category : #accessing }
GtSearchPackageTagTestSuiteFilter >> packageTag [

	^ packageTag
]

{ #category : #accessing }
GtSearchPackageTagTestSuiteFilter >> packageTag: aPackageTag [

	self
		assert: [ aPackageTag isNotNil ]
		description: [ 'Package tag must be non-nil' ].

	packageTag := aPackageTag
]
