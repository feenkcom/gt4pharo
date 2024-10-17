Class {
	#name : #GtSearchScopedMethodsClassScope,
	#superclass : #GtSearchScopedMethodsScope,
	#instVars : [
		'itemClass',
		'filter'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #factory }
GtSearchScopedMethodsClassScope class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	aFilterContext
		behaviorDo: [ :aBehavior | aStream nextPut: (self new itemClass: aBehavior) ]
]

{ #category : #accessing }
GtSearchScopedMethodsClassScope >> gtIconName [
	^ #class
]

{ #category : #testing }
GtSearchScopedMethodsClassScope >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ filter includesMethod: aCompiledMethod
]

{ #category : #initialization }
GtSearchScopedMethodsClassScope >> initialize [
	super initialize.

	filter := GtSearchInheritedMethodsFilter new
			withSubclasses;
			withSuperclasses
]

{ #category : #accessing }
GtSearchScopedMethodsClassScope >> itemClass [
	^ itemClass
]

{ #category : #accessing }
GtSearchScopedMethodsClassScope >> itemClass: aClass [
	itemClass := aClass.
	filter forClass: aClass
]

{ #category : #accessing }
GtSearchScopedMethodsClassScope >> itemValue [
	^ self itemClass
]

{ #category : #accessing }
GtSearchScopedMethodsClassScope >> label [
	^ 'Class: ', self itemClass name
]

{ #category : #accessing }
GtSearchScopedMethodsClassScope >> order [
	^ 20
]
