Class {
	#name : #GtPharoPackageTagsCoder,
	#superclass : #GtCodersModel,
	#traits : 'TGtCoderTrait',
	#classTraits : 'TGtCoderTrait classTrait',
	#instVars : [
		'package'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoPackageTagsCoder class >> forPackage: aRPackage [
	self
		assert: [ aRPackage notNil ]
		description: [ 'Package must not be nil' ].

	^ self new forPackage: aRPackage
]

{ #category : #initialization }
GtPharoPackageTagsCoder >> forPackage: aRPackage [
	self forItems: aRPackage tags asOrderedCollection
]

{ #category : #'gt-extensions' }
GtPharoPackageTagsCoder >> gtLiveFor: aView [
	<gtView>
	
	^ aView empty
]

{ #category : #'gt-extensions' }
GtPharoPackageTagsCoder >> gtPackageTagsFor: aView [
	<gtView>

	^ aView list
		title: 'Tags';
		priority: 10;
		items: [ self coders ];
		itemText: [ :eachPackageTagCoder | eachPackageTagCoder packageTagName ]
]

{ #category : #initialization }
GtPharoPackageTagsCoder >> initialize [
	super initialize.
	
	
]

{ #category : #private }
GtPharoPackageTagsCoder >> newCoderFor: anObject [
	^ GtPharoPackageTagCoder forPackageTag: anObject
]

{ #category : #'private - event handling' }
GtPharoPackageTagsCoder >> onSystemPackageRegistered: aRPackageRegistered [
]

{ #category : #'private - event handling' }
GtPharoPackageTagsCoder >> onSystemPackageRenamed: aRPackageRenamed [
]

{ #category : #'private - event handling' }
GtPharoPackageTagsCoder >> onSystemPackageTagAdded: aClassTagAdded [
]

{ #category : #'private - event handling' }
GtPharoPackageTagsCoder >> onSystemPackageTagRemoved: aClassTagRemoved [
]

{ #category : #'private - event handling' }
GtPharoPackageTagsCoder >> onSystemPackageUnregistered: aRPackageUnregistered [
]

{ #category : #'private - subscriptions' }
GtPharoPackageTagsCoder >> subscribeToSystem [
	self unsubscribeFromSystem.
	
	SystemAnnouncer uniqueInstance weak
		when: PackageAdded send: #onSystemPackageRegistered: to: self;
		when: PackageRenamed send: #onSystemPackageRenamed: to: self;
		when: PackageRemoved send: #onSystemPackageUnregistered: to: self;
		when: PackageTagAdded send: #onSystemPackageTagAdded: to: self;
		when: PackageTagRemoved send: #onSystemPackageTagRemoved: to: self
]
