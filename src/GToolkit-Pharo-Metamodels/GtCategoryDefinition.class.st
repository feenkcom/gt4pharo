Class {
	#name : #GtCategoryDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'package',
		'tag'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtCategoryDefinition class >> empty [
	^ self new empty
]

{ #category : #'instance creation' }
GtCategoryDefinition class >> fromBehavior: aBehavior [
	^ self new fromBehavior: aBehavior
]

{ #category : #converting }
GtCategoryDefinition >> asDefinitionString [
	
	^ String streamContents: [ :aStream |
		| aTag |
		aTag := self tag asDefinitionString.
	
		aStream nextPutAll: self package asDefinitionString.
		aTag ifNotEmpty: [
			aStream nextPut: $-.
			aStream nextPutAll: aTag ] ]
]

{ #category : #'api - accepting' }
GtCategoryDefinition >> createPackageChange [
	^ tag name notEmpty
		ifTrue: [ GtRBAddPackageTagChange packageName: package name tagName: tag name ]
		ifFalse: [ GtRBAddPackageChange packageName: package name ]
]

{ #category : #'api - accepting' }
GtCategoryDefinition >> differenceWith: aCategoryDefinition [
	| aDifference |
	
	self
		assert: [ aCategoryDefinition class = self class ]
		description: [ 'Must be of the same type' ].

	aDifference := GtCategoryDefinitionDifference new.
	aDifference
		oldCategory: self originalName;
		newCategory: self name.

	aDifference packageDifference: (self package differenceWith: aCategoryDefinition package).
	aDifference tagDifference: (self tag differenceWith: aCategoryDefinition tag).

	^ aDifference
]

{ #category : #initialization }
GtCategoryDefinition >> empty [
	package := GtPackageDefinition empty.	
	tag := GtTagDefinition empty
]

{ #category : #initialization }
GtCategoryDefinition >> fromBehavior: aBehavior [
	package := GtPackageDefinition fromBehavior: aBehavior.	
	tag := GtTagDefinition fromBehavior: aBehavior
]

{ #category : #testing }
GtCategoryDefinition >> isValidForCreation [
	| tagName rpackage |
	rpackage := package rpackage.
	rpackage isNil
		ifTrue: [ ^ package name notEmpty ].
	tagName := tag name.
	tagName isEmpty
		ifTrue: [ ^ false ].
	rpackage tagNamed: tagName ifAbsent: [ ^ true ].
	^ false
]

{ #category : #accessing }
GtCategoryDefinition >> name [
	^ (String streamContents: [ :aStream |
		aStream nextPutAll: self package name.
		self tag name
			ifNotEmpty: [ :aTag |
				aStream
					nextPut: $-;
					nextPutAll: aTag ] ]) asSymbol
]

{ #category : #accessing }
GtCategoryDefinition >> originalName [
	^ (String streamContents: [ :aStream |
		aStream nextPutAll: self package originalName.
		self tag originalName
			ifNotEmpty: [ :aTag |
				aStream
					nextPut: $-;
					nextPutAll: aTag ] ]) asSymbol
]

{ #category : #accessing }
GtCategoryDefinition >> package [
	^ package
]

{ #category : #'private - accessing' }
GtCategoryDefinition >> package: aPackageDefinition [
	package := aPackageDefinition parent: self
]

{ #category : #testing }
GtCategoryDefinition >> packageExists [
	^ package exists
]

{ #category : #accessing }
GtCategoryDefinition >> parent: aParent [
	super parent: aParent.
	
	package parent: aParent.
	tag parent: aParent
]

{ #category : #accessing }
GtCategoryDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	package := package copy parent: self.
	tag := tag copy parent: self.
]

{ #category : #accessing }
GtCategoryDefinition >> storeOn: aStream [
	<generatedFrom: #'GtPharoMethodTemplates>>#storeOnTemplate'>
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: 'new'.
	aStream
		space;
		nextPutAll: 'package:';
		space;
		store: self package;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'tag:';
		space;
		store: self tag.
	aStream
		nextPut: $)
]

{ #category : #accessing }
GtCategoryDefinition >> tag [
	^ tag
]

{ #category : #'private - accessing' }
GtCategoryDefinition >> tag: aTagDefinition [
	tag := aTagDefinition parent: self
]
