Class {
	#name : #GtSearchScopedMethodsPackagePatternScope,
	#superclass : #GtSearchScopedMethodsScope,
	#instVars : [
		'pattern',
		'filter'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #factory }
GtSearchScopedMethodsPackagePatternScope class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	| aBehaviorPackage |
	aFilterContext
		behaviorDo: [ :aBehavior | 
			aBehaviorPackage := aBehavior package.
			self itemInstancesForPackage: aBehaviorPackage into: aStream ].
	aFilterContext
		compiledMethodDo: [ :aMethod | 
			| aMethodPackage |
			aMethodPackage := aMethod package.
			aBehaviorPackage = aMethodPackage
				ifFalse: [ self itemInstancesForPackage: aMethodPackage into: aStream ] ]
]

{ #category : #factory }
GtSearchScopedMethodsPackagePatternScope class >> itemInstancesForPackage: aPackage into: aStream [
	| aName aCollection |
	aName := aPackage name.
	aCollection := $- split: aName.
	aCollection size = 1 ifTrue: [ ^ self ].
	aCollection
		inject: nil
		into: [ :aPattern :aPart | 
			aPattern
				ifNil: [ aPart ]
				ifNotNil: [ 
					aStream nextPut: (self new pattern: aPattern).
					aPattern , '-' , aPart ] ]
]

{ #category : #'as yet unclassified' }
GtSearchScopedMethodsPackagePatternScope >> gtIconName [
	^ #package
]

{ #category : #testing }
GtSearchScopedMethodsPackagePatternScope >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ filter includesMethod: aCompiledMethod
]

{ #category : #initialization }
GtSearchScopedMethodsPackagePatternScope >> initialize [
	super initialize.

	filter := GtSearchMethodsWithPackagePatternFilter new
]

{ #category : #accessing }
GtSearchScopedMethodsPackagePatternScope >> itemValue [
	^ self pattern
]

{ #category : #accessing }
GtSearchScopedMethodsPackagePatternScope >> label [
	^ 'Package: *', self pattern, '*'
]

{ #category : #accessing }
GtSearchScopedMethodsPackagePatternScope >> order [
	^ 70
]

{ #category : #accessing }
GtSearchScopedMethodsPackagePatternScope >> pattern [
	^ pattern
]

{ #category : #accessing }
GtSearchScopedMethodsPackagePatternScope >> pattern: aString [
	pattern := aString.
	filter pattern: aString.
]
