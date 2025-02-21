Class {
	#name : #GtPharoDummyTwoObject,
	#superclass : #GtPharoDummyOneObject,
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #accessing }
GtPharoDummyTwoObject class >> anotherSum21Reference [
	^ self sum21
]

{ #category : #accessing }
GtPharoDummyTwoObject class >> sum21Reference [
	^ self sum21
]

{ #category : #examples }
GtPharoDummyTwoObject >> anotherExampleCallingSuperclassExample [
	<gtExample>
	^ self successfulExample
]

{ #category : #accessing }
GtPharoDummyTwoObject >> anotherNumber [
	self number
]

{ #category : #accessing }
GtPharoDummyTwoObject >> callMethodWithSubclassResponsibility [
	self methodWithSubclassResponsibility
]

{ #category : #examples }
GtPharoDummyTwoObject >> failingExample [
	<gtExample>
	<noTest>
	| aValue |
	aValue := 1.
	aValue := aValue + 1.
	self assertValue: aValue.
	^ aValue
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

{ #category : #accessing }
GtPharoDummyTwoObject >> sum21Reference [
	^ self sum21
]
