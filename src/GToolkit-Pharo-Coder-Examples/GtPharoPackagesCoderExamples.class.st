Class {
	#name : #GtPharoPackagesCoderExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #cleanup }
GtPharoPackagesCoderExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #examples }
GtPharoPackagesCoderExamples >> packagesCoderOnManyPackages [
	| aCoder |
	<gtExample>
	<after: #cleanUp>

	environment := GtPharoDummyEnvironment withPackages: 2 classes: 2.

	aCoder := GtPharoPackagesCoder forPackages: environment realPackages.
	aCoder optionAt: #dummyEnvironment put: environment.
	
	self assert: aCoder coders size equals: 2.

	^ aCoder
]
