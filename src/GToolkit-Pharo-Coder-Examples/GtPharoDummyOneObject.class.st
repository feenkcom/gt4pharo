Class {
	#name : #GtPharoDummyOneObject,
	#superclass : #Object,
	#instVars : [
		'instA'
	],
	#classVars : [
		'VarA'
	],
	#classInstVars : [
		'instA'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #accessing }
GtPharoDummyOneObject class >> instA [
	^ instA
]

{ #category : #accessing }
GtPharoDummyOneObject class >> instA: anObject [
	instA := anObject
]

{ #category : #accessing }
GtPharoDummyOneObject class >> sum21 [
	^ 12
]

{ #category : #accessing }
GtPharoDummyOneObject class >> varA [
	^ VarA
]

{ #category : #accessing }
GtPharoDummyOneObject class >> varA: anObject [
	VarA := anObject
]

{ #category : #accessing }
GtPharoDummyOneObject >> * anObject [
	self shouldNotImplement
]

{ #category : #examples }
GtPharoDummyOneObject >> assertValue: aValue [
	self assert: aValue isNotNil description: [ 'Value must not be nil' ].
	self assert: aValue > 0 description: [ 'Value must be positive number' ].
	self assert: aValue > 5 description: [ 'Value must be bigger than 5' ].
	self assert: aValue < 10 description: [ 'Value must be less than 10' ]
]

{ #category : #accessing }
GtPharoDummyOneObject >> dummyThree [
	| a |
	a := GtPharoDummyThreeObject new.
	a printString.
	^ a
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
GtPharoDummyOneObject >> instA [
	^ instA
]

{ #category : #accessing }
GtPharoDummyOneObject >> instA: anObject [
	instA := anObject
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
GtPharoDummyOneObject >> longMethod [
	| aValue |
	aValue := 1.
	aValue := aValue + 1.
	aValue := aValue + 2.
	aValue := aValue + 3.
	aValue := self togetherWith: aValue.
	#(5 6) 
		inject: aValue 
		into: [ :aSum :anotherValue |
			aSum + anotherValue ].
	aValue := aValue + 7.
	aValue := aValue + 8.
	aValue := aValue + 9.
	aValue := aValue + 10.
	aValue := aValue + 11.
	aValue := aValue + 12.
	aValue := aValue + 13.
	aValue := aValue + 14.
	aValue := aValue + 15.
	aValue := aValue + 16.
	aValue := aValue + 17.
	aValue := aValue + 18.
	aValue := aValue + 19.
	aValue := aValue + 20.
	aValue := aValue + 21.
	^ aValue
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

{ #category : #examples }
GtPharoDummyOneObject >> successfulExample [
	<gtExample>
	^ self one + self three
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
GtPharoDummyOneObject >> sumOneTwoOnSelfArgument [
	^ self sumOneTwoOnSelfObject: self
]

{ #category : #accessing }
GtPharoDummyOneObject >> sumOneTwoOnSelfObject: anObject [
	^ self sumC: anObject one d: anObject two
]

{ #category : #accessing }
GtPharoDummyOneObject >> sumOneTwoOnSuperArgument [
	^ self sumOneTwoOnSelfObject: super
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
GtPharoDummyOneObject >> togetherWith: aValue [
	| anotherValue |
	anotherValue := aValue + 4.
	^ anotherValue
]

{ #category : #accessing }
GtPharoDummyOneObject >> two [
	^ self one + self one
]

{ #category : #accessing }
GtPharoDummyOneObject >> varA [
	^ VarA
]
