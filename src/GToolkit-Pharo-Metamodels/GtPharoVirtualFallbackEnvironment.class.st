Class {
	#name : #GtPharoVirtualFallbackEnvironment,
	#superclass : #GtPharoEnvironment,
	#instVars : [
		'dictionary'
	],
	#category : #'GToolkit-Pharo-Metamodels-Environment'
}

{ #category : #'api - environment' }
GtPharoVirtualFallbackEnvironment >> asArray [
	^ dictionary asArray
]

{ #category : #'api - environment' }
GtPharoVirtualFallbackEnvironment >> at: aSymbol [
	self
		assert: [ aSymbol notNil ]
		description: [ 'Global name must not be nil' ].

	^ dictionary
		at: aSymbol
		ifAbsent: [ self class environment at: aSymbol ]
]

{ #category : #'api - environment' }
GtPharoVirtualFallbackEnvironment >> at: aSymbol ifAbsentPut: aBlock [
	self
		assert: [ aSymbol notNil ]
		description: [ 'Global name must not be nil' ].

	^ dictionary
		at: aSymbol
		ifAbsent: [
			self class environment
				at: aSymbol
				ifAbsent: [ dictionary at: aSymbol ifAbsentPut: aBlock ] ]
]

{ #category : #'api - environment' }
GtPharoVirtualFallbackEnvironment >> at: aSymbol ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	self
		assert: [ aSymbol notNil ]
		description: [ 'Global name must not be nil' ].

	^ dictionary
		at: aSymbol
		ifPresent: aPresentBlock
		ifAbsent: [
			self class environment
				at: aSymbol
				ifPresent: aPresentBlock
				ifAbsent: anAbsentBlock ]
]

{ #category : #compiling }
GtPharoVirtualFallbackEnvironment >> compile [
	
]

{ #category : #initialization }
GtPharoVirtualFallbackEnvironment >> initialize [
	super initialize.
	
	dictionary := Dictionary new
]

{ #category : #'api - environment' }
GtPharoVirtualFallbackEnvironment >> registerBehavior: aBehaviorDefinition [
	^ self
		at: aBehaviorDefinition name
		ifAbsentPut: [ aBehaviorDefinition ]
]
