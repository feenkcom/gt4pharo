Class {
	#name : #GtPharoPackageTagCoders,
	#superclass : #GtCodersModel,
	#traits : 'TGtCoderTrait',
	#classTraits : 'TGtCoderTrait classTrait',
	#instVars : [
		'package'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoPackageTagCoders class >> forPackage: aRPackage [
	self
		assert: [ aRPackage notNil ]
		description: [ 'Package must not be nil' ].

	^ self new forPackage: aRPackage
]

{ #category : #initialization }
GtPharoPackageTagCoders >> forPackage: aRPackage [
	self forItems: aRPackage classTags asOrderedCollection
]

{ #category : #'gt-extensions' }
GtPharoPackageTagCoders >> gtLiveFor: aView [
	<gtView>
	
	^ aView empty
]

{ #category : #'gt-extensions' }
GtPharoPackageTagCoders >> gtPackageTagsFor: aView [
	<gtView>

	^ aView list
		title: 'Tags';
		priority: 10;
		items: [ self coders ];
		itemText: [ :eachPackageTagCoder | eachPackageTagCoder packageTagName ]
]

{ #category : #initialization }
GtPharoPackageTagCoders >> initialize [
	super initialize.
	
	
]

{ #category : #private }
GtPharoPackageTagCoders >> newCoderFor: anObject [
	^ GtPharoPackageTagCoder forPackageTag: anObject
]

{ #category : #'private - event handling' }
GtPharoPackageTagCoders >> onSystemPackageRegistered: aRPackageRegistered [
]

{ #category : #'private - event handling' }
GtPharoPackageTagCoders >> onSystemPackageRenamed: aRPackageRenamed [
]

{ #category : #'private - event handling' }
GtPharoPackageTagCoders >> onSystemPackageTagAdded: aClassTagAdded [
]

{ #category : #'private - event handling' }
GtPharoPackageTagCoders >> onSystemPackageTagRemoved: aClassTagRemoved [
]

{ #category : #'private - event handling' }
GtPharoPackageTagCoders >> onSystemPackageUnregistered: aRPackageUnregistered [
]

{ #category : #'private - subscriptions' }
GtPharoPackageTagCoders >> subscribeToSystem [
	self unsubscribeFromSystem.
	
	SystemAnnouncer uniqueInstance weak
		when: RPackageRegistered send: #onSystemPackageRegistered: to: self;
		when: RPackageRenamed send: #onSystemPackageRenamed: to: self;
		when: RPackageUnregistered send: #onSystemPackageUnregistered: to: self;
		when: ClassTagAdded send: #onSystemPackageTagAdded: to: self;
		when: ClassTagRemoved send: #onSystemPackageTagRemoved: to: self
]
