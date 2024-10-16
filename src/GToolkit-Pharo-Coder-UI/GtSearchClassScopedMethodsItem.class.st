Class {
	#name : #GtSearchClassScopedMethodsItem,
	#superclass : #GtSearchScopedMethodsItem,
	#instVars : [
		'itemClass',
		'filter'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Filters'
}

{ #category : #factory }
GtSearchClassScopedMethodsItem class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	aFilterContext
		behaviorDo: [ :aBehavior | aStream nextPut: (self new itemClass: aBehavior) ]
]

{ #category : #testing }
GtSearchClassScopedMethodsItem >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ filter includesMethod: aCompiledMethod
]

{ #category : #initialization }
GtSearchClassScopedMethodsItem >> initialize [
	super initialize.

	filter := GtSearchInheritedMethodsFilter new
			withSubclasses;
			withSuperclasses
]

{ #category : #accessing }
GtSearchClassScopedMethodsItem >> itemClass [
	^ itemClass
]

{ #category : #accessing }
GtSearchClassScopedMethodsItem >> itemClass: aClass [
	itemClass := aClass.
	filter forClass: aClass
]

{ #category : #accessing }
GtSearchClassScopedMethodsItem >> itemValue [
	^ self itemClass
]

{ #category : #accessing }
GtSearchClassScopedMethodsItem >> label [
	^ self itemClass name
]

{ #category : #accessing }
GtSearchClassScopedMethodsItem >> order [
	^ 80
]
