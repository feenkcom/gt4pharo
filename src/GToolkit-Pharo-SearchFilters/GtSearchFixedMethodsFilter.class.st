Class {
	#name : #GtSearchFixedMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'methods',
		'label',
		'highlighter'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchFixedMethodsFilter >> defaultFilterScope [
	^ self methods asAsyncStream
]

{ #category : #printing }
GtSearchFixedMethodsFilter >> gtDisplayOn: stream [
	label
		ifNil: [ super gtDisplayOn: stream ]
		ifNotNil: [ :aLabel |
			stream
				nextPutAll: aLabel ]
]

{ #category : #accessing }
GtSearchFixedMethodsFilter >> highlighter [
	^ highlighter
]

{ #category : #accessing }
GtSearchFixedMethodsFilter >> highlighter: aHighlighter [
	highlighter := aHighlighter
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
GtSearchFixedMethodsFilter >> label: aLabel [
	label := aLabel
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

{ #category : #accessing }
GtSearchFixedMethodsFilter >> withDefinedMethodsFrom: aCollectionOfMethods [
	self methods: ((aCollectionOfMethods
		collect: [ :aMethod | aMethod methodReference  ])
		select: [ :aMethodReference | aMethodReference isDefined]
			thenCollect: [:aMethodReference| aMethodReference method ])
]
