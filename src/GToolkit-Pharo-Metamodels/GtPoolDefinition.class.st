Class {
	#name : #GtPoolDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtPoolDefinition class >> fromPool: aSharedPoolClass [
	^ self new fromPool: aSharedPoolClass
]

{ #category : #converting }
GtPoolDefinition >> asDefinitionString [
	^ self name
]

{ #category : #testing }
GtPoolDefinition >> exists [
	^ Smalltalk globals includesKey: self name asSymbol
]

{ #category : #'instance creation' }
GtPoolDefinition >> fromPool: aSharedPoolClass [
	name := aSharedPoolClass name
]

{ #category : #accessing }
GtPoolDefinition >> name [
	^ name
]

{ #category : #accessing }
GtPoolDefinition >> name: aSymbol [
	name := aSymbol asSymbol
]

{ #category : #accessing }
GtPoolDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	name := name copy.
]

{ #category : #printing }
GtPoolDefinition >> printOn: aStream [
	aStream print: self name
]

{ #category : #accessing }
GtPoolDefinition >> storeOn: aStream [
	<generatedFrom: #'GtPharoMethodTemplates>>#storeOnTemplate'>
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: 'new'.
	aStream
		space;
		nextPutAll: 'name:';
		space;
		store: self name.
	aStream
		nextPut: $)
]
