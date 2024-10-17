Class {
	#name : #GtSearchScopedMethodsPackageScope,
	#superclass : #GtSearchScopedMethodsScope,
	#instVars : [
		'package',
		'filter'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #factory }
GtSearchScopedMethodsPackageScope class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	| aBehaviorPackage |
	aFilterContext
		behaviorDo: [ :aBehavior | 
			aBehaviorPackage := aBehavior package.
			aStream nextPut: (self new package: aBehaviorPackage) ].
	aFilterContext
		compiledMethodDo: [ :aMethod | 
			| aMethodPackage |
			aMethodPackage := aMethod package.
			aBehaviorPackage = aMethodPackage
				ifFalse: [ aStream nextPut: (self new package: aMethodPackage) ] ]
]

{ #category : #accessing }
GtSearchScopedMethodsPackageScope >> gtIconName [
	^ #package
]

{ #category : #testing }
GtSearchScopedMethodsPackageScope >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ filter includesMethod: aCompiledMethod
]

{ #category : #initialization }
GtSearchScopedMethodsPackageScope >> initialize [
	super initialize.

	filter := GtSearchMethodsInPackageFilter new
]

{ #category : #accessing }
GtSearchScopedMethodsPackageScope >> itemValue [
	^ self package
]

{ #category : #accessing }
GtSearchScopedMethodsPackageScope >> label [
	^ 'Package: ', self package name
]

{ #category : #accessing }
GtSearchScopedMethodsPackageScope >> order [
	^ 50
]

{ #category : #accessing }
GtSearchScopedMethodsPackageScope >> package [
	^ package
]

{ #category : #accessing }
GtSearchScopedMethodsPackageScope >> package: aPackage [
	package := aPackage.
	filter package: aPackage
]
