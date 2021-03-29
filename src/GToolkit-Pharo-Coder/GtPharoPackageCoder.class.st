Class {
	#name : #GtPharoPackageCoder,
	#superclass : #GtPackageCoder,
	#instVars : [
		'package',
		'packageTagCoders',
		'classesCoder'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoPackageCoder class >> forPackage: anRPackage [
	^ self new
		package: anRPackage;
		yourself
]

{ #category : #'private - adding / removing' }
GtPharoPackageCoder >> addMissingPackageTag: aPackageTag [
	<return: #GtPharoPackageTagCoder>
	| aCoder |
	aCoder := self newPackageTagCoderFor: aPackageTag.
	self packageTagCoders add: aCoder.
	^ aCoder
]

{ #category : #'api - converting' }
GtPharoPackageCoder >> asNewCoderModelWithSameSubject [
	"Return new coder model with same subject (e.g., package, class, method)"
	<return: #GtCoderModel>

	^ self class forPackage: self package
]

{ #category : #accessing }
GtPharoPackageCoder >> classes [
	^ self package classes
]

{ #category : #accessing }
GtPharoPackageCoder >> classesCoder [
	<return: #GtPharoClassesCoder>

	^ classesCoder
		ifNil: [
			classesCoder := GtPharoClassesCoder new.
			classesCoder forPackage: self package.
			classesCoder ]
]

{ #category : #accessing }
GtPharoPackageCoder >> coderForClass: aClass [
	^ self classesCoder coderForClass: aClass
]

{ #category : #accessing }
GtPharoPackageCoder >> coders [
	^ self classesCoder coders
]

{ #category : #accessing }
GtPharoPackageCoder >> icon [
	^ BrGlamorousIcons packageicon asElement
]

{ #category : #testing }
GtPharoPackageCoder >> isRegistered [
	"Return true if the package is registered in the system, false otherwise"
	<return: #Boolean>
	
	^ self package organizer includesPackage: self package
]

{ #category : #accessing }
GtPharoPackageCoder >> name [
	<return: #String>

	^ package name
]

{ #category : #'private - instance creation' }
GtPharoPackageCoder >> newPackageTagCoderFor: aPackageTag [
	^ GtPharoPackageTagCoder new
		packageTag: aPackageTag;
		packageCoder: self;
		yourself
]

{ #category : #'private - instance creation' }
GtPharoPackageCoder >> newPackageTagCoders [
	^ (package classTags
			collect: [ :eachTag | self newPackageTagCoderFor: eachTag ])
				asSortedCollection: [ :a :b | a name < b name ]
]

{ #category : #'event handling' }
GtPharoPackageCoder >> onPackageRegistered: anAnnouncement [
	anAnnouncement package name = self name
		ifFalse: [ ^ self ].
		
	self notifyPackageRegistered
]

{ #category : #'event handling' }
GtPharoPackageCoder >> onPackageRenamed: anAnnouncement [
	anAnnouncement oldName = self name
		ifFalse: [ ^ self ].
	
	self notifyPackageRenamed
]

{ #category : #'event handling' }
GtPharoPackageCoder >> onPackageUnregistered: anAnnouncement [
	anAnnouncement package name = self name
		ifFalse: [ ^ self ].
		
	self notifyPackageUnregistered
]

{ #category : #accessing }
GtPharoPackageCoder >> package [
	<return: #RPackage>

	^ package
]

{ #category : #accessing }
GtPharoPackageCoder >> package: aRPackage [
	self
		assert: [ aRPackage notNil ]
		description: [ 'Package must not be nil' ].

	package := aRPackage.
	classesCoder ifNotNil: [ :aClassesCoder | aClassesCoder forPackage: aRPackage ]
]

{ #category : #accessing }
GtPharoPackageCoder >> packageTagCoderFor: aPackageTag [
	^ self packageTagCoders
		detect: [ :each | each packageTag = aPackageTag ]
		ifNone: [ self addMissingPackageTag: aPackageTag ]
]

{ #category : #accessing }
GtPharoPackageCoder >> packageTagCoders [
	^ packageTagCoders
		ifNil:
			[ packageTagCoders := self newPackageTagCoders ]
]

{ #category : #accessing }
GtPharoPackageCoder >> packageTagForClass: aClass [
	^ (package classTagForClass: aClass)
		ifNotNil: [ :tag | 
			self packageTagCoders
				detect: [ :each | each packageTag = tag ]
				ifNone: [  ] ]
]

{ #category : #accessing }
GtPharoPackageCoder >> packageTreeCoders [
	^ self coders
]

{ #category : #'private - actions' }
GtPharoPackageCoder >> primitiveRegisterPackage [
	GtPharoCodeModifier registerPackage: self package
]

{ #category : #'private - actions' }
GtPharoPackageCoder >> primitiveRemovePackage [
	GtPharoCodeModifier removePackage: self package
]

{ #category : #'private - actions' }
GtPharoPackageCoder >> primitiveRenamePackageTo: aNewPackageName [
	GtPharoCodeModifier renamePackage: self package to: aNewPackageName
]

{ #category : #'private - actions' }
GtPharoPackageCoder >> primitiveUnregisterPackage [
	GtPharoCodeModifier unregisterPackage: self package
]

{ #category : #subscriptions }
GtPharoPackageCoder >> subscribeToSystem [	
	SystemAnnouncer uniqueInstance weak
		when: RPackageRegistered send: #onPackageRegistered: to: self;
		when: RPackageRenamed send: #onPackageRenamed: to: self;
		when: RPackageUnregistered send: #onPackageUnregistered: to: self
]
