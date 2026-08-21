Class {
	#name : #GtSearchPackageTestSuiteFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'package'
	],
	#category : #'GToolkit-Pharo-TestSuite-Filters'
}

{ #category : #accessing }
GtSearchPackageTestSuiteFilter >> includesMethod: aCompiledMethod [

	(aCompiledMethod methodClass inheritsFrom: TestCase) ifFalse: [ 
		^ false ].
	aCompiledMethod selector isTestSelector ifFalse: [ ^ false ].

	^ aCompiledMethod package = self package or: [ 
		  aCompiledMethod methodClass package = self package ]
]

{ #category : #accessing }
GtSearchPackageTestSuiteFilter >> package [

	^ package
]

{ #category : #accessing }
GtSearchPackageTestSuiteFilter >> package: aPackage [

	self
		assert: [ aPackage isNotNil ]
		description: [ 'Package must be non-nil' ].

	package := aPackage
]

{ #category : #storing }
GtSearchPackageTestSuiteFilter >> storeCreationCodeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new package: ';
		print: self package name asString;
		nextPutAll: ' asPackage'.
]
