Class {
	#name : #GtPharoTestCaseStateFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'resultState',
		'pharoTestSuite'
	],
	#category : 'GToolkit-Pharo-TestSuite-Filters'
}

{ #category : #accessing }
GtPharoTestCaseStateFilter class >> defaultState [

	^ GtPharoMethodTestCaseAllState
]

{ #category : #comparing }
GtPharoTestCaseStateFilter >> = anObject [
	^ self class = anObject class
		and: [ self resultState = anObject resultState
				and: [ self pharoTestSuite = anObject pharoTestSuite ] ]
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> filterValueString [

	^ self resultState label
]

{ #category : #printing }
GtPharoTestCaseStateFilter >> gtDisplayOn: stream [
	stream nextPutAll: (self resultState ifNotNil: #label)
]

{ #category : #comparing }
GtPharoTestCaseStateFilter >> hash [
	^ (self class hash bitXor: self resultState hash)
		bitXor: self pharoTestSuite hash
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> includesMethod: aCompiledMethod [
	| aTestCase |
	aTestCase := self pharoTestSuite testCaseForMethod: aCompiledMethod.
	^ aTestCase notNil and: [ self resultState includesTestCase: aTestCase ]
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> pharoTestSuite [

	^ pharoTestSuite
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> pharoTestSuite: anObject [

	pharoTestSuite := anObject
]

{ #category : #printing }
GtPharoTestCaseStateFilter >> printOn: aStream [

	super printOn: aStream.
	self resultState ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		print: self resultState;
		nextPut: $)
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> resultState [

	^ resultState
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> resultState: aState [

	resultState := aState
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> resultStateString: aString [
	self resultState: (GtPharoMethodTestCaseState stateFromLabel: aString)
]
