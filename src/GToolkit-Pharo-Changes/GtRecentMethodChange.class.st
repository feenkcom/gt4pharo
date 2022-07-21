Class {
	#name : #GtRecentMethodChange,
	#superclass : #Object,
	#instVars : [
		'method',
		'timestamp'
	],
	#category : #'GToolkit-Pharo-Changes-Model'
}

{ #category : #'instance creation' }
GtRecentMethodChange class >> method: aMethod timestamp: aDateAndTime [
	^ self new
		method: aMethod;
		timestamp: aDateAndTime
]

{ #category : #accessing }
GtRecentMethodChange >> displayForTree [
	^ method selector asString
]

{ #category : #accessing }
GtRecentMethodChange >> gtChildren [
	^ {}
]

{ #category : #accessing }
GtRecentMethodChange >> method [
	^ method
]

{ #category : #accessing }
GtRecentMethodChange >> method: aMethod [ 
	method := aMethod
]

{ #category : #accessing }
GtRecentMethodChange >> navigateToUsingModel: aNavigationModel [
	aNavigationModel selectMethod: method
]

{ #category : #'instance creation' }
GtRecentMethodChange >> timestamp: aDateAndTime [ 
	timestamp := aDateAndTime
]
