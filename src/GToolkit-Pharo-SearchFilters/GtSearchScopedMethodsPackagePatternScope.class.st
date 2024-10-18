Class {
	#name : #GtSearchScopedMethodsPackagePatternScope,
	#superclass : #GtSearchScopedMethodsScope,
	#instVars : [
		'pattern',
		'filter',
		'order'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #factory }
GtSearchScopedMethodsPackagePatternScope class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	| aBehaviorPackage anExistingPatterns aCollection |
	anExistingPatterns := Set new.
	aFilterContext
		behaviorDo: [ :aBehavior | 
			aBehaviorPackage := aBehavior package.
			self itemInstancesForPackage: aBehaviorPackage patterns: anExistingPatterns ].
	aFilterContext
		compiledMethodDo: [ :aMethod | 
			| aMethodPackage |
			aMethodPackage := aMethod package.
			aBehaviorPackage = aMethodPackage ifFalse: [ 
				self itemInstancesForPackage: aMethodPackage patterns: anExistingPatterns ] ].
	
	aCollection := anExistingPatterns sorted: [ :a :b | a pattern size < b pattern size ].
	aCollection doWithIndex: [ :aScope :anIndex | aScope order: aScope order + (0.1 * anIndex) ].
	aStream nextPutAll: aCollection
]

{ #category : #factory }
GtSearchScopedMethodsPackagePatternScope class >> itemInstancesForPackage: aPackage patterns: anExistingPatterns [
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
					anExistingPatterns add: (self new pattern: aPattern).
					aPattern , '-' , aPart ] ]
]

{ #category : #accessing }
GtSearchScopedMethodsPackagePatternScope class >> order [
	^ 100
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
	^ 'Package: *', (self pattern ifNil: [ 'none' ]), '*'
]

{ #category : #accessing }
GtSearchScopedMethodsPackagePatternScope >> order [
	^ order ifNil: [ super order ]
]

{ #category : #accessing }
GtSearchScopedMethodsPackagePatternScope >> order: anObject [
	order := anObject
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
