Class {
	#name : #GtPharoVirtualEnvironment,
	#superclass : #GtPharoEnvironment,
	#instVars : [
		'dictionary'
	],
	#category : #'GToolkit-Pharo-Metamodels-Environment'
}

{ #category : #'api - environment' }
GtPharoVirtualEnvironment >> asArray [
	^ dictionary asArray
]

{ #category : #'api - environment' }
GtPharoVirtualEnvironment >> at: aSymbol [
	self
		assert: [ aSymbol notNil ]
		description: [ 'Global name must not be nil' ].

	^ dictionary
		at: aSymbol
]

{ #category : #'api - environment' }
GtPharoVirtualEnvironment >> at: aSymbol ifAbsentPut: aBlock [
	self
		assert: [ aSymbol notNil ]
		description: [ 'Global name must not be nil' ].

	^ dictionary
		at: aSymbol
		ifAbsentPut: aBlock
]

{ #category : #'api - environment' }
GtPharoVirtualEnvironment >> at: aSymbol ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	self
		assert: [ aSymbol notNil ]
		description: [ 'Global name must not be nil' ].

	^ dictionary
		at: aSymbol
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #initialization }
GtPharoVirtualEnvironment >> initialize [
	super initialize.
	
	dictionary := Dictionary new
]

{ #category : #'api - environment' }
GtPharoVirtualEnvironment >> registerBehavior: aBehaviorDefinition [
	^ self
		at: aBehaviorDefinition name
		ifAbsentPut: [ aBehaviorDefinition ]
]
