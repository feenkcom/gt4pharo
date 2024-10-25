Class {
	#name : #GtSearchScopedMethodsClassHierarchyScope,
	#superclass : #GtSearchScopedMethodsScope,
	#instVars : [
		'itemClass',
		'filter'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #factory }
GtSearchScopedMethodsClassHierarchyScope class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	aFilterContext
		behaviorDo: [ :aBehavior | aStream nextPut: (self new itemClass: aBehavior) ]
]

{ #category : #accessing }
GtSearchScopedMethodsClassHierarchyScope class >> order [
	^ 50
]

{ #category : #accessing }
GtSearchScopedMethodsClassHierarchyScope >> gtIconName [
	^ #class
]

{ #category : #testing }
GtSearchScopedMethodsClassHierarchyScope >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ filter includesMethod: aCompiledMethod
]

{ #category : #initialization }
GtSearchScopedMethodsClassHierarchyScope >> initialize [
	super initialize.

	filter := GtSearchInheritedMethodsFilter new
			withSubclasses;
			withSuperclasses
]

{ #category : #accessing }
GtSearchScopedMethodsClassHierarchyScope >> itemClass [
	^ itemClass
]

{ #category : #accessing }
GtSearchScopedMethodsClassHierarchyScope >> itemClass: aClass [
	itemClass := aClass.
	filter forClass: aClass
]

{ #category : #accessing }
GtSearchScopedMethodsClassHierarchyScope >> itemValue [
	^ self itemClass
]

{ #category : #accessing }
GtSearchScopedMethodsClassHierarchyScope >> label [
	^ 'Hierarchy: ' , (self itemClass ifNotNil: #name ifNil: [ 'none' ])
]
