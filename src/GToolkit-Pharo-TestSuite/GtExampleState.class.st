Class {
	#name : #GtExampleState,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Pharo-TestSuite-States'
}

{ #category : #cleanup }
GtExampleState class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
GtExampleState class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
GtExampleState class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'api - accessing' }
GtExampleState >> allLabels [
	"Return all available labels"
	<return: #Array of: #String>
	^ self allStates collect: #label
]

{ #category : #'api - accessing' }
GtExampleState >> allStates [
	| allInstances |
	allInstances := self class allSubclasses collect: #default.
	allInstances sort: [ :a :b | a order < b order ].
	^ allInstances
]

{ #category : #'as yet unclassified' }
GtExampleState >> asElement [
	^ BlElement new
		size: 16 @ 16;
		geometry: self geometry;
		background: self color
]

{ #category : #views }
GtExampleState >> gStatesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'States';
		items: [ self allStates ];
		column: 'State' text: [ :each | each label ];
		column: 'Icon' stencil: [ :each | each asElement ]
]

{ #category : #'as yet unclassified' }
GtExampleState >> geometry [
	^ BlRectangleGeometry new
]

{ #category : #'api - testing' }
GtExampleState >> includesCoder: aCoder [
	"Return true if a method filter should be displayed.
	Return false otherwise."
	^ true
]

{ #category : #'api - testing' }
GtExampleState >> includesExampleWithResult: aGtExampleWithResult [
	"Return true if a method filter should be displayed.
	Return false otherwise."

	^ self subclassResponsibility
]

{ #category : #'api - testing' }
GtExampleState >> isStatusFor: aGtExampleWithResult [
	"Return true if the status is equal to the example result status"
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
GtExampleState >> label [
	"Return a name that is used by ${class:GtSearchExamplesFilter}$ 
	to display available example filters in ${class:GtFiltersElement}$."
	<return: #String>
	^ self className
]

{ #category : #'api - accessing' }
GtExampleState >> numberOfExamplesFor: anExampler [
	"Return number of examples with a given state"
	^ 0
]

{ #category : #'api - accessing' }
GtExampleState >> order [
	"Return a number that is used by ${class:GtSearchExamplesFilter}$ 
	to display available example filters in ${class:GtFiltersElement}$
	in a specific order (higher number, later in a list)."
	<return: #Number>
	^ 50
]

{ #category : #'api - accessing' }
GtExampleState >> stateFromExample: aGtExampleWithResult [
	aGtExampleWithResult ifNotNil: [ 
		self allStates do: [ :eachStatus | 
			(eachStatus isStatusFor: aGtExampleWithResult)
				ifTrue: [ ^ eachStatus ] ] ].
	^ GtFilterExampleNotExecutedState default
]

{ #category : #'api - accessing' }
GtExampleState >> stateFromLabel: aLabel [
	<return: #GtExampleState>
	| aString |
	aString := aLabel asString.
	^ self allStates 
		detect: [ :eachStatus | eachStatus label = aString ]
		ifNone: [ GtFilterExampleAllState default ]
]
