Class {
	#name : #GtCompositeDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'definitions'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtCompositeDefinition class >> empty [
	^ self new
]

{ #category : #accessing }
GtCompositeDefinition >> all [
	<return: #Collection of: #GtCodeDefinition>

	^ definitions
]

{ #category : #accessing }
GtCompositeDefinition >> at: anIndex [
	<return: #GtCodeDefinition>

	^ definitions at: anIndex
]

{ #category : #enumerating }
GtCompositeDefinition >> collect: aBlock [
	^ definitions collect: aBlock
]

{ #category : #'private - accessing' }
GtCompositeDefinition >> definitionNamed: aSymbol ifNone: anExceptionBlock [
	<return: #GtCodeDefinition>
	
	^ definitions
		detect: [ :eachDefinition | eachDefinition name = aSymbol asSymbol ]
		ifNone: anExceptionBlock
]

{ #category : #'private - accessing' }
GtCompositeDefinition >> definitions [
	^ definitions
]

{ #category : #'private - accessing' }
GtCompositeDefinition >> definitions: anArrayOfDefinitions [
	definitions := anArrayOfDefinitions asArray.
	definitions do: [ :each | each parent: self ]
]

{ #category : #enumerating }
GtCompositeDefinition >> do: aBlock [
	definitions do: aBlock
]

{ #category : #'private - testing' }
GtCompositeDefinition >> hasDefinitionNamed: aSymbol [
	<return: #Boolean>

	^ definitions
		detect: [ :eachDefinition | eachDefinition name = aSymbol ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #initialization }
GtCompositeDefinition >> initialize [
	super initialize.
	
	definitions := #()
]

{ #category : #accessing }
GtCompositeDefinition >> isEmpty [
	<return: #Boolean>

	^ self size isZero
]

{ #category : #accessing }
GtCompositeDefinition >> name [
	^ self shouldNotImplement
]

{ #category : #accessing }
GtCompositeDefinition >> names [
	<return: #Collection of: #Symbol>
	
	^ definitions collect: [ :eachDefinition | eachDefinition name ]
]

{ #category : #accessing }
GtCompositeDefinition >> parent: aParent [
	super parent: aParent.
	
	definitions do: [ :eachDefinition | eachDefinition parent: aParent ]
]

{ #category : #accessing }
GtCompositeDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	self definitions: (definitions collect: [ :eachDefinition | eachDefinition copy ]).
]

{ #category : #enumerating }
GtCompositeDefinition >> removeSuchThat: aBlock [
	definitions := definitions reject: aBlock
]

{ #category : #accessing }
GtCompositeDefinition >> size [
	<return: #Number>

	^ definitions size
]

{ #category : #accessing }
GtCompositeDefinition >> storeOn: aStream [
	<generatedFrom: #'GtPharoMethodTemplates>>#storeOnTemplate'>
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: 'new'.
	aStream
		space;
		nextPutAll: 'definitions:';
		space;
		store: self definitions.
	aStream
		nextPut: $)
]
