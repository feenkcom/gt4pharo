Class {
	#name : #GtPharoDummyTwoObject,
	#superclass : #GtPharoDummyOneObject,
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #accessing }
GtPharoDummyTwoObject >> anotherNumber [
	self number
]

{ #category : #accessing }
GtPharoDummyTwoObject >> number [
	super number.
	self one.
	self three.
	thisContext compiledCode.
	self class new one.
]

{ #category : #accessing }
GtPharoDummyTwoObject >> one [
	super one.
	^ 1.1
]

{ #category : #accessing }
GtPharoDummyTwoObject >> printString [
	^ super printString
]
