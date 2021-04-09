Class {
	#name : #GtPharoEnvironment,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Metamodels-Environment'
}

{ #category : #'api - environment' }
GtPharoEnvironment >> asArray [
	^ self subclassResponsibility
]

{ #category : #'api - environment' }
GtPharoEnvironment >> at: aSymbol [
	^ self subclassResponsibility
]

{ #category : #'api - environment' }
GtPharoEnvironment >> at: aSymbol ifAbsentPut: anObject [
	self subclassResponsibility
]

{ #category : #'api - environment' }
GtPharoEnvironment >> at: aSymbol ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	self subclassResponsibility
]

{ #category : #'api - environment' }
GtPharoEnvironment >> registerBehavior: aBehaviorDefinition [
	^ self subclassResponsibility
]
