Class {
	#name : #GtPharoPackagesNavigationElementExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #cleanup }
GtPharoPackagesNavigationElementExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #examples }
GtPharoPackagesNavigationElementExamples >> packagesNavigationView [
	<gtExample>
	<after: #cleanUp>
	| aPackagesNavigationViewModel aPackagesNavigationElement |
	
	aPackagesNavigationViewModel := GtPharoPackagesNavigationViewModelExamples new packagesNavigationViewModel.
	environment := aPackagesNavigationViewModel pharoPackagesCoderModel optionAt: #dummyEnvironment.

	aPackagesNavigationElement := GtPharoPackagesNavigationElement new
		pharoPackagesNavigationViewModel: aPackagesNavigationViewModel.

	^ aPackagesNavigationElement
]
