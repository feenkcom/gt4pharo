Class {
	#name : #GtSearchPackagePatternScopedMethodsItem,
	#superclass : #GtSearchScopedMethodsItem,
	#instVars : [
		'pattern',
		'filter'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Filters'
}

{ #category : #factory }
GtSearchPackagePatternScopedMethodsItem class >> itemInstancesForFilterContext: aFilterContext into: aStream [
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
GtSearchPackagePatternScopedMethodsItem class >> itemInstancesForPackage: aPackage into: aStream [
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

{ #category : #testing }
GtSearchPackagePatternScopedMethodsItem >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ filter includesMethod: aCompiledMethod
]

{ #category : #initialization }
GtSearchPackagePatternScopedMethodsItem >> initialize [
	super initialize.

	filter := GtSearchMethodsWithPackagePatternFilter new
]

{ #category : #accessing }
GtSearchPackagePatternScopedMethodsItem >> itemValue [
	^ self pattern
]

{ #category : #accessing }
GtSearchPackagePatternScopedMethodsItem >> label [
	^ 'Package: *', self pattern, '*'
]

{ #category : #accessing }
GtSearchPackagePatternScopedMethodsItem >> order [
	^ 70
]

{ #category : #accessing }
GtSearchPackagePatternScopedMethodsItem >> pattern [
	^ pattern
]

{ #category : #accessing }
GtSearchPackagePatternScopedMethodsItem >> pattern: aString [
	pattern := aString.
	filter pattern: aString.
]
