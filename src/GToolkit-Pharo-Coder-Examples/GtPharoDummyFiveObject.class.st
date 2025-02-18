"
I have couple of long methods to exemplify scrolling actions.
"
Class {
	#name : #GtPharoDummyFiveObject,
	#superclass : #GtPharoDummyFourObject,
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #accessing }
GtPharoDummyFiveObject class >> sum21Reference [
	^ GtPharoDummyTwoObject sum21Reference
]

{ #category : #accessing }
GtPharoDummyFiveObject >> anotherLongMethod [
	| aValue |
	aValue := 1.
	self yetAnotherLongMethod.
	aValue := 2.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	aValue := 3.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	aValue := 4.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	aValue := 5.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	self yetAnotherLongMethod.
	^ 6
]

{ #category : #accessing }
GtPharoDummyFiveObject >> veryLongMethod [
	| aValue |
	aValue := 1.
	self anotherLongMethod.
	aValue := 2.
	self anotherLongMethod.
	self anotherLongMethod.
	aValue := 3.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	aValue := 4.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	aValue := 5.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	self anotherLongMethod.
	aValue := 6.
	self anotherLongMethod.
	^ 7
]

{ #category : #accessing }
GtPharoDummyFiveObject >> yetAnotherLongMethod [
	| aValue |
	aValue := 1.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	aValue := 2.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	aValue := 3.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	aValue := 4.
	self veryLongMethod.
	self veryLongMethod.
	self veryLongMethod.
	^ 5
]
