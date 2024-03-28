Class {
	#name : #GtPharoDummyOneObject,
	#superclass : #Object,
	#instVars : [
		'instA'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #accessing }
GtPharoDummyOneObject >> * anObject [
	self shouldNotImplement
]

{ #category : #accessing }
GtPharoDummyOneObject >> enumerate [
	^ #(3 6 9) inject: 1 into: [ :result :value | result raisedTo: value ]
]

{ #category : #initialization }
GtPharoDummyOneObject >> initialize [
	super initialize.
	instA := 42
]

{ #category : #accessing }
GtPharoDummyOneObject >> instAPlusOne [
	^ self sumA: instA b: instA
]

{ #category : #accessing }
GtPharoDummyOneObject >> instAReceiver [
	| a |
	a := 3.
	^ instA raisedTo: a
]

{ #category : #accessing }
GtPharoDummyOneObject >> number [
	^ self one
]

{ #category : #accessing }
GtPharoDummyOneObject >> one [
	self printString.
	^ 1
]

{ #category : #accessing }
GtPharoDummyOneObject >> sum21 [
	| a |
	a := 2.
	^ self sumC: a d: 1
]

{ #category : #accessing }
GtPharoDummyOneObject >> sum39 [
	| a b |
	a := 3.
	b := 9.
	^ self sumA: a b: b
]

{ #category : #accessing }
GtPharoDummyOneObject >> sum42 [
	| a b |
	a := 4.
	b := 2.
	^ self sumC: a d: b
]

{ #category : #accessing }
GtPharoDummyOneObject >> sumA: valueA b: valueB [
	^ valueA + valueB
]

{ #category : #accessing }
GtPharoDummyOneObject >> sumC: tempA d: tempB [
	^ self sumA: tempA b: tempB
]

{ #category : #accessing }
GtPharoDummyOneObject >> tempReceiver [
	| a b |
	a := 3.
	b := 9.
	^ a raisedTo: b
]

{ #category : #accessing }
GtPharoDummyOneObject >> three [
	^ self two + self one
]

{ #category : #accessing }
GtPharoDummyOneObject >> two [
	^ self one + self one
]
