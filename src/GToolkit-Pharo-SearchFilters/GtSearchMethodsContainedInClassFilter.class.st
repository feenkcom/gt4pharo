Class {
	#name : #GtSearchMethodsContainedInClassFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'filterClass'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchMethodsContainedInClassFilter class >> createFilterFor: aMethodCoder [
	^ self forClass: aMethodCoder classOrMetaClass
]

{ #category : #'instance creation' }
GtSearchMethodsContainedInClassFilter class >> forClass: aClass [
	^ self new
		forClass: aClass;
		yourself
]

{ #category : #comparing }
GtSearchMethodsContainedInClassFilter >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ filterClass = anObject filterClass
]

{ #category : #accessing }
GtSearchMethodsContainedInClassFilter >> defaultFilterScope [
	^ AsyncBehaviorAllMethodsStream forBehavior: filterClass
]

{ #category : #accessing }
GtSearchMethodsContainedInClassFilter >> filterClass [
	^ filterClass
]

{ #category : #'initialize-release' }
GtSearchMethodsContainedInClassFilter >> forClass: aClass [
	filterClass := aClass
]

{ #category : #comparing }
GtSearchMethodsContainedInClassFilter >> hash [
	^ self class hash bitXor: self filterClass hash
]

{ #category : #enumerating }
GtSearchMethodsContainedInClassFilter >> itemsDo: aBlock [
	^ self methodsDo: aBlock
]

{ #category : #enumerating }
GtSearchMethodsContainedInClassFilter >> methodsDo: aBlock [
	self subclassResponsibility
]
