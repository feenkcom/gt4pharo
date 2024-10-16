Class {
	#name : #GtSearchPackageScopedMethodsItem,
	#superclass : #GtSearchScopedMethodsItem,
	#instVars : [
		'package',
		'filter'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Filters'
}

{ #category : #factory }
GtSearchPackageScopedMethodsItem class >> itemInstancesForFilterContext: aFilterContext into: aStream [
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

{ #category : #testing }
GtSearchPackageScopedMethodsItem >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ filter includesMethod: aCompiledMethod
]

{ #category : #initialization }
GtSearchPackageScopedMethodsItem >> initialize [
	super initialize.

	filter := GtSearchMethodsInPackageFilter new
]

{ #category : #accessing }
GtSearchPackageScopedMethodsItem >> itemValue [
	^ self package
]

{ #category : #accessing }
GtSearchPackageScopedMethodsItem >> label [
	^ self package name
]

{ #category : #accessing }
GtSearchPackageScopedMethodsItem >> order [
	^ 50
]

{ #category : #accessing }
GtSearchPackageScopedMethodsItem >> package [
	^ package
]

{ #category : #accessing }
GtSearchPackageScopedMethodsItem >> package: aPackage [
	package := aPackage.
	filter package: aPackage
]
