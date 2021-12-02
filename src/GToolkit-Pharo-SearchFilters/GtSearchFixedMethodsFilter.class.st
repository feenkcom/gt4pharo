Class {
	#name : #GtSearchFixedMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'methods'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchFixedMethodsFilter >> defaultFilterScope [
	^ self methods asAsyncStream
]

{ #category : #testing }
GtSearchFixedMethodsFilter >> includesMethod: aCompiledMethod [
	^ self methods includes: aCompiledMethod
]

{ #category : #enumerating }
GtSearchFixedMethodsFilter >> itemsDo: aBlock [
	^ self methodsDo: aBlock
]

{ #category : #accessing }
GtSearchFixedMethodsFilter >> methods [
	^ methods ifNil: [ methods := OrderedCollection new ]
]

{ #category : #accessing }
GtSearchFixedMethodsFilter >> methods: anOrderedCollection [
	methods := anOrderedCollection
]

{ #category : #enumerating }
GtSearchFixedMethodsFilter >> methodsDo: aBlock [
	self methods do: aBlock.
]
