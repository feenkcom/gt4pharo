Class {
	#name : #GtSearchSubclassesFilter,
	#superclass : #GtSearchClassesFilter,
	#instVars : [
		'searchClass'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchSubclassesFilter class >> forClass: aClass [
	^self new searchClass: aClass
]

{ #category : #comparing }
GtSearchSubclassesFilter >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ searchClass = anObject searchClass
]

{ #category : #enumerating }
GtSearchSubclassesFilter >> classesDo: aBlock [
	searchClass subclasses do: aBlock
]

{ #category : #accessing }
GtSearchSubclassesFilter >> defaultFilterScope [
	^ AsyncBehaviorSubclassesStream forBehavior: searchClass
]

{ #category : #comparing }
GtSearchSubclassesFilter >> hash [
	^ searchClass hash
]

{ #category : #testing }
GtSearchSubclassesFilter >> includesClass: aClass [
	^ aClass superclass = searchClass
]

{ #category : #enumerating }
GtSearchSubclassesFilter >> itemsDo: aBlock [
	^ self classesDo: aBlock
]

{ #category : #accessing }
GtSearchSubclassesFilter >> searchClass [
	^ searchClass
]

{ #category : #accessing }
GtSearchSubclassesFilter >> searchClass: anObject [
	searchClass := anObject
]
