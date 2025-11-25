Class {
	#name : #GtPharoSuiteStreamChanged,
	#superclass : #Announcement,
	#instVars : [
		'suite'
	],
	#category : 'GToolkit-Pharo-TestSuite-Events'
}

{ #category : #accessing }
GtPharoSuiteStreamChanged >> suite [

	^ suite
]

{ #category : #accessing }
GtPharoSuiteStreamChanged >> suite: anObject [

	suite := anObject
]
