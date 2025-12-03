Class {
	#name : #GtPharoPackagesNavigationViewModelExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #cleanup }
GtPharoPackagesNavigationViewModelExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #'examples - coders' }
GtPharoPackagesNavigationViewModelExamples >> packagesNavigationViewModel [
	<gtExample>
	<after: #cleanUp>
	| aPackagesCoder aPackagesNavigationViewModel |
	
	aPackagesCoder := GtPharoPackagesCoderExamples new packagesCoderOnManyPackages.
	environment := aPackagesCoder optionAt: #dummyEnvironment.
	
	aPackagesNavigationViewModel := GtPharoPackagesNavigationViewModel new
		pharoPackagesCoderModel: aPackagesCoder.

	^ aPackagesNavigationViewModel
]
