Class {
	#name : #GtSearchMethodsInClassFilter,
	#superclass : #GtSearchMethodsContainedInClassFilter,
	#instVars : [
		'includeSubclasses',
		'includeSuperclass'
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
	
	(includeSuperclass and: [ class superclass notNil ])
		ifTrue: [ theStreams add: (AsyncBehaviorAllMethodsStream forBehavior: class superclass) ].

	includeSubclasses
		ifTrue: [ theStreams add: (class allSubclasses asAsyncStream map: [ :eachBehavior | (AsyncBehaviorAllMethodsStream forBehavior: eachBehavior) ]) flatten ].

	^ theStreams asAsyncStream flatten
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
	methodClass = class
		ifTrue: [ ^ true ].
	^ (includeSubclasses and: [ methodClass includesBehavior: class ])
		or: [ includeSuperclass and: [ class includesBehavior: methodClass ] ]
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
