Class {
	#name : #GtSearchScopedMethodsItem,
	#superclass : #GtFilterModelItem,
	#category : #'GToolkit-Pharo-Coder-UI-Filters'
}

{ #category : #factory }
GtSearchScopedMethodsItem class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	self subclassResponsibility
]

{ #category : #testing }
GtSearchScopedMethodsItem >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSearchScopedMethodsItem >> order [
	^ 100
]
