Class {
	#name : #GtPharoReadOnlyImageEnvironment,
	#superclass : #GtPharoEnvironment,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Pharo-Metamodels-Environment'
}

{ #category : #cleanup }
GtPharoReadOnlyImageEnvironment class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
GtPharoReadOnlyImageEnvironment class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'api - environment' }
GtPharoReadOnlyImageEnvironment >> asArray [
	^ self class environment asArray
]

{ #category : #'api - environment' }
GtPharoReadOnlyImageEnvironment >> at: aSymbol [
	^ self class environment
		at: aSymbol
]

{ #category : #'api - environment' }
GtPharoReadOnlyImageEnvironment >> at: aSymbol ifAbsentPut: anObject [
	^ self class environment
		at: aSymbol
		ifAbsent: [ anObject ]
]

{ #category : #'api - environment' }
GtPharoReadOnlyImageEnvironment >> at: aSymbol ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self class environment
		at: aSymbol
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #'api - environment' }
GtPharoReadOnlyImageEnvironment >> at: aSymbol put: anObject [
	^ anObject
]

{ #category : #'api - environment' }
GtPharoReadOnlyImageEnvironment >> registerBehavior: aBehaviorDefinition [
	^ aBehaviorDefinition
]
