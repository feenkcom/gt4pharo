Class {
	#name : #GtSearchScopedMethodsScope,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #factory }
GtSearchScopedMethodsScope class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	self subclassResponsibility
]

{ #category : #comparing }
GtSearchScopedMethodsScope >> = anObject [
	self == anObject ifTrue: [ ^ true ].

	^ self class = anObject class and: [ self itemValue = anObject itemValue ]
]

{ #category : #printing }
GtSearchScopedMethodsScope >> gtDisplayOn: aStream [
	aStream nextPutAll: self label
]

{ #category : #accessing }
GtSearchScopedMethodsScope >> gtIconName [
	^ self itemValue gtSystemIconName
]

{ #category : #comparing }
GtSearchScopedMethodsScope >> hash [
	^ self class hash bitXor: self itemValue hash
]

{ #category : #testing }
GtSearchScopedMethodsScope >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSearchScopedMethodsScope >> itemValue [
	^ nil
]

{ #category : #accessing }
GtSearchScopedMethodsScope >> label [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSearchScopedMethodsScope >> order [
	^ 100
]
