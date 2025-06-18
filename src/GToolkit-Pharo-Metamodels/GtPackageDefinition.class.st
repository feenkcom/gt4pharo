Class {
	#name : #GtPackageDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'name',
		'originalName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtPackageDefinition class >> empty [
	^ self new empty
]

{ #category : #'instance creation' }
GtPackageDefinition class >> fromBehavior: aBehavior [
	^ self new fromBehavior: aBehavior
]

{ #category : #converting }
GtPackageDefinition >> asDefinitionString [
	^ self name
]

{ #category : #'api - accepting' }
GtPackageDefinition >> differenceWith: aPackageDefinition [
	<return: #GtCodeDefinitionDifference>
	
	^ self name = aPackageDefinition name
		ifTrue: [ GtNoDefinitionDifference new ]
		ifFalse: [ GtPackageDefinitionDifference new
			oldName: aPackageDefinition name;
			newName: self name ]
]

{ #category : #initialization }
GtPackageDefinition >> empty [
	name := #''.
	originalName := name
]

{ #category : #testing }
GtPackageDefinition >> exists [
	^ self rpackage notNil
]

{ #category : #initialization }
GtPackageDefinition >> fromBehavior: aBehavior [
	name := aBehavior package name.
	originalName := name
]

{ #category : #initialization }
GtPackageDefinition >> initialize [
	super initialize.
]

{ #category : #accessing }
GtPackageDefinition >> name [
	^ name
]

{ #category : #accessing }
GtPackageDefinition >> name: aSymbol [
	| anOldName |
	
	anOldName := name.
	name := aSymbol asSymbol.

	name = anOldName
		ifTrue: [ ^ self ].

	self
		notifyPackageRenamed: self
		from: anOldName
		to: name
]

{ #category : #'private - notifying' }
GtPackageDefinition >> notifyPackageRenamed: aGtPackageDefinition from: anOldName to: aNewName [
	self dispatchEvent: (GtBehaviorPackageRenamed new
		owner: self parent;
		package: aGtPackageDefinition;
		oldName: anOldName;
		newName: aNewName)
]

{ #category : #accessing }
GtPackageDefinition >> originalName [
	^ originalName
]

{ #category : #accessing }
GtPackageDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	name := name copy.
	originalName := originalName copy.
]

{ #category : #accessing }
GtPackageDefinition >> rpackage [
	^ self packageOrganizer
		packageNamed: self name asSymbol
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPackageDefinition >> storeOn: aStream [
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
