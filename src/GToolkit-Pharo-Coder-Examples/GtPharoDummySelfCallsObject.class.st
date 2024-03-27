Class {
	#name : #GtPharoDummySelfCallsObject,
	#superclass : #Object,
	#instVars : [
		'instA'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #accessing }
GtPharoDummySelfCallsObject >> * anObject [
	self shouldNotImplement
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> enumerate [
	^ #(3 6 9) inject: 1 into: [ :result :value | result raisedTo: value ]
]

{ #category : #initialization }
GtPharoDummySelfCallsObject >> initialize [
	super initialize.
	instA := 42
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> instAPlusOne [
	^ self sumA: instA b: instA
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> instAReceiver [
	| a |
	a := 3.
	^ instA raisedTo: a
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> number [
	^ self one
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> one [
	self printString.
	^ 1
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> sum21 [
	| a |
	a := 2.
	^ self sumC: a d: 1
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> sum39 [
	| a b |
	a := 3.
	b := 9.
	^ self sumA: a b: b
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> sum42 [
	| a b |
	a := 4.
	b := 2.
	^ self sumC: a d: b
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> sumA: valueA b: valueB [
	^ valueA + valueB
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> sumC: tempA d: tempB [
	^ self sumA: tempA b: tempB
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> tempReceiver [
	| a b |
	a := 3.
	b := 9.
	^ a raisedTo: b
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> three [
	^ self two + self one
]

{ #category : #accessing }
GtPharoDummySelfCallsObject >> two [
	^ self one + self one
]
