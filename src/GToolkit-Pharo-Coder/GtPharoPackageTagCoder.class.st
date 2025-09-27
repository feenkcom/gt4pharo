Class {
	#name : #GtPharoPackageTagCoder,
	#superclass : #GtCoderModel,
	#traits : 'TGtCoderTrait',
	#classTraits : 'TGtCoderTrait classTrait',
	#instVars : [
		'packageTag',
		'packageCoder',
		'classesCoder'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoPackageTagCoder class >> forPackageTag: aPackageTag [
	^ self new
		packageTag: aPackageTag;
		yourself
]

{ #category : #'api - converting' }
GtPharoPackageTagCoder >> asNewCoderModelWithSameSubject [
	"Return new coder model with same subject (e.g., package, class, method)"
	<return: #GtCoderModel>
	^ self class forPackageTag: self packageTag
]

{ #category : #asserting }
GtPharoPackageTagCoder >> assertCoder: aCoder [
	self 
		assert: [ aCoder isNotNil ]
		description: [ 'Coder must be non-nil' ].
]

{ #category : #accessing }
GtPharoPackageTagCoder >> classesCoder [
	^ classesCoder
		ifNil: [ classesCoder := GtPharoClassesCoder new.
			packageTag notNil
				ifTrue: [ classesCoder forPackageTag: packageTag ].
			classesCoder ]
]

{ #category : #accessing }
GtPharoPackageTagCoder >> coderForClass: aClass [
	^ packageCoder coderForClass: aClass
]

{ #category : #accessing }
GtPharoPackageTagCoder >> coderName [
	^ self packageTagName
]

{ #category : #accessing }
GtPharoPackageTagCoder >> coders [
	^ self classesCoder coders
]

{ #category : #ui }
GtPharoPackageTagCoder >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Package tag';
		priority: 1;
		stencil: [ self ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			action: [ :aButton | aButton phlow spawnObject: self packageTag ]
]

{ #category : #accessing }
GtPharoPackageTagCoder >> icon [
	^ BrGlamorousVectorIcons packageicon asElement
]

{ #category : #testing }
GtPharoPackageTagCoder >> isForPackageTag [
	^ true
]

{ #category : #accessing }
GtPharoPackageTagCoder >> name [
	^ packageTag name
]

{ #category : #accessing }
GtPharoPackageTagCoder >> package [
	^ packageTag package
]

{ #category : #accessing }
GtPharoPackageTagCoder >> packageCoder [
	^ packageCoder ifNil: [ packageCoder := GtPharoPackageCoder forPackage: self package ]
]

{ #category : #accessing }
GtPharoPackageTagCoder >> packageCoder: aPackageCoder [
	self assertCoder: aPackageCoder.
	packageCoder := aPackageCoder
]

{ #category : #accessing }
GtPharoPackageTagCoder >> packageTag [
	^ packageTag
]

{ #category : #accessing }
GtPharoPackageTagCoder >> packageTag: anObject [
	packageTag := anObject
]

{ #category : #accessing }
GtPharoPackageTagCoder >> packageTagName [
	^ packageTag name
]

{ #category : #printing }
GtPharoPackageTagCoder >> printOn: aStream [
	aStream
		nextPutAll: 'Package Tag Coder';
		space;
		nextPut: $(;
		print: self packageTagName;
		nextPut: $)
]

{ #category : #actions }
GtPharoPackageTagCoder >> unload [
	self packageTag classes do: [ :each | each removeFromSystem ].
	self packageTag removeFromPackage
]
