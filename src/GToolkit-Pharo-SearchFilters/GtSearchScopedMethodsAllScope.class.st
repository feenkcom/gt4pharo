Class {
	#name : #GtSearchScopedMethodsAllScope,
	#superclass : #GtSearchScopedMethodsScope,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #factory }
GtSearchScopedMethodsAllScope class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	aStream nextPut: self default
]

{ #category : #accessing }
GtSearchScopedMethodsAllScope class >> order [
	^ 1
]

{ #category : #accessing }
GtSearchScopedMethodsAllScope >> gtIconName [
	^ #empty
]

{ #category : #testing }
GtSearchScopedMethodsAllScope >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ true
]

{ #category : #accessing }
GtSearchScopedMethodsAllScope >> label [
	^ 'Current image'
]
