Class {
	#name : #GtPharoDummySelfCallsObject,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #accessing }
GtPharoDummySelfCallsObject >> number [
	^ self one
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> one [
	^ 1
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> three [
	^ self two + self one
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> two [
	^ self one + self one
]
