Class {
	#name : #GtSearchMethodsInClassFilter,
	#superclass : #GtSearchMethodsContainedInClassFilter,
	#instVars : [
		'includeSubclasses',
		'includeSuperclass',
		'upToSuperclass'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchMethodsInClassFilter >> = anObject [
	^ self class = anObject class
		and: [ self filterClass = anObject filterClass
				and: [ self includeSubclasses = anObject includeSubclasses
						and: [ self includeSuperclass = anObject includeSuperclass ] ] ]
]

{ #category : #accessing }
GtSearchMethodsInClassFilter >> defaultFilterScope [
	| theStreams |
	theStreams := OrderedCollection new.

	theStreams add: (AsyncBehaviorAllMethodsStream forBehavior: class).

	includeSuperclass
		ifTrue: [ theStreams
				add: (class allSuperclasses asAsyncStream
						map: [ :eachBehavior | AsyncBehaviorAllMethodsStream forBehavior: eachBehavior ])
						flatten ].

	includeSubclasses
		ifTrue: [ theStreams
				add: (class allSubclasses asAsyncStream
						map: [ :eachBehavior | AsyncBehaviorAllMethodsStream forBehavior: eachBehavior ])
						flatten ].

	^ theStreams asAsyncStream flatten
]

{ #category : #printing }
GtSearchMethodsInClassFilter >> gtDisplayOn: stream [
	stream
		print: class;
		nextPutAll: ' methodsInClass'
]

{ #category : #comparing }
GtSearchMethodsInClassFilter >> hash [
	^ self class hash bitXor: self filterClass hash
]

{ #category : #testing }
GtSearchMethodsInClassFilter >> includeSubclasses [
	^ includeSubclasses
]

{ #category : #'initialize-release' }
GtSearchMethodsInClassFilter >> includeSubclasses: anObject [
	includeSubclasses := anObject
]

{ #category : #testing }
GtSearchMethodsInClassFilter >> includeSuperclass [
	^ includeSuperclass
]

{ #category : #'initialize-release' }
GtSearchMethodsInClassFilter >> includeSuperclass: anObject [
	includeSuperclass := anObject
]

{ #category : #testing }
GtSearchMethodsInClassFilter >> includesMethod: aCompiledMethod [
	| methodClass |
	methodClass := aCompiledMethod methodClass.
	methodClass = class ifTrue: [ ^ true ].
	^ (includeSubclasses and: [ methodClass includesBehavior: class ])
		or: [ includeSuperclass
				and: [ (class includesBehavior: methodClass)
						and: [ upToSuperclass isNil
								or: [ upToSuperclass superclass isNil
										or: [ (upToSuperclass superclass includesBehavior: methodClass) not ] ] ] ] ]
]

{ #category : #'initialize-release' }
GtSearchMethodsInClassFilter >> initialize [
	super initialize.
	includeSubclasses := false.
	includeSuperclass := false
]

{ #category : #enumerating }
GtSearchMethodsInClassFilter >> methodsDo: aBlock [
	class methods do: aBlock.
	includeSuperclass
		ifTrue: [ class superclass methods do: aBlock ].
	includeSubclasses
		ifTrue: [ (class allSubclasses flatCollect: #methods) do: aBlock ]
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withSubclasses [
	self includeSubclasses: true
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withSuperclasses [
	self includeSuperclass: true
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withSuperclassesUpTo: aClass [
	self withSuperclasses.
	upToSuperclass := aClass
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withoutSubclasses [
	self includeSubclasses: false
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withoutSuperclasses [
	self includeSuperclass: false
]
