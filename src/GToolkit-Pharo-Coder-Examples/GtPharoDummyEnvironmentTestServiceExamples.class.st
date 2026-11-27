Class {
	#name : #GtPharoDummyEnvironmentTestServiceExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #examples }
GtPharoDummyEnvironmentTestServiceExamples >> defaultEnvironmentKeepsEnvironment [
	"Outside of a test environment nothing is registered"

	<gtExample>
	| aDummyEnvironment |
	DefaultExecutionEnvironment
		beActiveDuring: [ aDummyEnvironment := GtPharoDummyEnvironment withPackages: 1 classes: 1 ].

	self assert: (self hasPackageOf: aDummyEnvironment).
	aDummyEnvironment removeFromSystem.
	^ aDummyEnvironment
]

{ #category : #support }
GtPharoDummyEnvironmentTestServiceExamples >> hasPackageOf: aDummyEnvironment [
	^ PackageOrganizer default
		includesPackageNamed: aDummyEnvironment anyDummyPackage packageName
]

{ #category : #examples }
GtPharoDummyEnvironmentTestServiceExamples >> managedRunRemovesEnvironment [
	"A dummy environment created in a managed run is removed from the system when the run is cleaned up"

	<gtExample>
	| aTestEnvironment aDummyEnvironment aService |
	aTestEnvironment := TestExecutionEnvironment new.
	DefaultExecutionEnvironment
		beActiveDuring: [ aTestEnvironment
				beActiveDuring: [ aService := aTestEnvironment findService: GtPharoDummyEnvironmentTestService.
					aDummyEnvironment := GtPharoDummyEnvironment withPackages: 1 classes: 1.

					self assert: aService isEnabled.
					self assert: (aService environments includes: aDummyEnvironment).
					self assert: (self hasPackageOf: aDummyEnvironment).

					aTestEnvironment cleanUpAfterTest ] ].

	self assert: (self hasPackageOf: aDummyEnvironment) not.
	self assert: aService environments isEmpty.
	^ aDummyEnvironment
]

{ #category : #examples }
GtPharoDummyEnvironmentTestServiceExamples >> unmanagedRunKeepsEnvironment [
	"A dummy environment created in an unmanaged run stays available for exploration"

	<gtExample>
	| aTestEnvironment aDummyEnvironment aService |
	aTestEnvironment := TestExecutionEnvironment new.
	DefaultExecutionEnvironment
		beActiveDuring: [ aTestEnvironment
				beActiveDuring: [ aTestEnvironment disableServicesForUnmanagedExampleRun.
					aService := aTestEnvironment
							findService: GtPharoDummyEnvironmentTestService.
					aDummyEnvironment := GtPharoDummyEnvironment withPackages: 1 classes: 1.

					self assert: aService isEnabled not.
					self assert: aService environments isEmpty.

					aTestEnvironment cleanUpAfterTest ] ].

	self assert: (self hasPackageOf: aDummyEnvironment).
	aDummyEnvironment removeFromSystem.
	^ aDummyEnvironment
]
