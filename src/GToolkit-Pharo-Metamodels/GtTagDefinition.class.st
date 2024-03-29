Class {
	#name : #GtTagDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'name',
		'originalName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtTagDefinition class >> empty [
	^ self new empty
]

{ #category : #'instance creation' }
GtTagDefinition class >> fromBehavior: aBehavior [
	^ self new fromBehavior: aBehavior
]

{ #category : #'instance creation' }
GtTagDefinition class >> named: aSymbol [
	^ self new
		name: aSymbol;
		originalName: aSymbol
]

{ #category : #converting }
GtTagDefinition >> asDefinitionString [
	^ self name
]

{ #category : #'api - accepting' }
GtTagDefinition >> differenceWith: aTagDefinition [
	<return: #GtCodeDefinitionDifference>
	
	^ self name = aTagDefinition name
		ifTrue: [ GtNoDefinitionDifference new ]
		ifFalse: [ GtTagDefinitionDifference new
			oldName: aTagDefinition name;
			newName: self name ]
]

{ #category : #initialization }
GtTagDefinition >> empty [
	name := #''.
	originalName := name
]

{ #category : #initialization }
GtTagDefinition >> fromBehavior: aBehavior [
	| aCategoryName aPackageName aTagString |

	aCategoryName := aBehavior category.
	aPackageName := aBehavior package name.
	
	aTagString := (aCategoryName beginsWith: aPackageName)
		ifFalse: [ '' ]
		ifTrue: [ aCategoryName allButFirst: aPackageName size ].
		
	aTagString := aTagString trimBoth: [ :aChar | (aChar = $-) or: [ aChar isSeparator ] ].

	name := aTagString.
	originalName := aTagString
]

{ #category : #initialization }
GtTagDefinition >> initialize [
	super initialize
]

{ #category : #accessing }
GtTagDefinition >> name [
	^ name
]

{ #category : #accessing }
GtTagDefinition >> name: aSymbol [
	| anOldName |
	
	anOldName := name.
	name := aSymbol asSymbol.

	name = anOldName
		ifTrue: [ ^ self ].

	self
		notifyTagRenamed: self
		from: anOldName
		to: name
]

{ #category : #'private - notifying' }
GtTagDefinition >> notifyTagRenamed: aTagDefinition from: anOldName to: aNewName [
	self dispatchEvent: (GtBehaviorTagRenamed new
		owner: self parent;
		tag: aTagDefinition;
		oldName: anOldName;
		newName: aNewName)
]

{ #category : #accessing }
GtTagDefinition >> originalName [
	^ originalName
]

{ #category : #accessing }
GtTagDefinition >> originalName: aSymbolOrString [
	originalName := aSymbolOrString asSymbol
]

{ #category : #accessing }
GtTagDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	name := name copy.
	originalName := originalName copy.
]

{ #category : #printing }
GtTagDefinition >> printOn: aStream [
	aStream print: self name
]

{ #category : #accessing }
GtTagDefinition >> storeOn: aStream [
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
