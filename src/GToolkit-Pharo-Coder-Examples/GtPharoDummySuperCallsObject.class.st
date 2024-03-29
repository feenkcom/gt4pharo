Class {
	#name : #GtPharoDummySuperCallsObject,
	#superclass : #GtPharoDummySelfCallsObject,
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #accessing }
GtPharoDummySuperCallsObject >> anotherNumber [
	self number
]

{ #category : #accessing }
GtPharoDummySuperCallsObject >> number [
	super number.
	self one.
	self three.
	thisContext compiledCode.
	self class new one.
]

{ #category : #accessing }
GtPharoDummySuperCallsObject >> one [
	super one.
	^ 1.1
]

{ #category : #accessing }
GtPharoDummySuperCallsObject >> printString [
	^ super printString
]
