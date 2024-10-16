Class {
	#name : #GtSearchAllScopedMethodsItem,
	#superclass : #GtSearchScopedMethodsItem,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Filters'
}

{ #category : #factory }
GtSearchAllScopedMethodsItem class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	aStream nextPut: self default
]

{ #category : #testing }
GtSearchAllScopedMethodsItem >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ true
]

{ #category : #accessing }
GtSearchAllScopedMethodsItem >> label [
	^ 'All'
]

{ #category : #accessing }
GtSearchAllScopedMethodsItem >> order [
	^ 1
]
