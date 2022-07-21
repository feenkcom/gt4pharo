Class {
	#name : #GtRecentChange,
	#superclass : #Object,
	#instVars : [
		'methods',
		'theClass'
	],
	#category : #'GToolkit-Pharo-Changes-Model'
}

{ #category : #'instance creation' }
GtRecentChange class >> class: aClass methods: aCollectionOfMethods [
	^ self new
		class: aClass;
		methods: aCollectionOfMethods
]

{ #category : #accessing }
GtRecentChange >> add: aMethod [
	methods add: aMethod
]

{ #category : #accessing }
GtRecentChange >> class: aClass [ 
	theClass := aClass
]

{ #category : #printing }
GtRecentChange >> displayForTree [
	^ theClass asString
]

{ #category : #accessing }
GtRecentChange >> filterByLog: aLog [
	| startTime endTime |
	startTime := aLog log startTime.
	endTime := aLog log endTime.
	startTime ifNil: [ ^ self class class: theClass methods: {} ].
	^ self class
		class: theClass
		methods: (methods
				select: [ :aMethod | 
					endTime
						ifNil: [ aMethod timestamp >= startTime ]
						ifNotNil: [ aMethod timestamp >= startTime and: [ aMethod timestamp <= endTime ] ] ])
]

{ #category : #accessing }
GtRecentChange >> gtChildren [
	^ methods
]

{ #category : #accessing }
GtRecentChange >> ifEmpty: aBlock [
	^ methods ifEmpty: aBlock
]

{ #category : #accessing }
GtRecentChange >> isEmpty [
	^ methods isEmpty
]

{ #category : #acccessing }
GtRecentChange >> methods: aCollectionOfMethods [ 
	methods := aCollectionOfMethods
]

{ #category : #navigation }
GtRecentChange >> navigateToUsingModel: aNavigationModel [
	aNavigationModel selectClass: theClass
]

{ #category : #accessing }
GtRecentChange >> remove: aMethod [
	methods := methods reject: [ :each | each method = aMethod ]
]

{ #category : #accessing }
GtRecentChange >> size [
	^ methods size
]

{ #category : #accessing }
GtRecentChange >> theClass [
	^ theClass
]
