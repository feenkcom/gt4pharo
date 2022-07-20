Class {
	#name : #GtRecentChange,
	#superclass : #Object,
	#instVars : [
		'methods',
		'theClass'
	],
	#category : #'GToolkit-Pharo-Changes'
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
GtRecentChange >> gtChildren [
	^ methods
]

{ #category : #accessing }
GtRecentChange >> ifEmpty: aBlock [
	^ methods ifEmpty: aBlock
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
	methods remove: aMethod
]

{ #category : #accessing }
GtRecentChange >> theClass [
	^ theClass
]
