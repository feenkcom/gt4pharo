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
	| aBehaviorPackage anExistingPatterns |
	anExistingPatterns := OrderedCollection new.
	aFilterContext
		behaviorDo: [ :aBehavior | 
			aBehaviorPackage := aBehavior package.
			self itemInstancesForPackage: aBehaviorPackage into: aStream patterns: anExistingPatterns ].
	aFilterContext
		compiledMethodDo: [ :aMethod | 
			| aMethodPackage |
			aMethodPackage := aMethod package.
			aBehaviorPackage = aMethodPackage
				ifFalse: [ self itemInstancesForPackage: aMethodPackage into: aStream patterns: anExistingPatterns ] ]
]

{ #category : #factory }
GtSearchScopedMethodsPackagePatternScope class >> itemInstancesForPackage: aPackage into: aStream patterns: anExistingPatterns [
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
					(anExistingPatterns includes: aPattern)
						ifFalse: [ 
							aStream nextPut: (self new pattern: aPattern).
							anExistingPatterns add: aPattern ].
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
