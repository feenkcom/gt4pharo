Class {
	#name : #GtPharoPackageCoder,
	#superclass : #GtPackageCoder,
	#instVars : [
		'package',
		'classesCoder',
		'packageTagsCoder'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoPackageCoder class >> forPackage: anRPackage [
	^ self new
		forPackage: anRPackage;
		yourself
]

{ #category : #'private - adding / removing' }
GtPharoPackageCoder >> addMissingPackageTag: aPackageTag [
	<return: #GtPharoPackageTagCoder>
	| aCoder |
	aCoder := self newPackageTagCoderFor: aPackageTag.
	self packageTagsCoder addCoder: aCoder.
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
	<return: #Collection of: #Behavior>

	self packageDo: [ :aRPackage | ^ aRPackage classes ].
	^ #()
]

{ #category : #accessing }
GtPharoPackageCoder >> classesCoder [
	<return: #GtPharoClassesCoder>

	^ classesCoder ifNil: [ classesCoder := GtPharoClassesCoder new forPackage: self package ]
]

{ #category : #accessing }
GtPharoPackageCoder >> coderForClass: aClass [
	^ self classesCoder coderForClass: aClass
]

{ #category : #accessing }
GtPharoPackageCoder >> coderName [
	^ self packageName
]

{ #category : #accessing }
GtPharoPackageCoder >> coders [
	^ self classesCoder coders
]

{ #category : #initialization }
GtPharoPackageCoder >> forPackage: aRPackage [
	package := GtPharoCoderPackage explicit: aRPackage.
	packageTagsCoder ifNotNil: [ :aPackageTagsCoder | aPackageTagsCoder forPackage: aRPackage ].
	classesCoder ifNotNil: [ :aClassesCoder | aClassesCoder forPackage: aRPackage ]
]

{ #category : #accessing }
GtPharoPackageCoder >> icon [
	^ BrGlamorousIcons packageicon asElement
]

{ #category : #initialization }
GtPharoPackageCoder >> initialize [
	super initialize.
	
	package := GtPharoCoderPackage unspecified.
	packageTagsCoder := nil.
	classesCoder := nil
]

{ #category : #testing }
GtPharoPackageCoder >> isRegistered [
	"Return true if the package is registered in the system, false otherwise"
	<return: #Boolean>
	
	^ package exists
]

{ #category : #accessing }
GtPharoPackageCoder >> name [
	<return: #String>

	self
		deprecated: 'Use #packageName instead.'
		transformWith: '`@receiver name' -> '`@receiver packageName'.

	^ self packageName
]

{ #category : #'private - instance creation' }
GtPharoPackageCoder >> newPackageTagCoderFor: aPackageTag [
	^ GtPharoPackageTagCoder new
		packageTag: aPackageTag;
		packageCoder: self;
		yourself
]

{ #category : #'private - instance creation' }
GtPharoPackageCoder >> newPackageTagsCoder [
	^ package
		realPackageDo: [ :aRPackage |
			GtPharoPackageTagsCoder forPackage: aRPackage ]
		ifAbsent: [ GtPharoPackageTagsCoder new ]
]

{ #category : #'private - event handling' }
GtPharoPackageCoder >> onSystemPackageRegistered: anAnnouncement [
	(package affectedByPackageRegistered: anAnnouncement)
		ifFalse: [ ^ self ].

	package := package affectByPackageRegistered: anAnnouncement.
	self notifyPackageRegistered
]

{ #category : #'private - event handling' }
GtPharoPackageCoder >> onSystemPackageRenamed: anAnnouncement [
	(package affectedByPackageRenamed: anAnnouncement)
		ifFalse: [ ^ self ].

	package := package affectByPackageRenamed: anAnnouncement.
	self notifyPackageRenamed
]

{ #category : #'private - event handling' }
GtPharoPackageCoder >> onSystemPackageUnregistered: anAnnouncement [
	(package affectedByPackageUnregistered: anAnnouncement)
		ifFalse: [ ^ self ].

	package := package affectByPackageUnregistered: anAnnouncement.
	self notifyPackageUnregistered
]

{ #category : #accessing }
GtPharoPackageCoder >> package [
	<return: #Package>

	^ package realPackageDo: [ :aRPackage | ^ aRPackage ]
]

{ #category : #accessing }
GtPharoPackageCoder >> package: aRPackage [
	self
		deprecated: 'Please use forPackage: methods instead.'
		transformWith:
			'`@receiver package: `@statements1'
				-> '`@receiver forPackage: `@statements1'.
				
	^ self forPackage: aRPackage
]

{ #category : #accessing }
GtPharoPackageCoder >> packageDo: aBlock [
	"Evaluate a given Block with an RPackage if it is registered in the system,
	do nothing otherwise"

	package realPackageDo: aBlock
]

{ #category : #accessing }
GtPharoPackageCoder >> packageName [
	^ package packageNameDo: [ :aPackageName | ^ aPackageName ]
]

{ #category : #accessing }
GtPharoPackageCoder >> packageTagCoderFor: aPackageTag [
	^ self packageTagsCoder coders
		detect: [ :each | each packageTag = aPackageTag ]
		ifNone: [ self addMissingPackageTag: aPackageTag ]
]

{ #category : #accessing }
GtPharoPackageCoder >> packageTagForClass: aClass [
	^ (package tagOrNilOf: aClass)
		ifNotNil: [ :tag | 
			self packageTagsCoder coders
				detect: [ :each | each packageTag = tag ]
				ifNone: [  ] ]
]

{ #category : #accessing }
GtPharoPackageCoder >> packageTagsCoder [
	<return: #GtPharoPackageTagsCoder>

	^ packageTagsCoder ifNil: [ packageTagsCoder := self newPackageTagsCoder ]
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
	package renamePackageTo: aNewPackageName
]

{ #category : #'private - actions' }
GtPharoPackageCoder >> primitiveUnregisterPackage [
	GtPharoCodeModifier unregisterPackage: self package
]

{ #category : #printing }
GtPharoPackageCoder >> printOn: aStream [
	aStream
		nextPutAll: 'Package Coder';
		space;
		nextPut: $(;
		print: self packageName;
		nextPut: $)
]

{ #category : #subscriptions }
GtPharoPackageCoder >> subscribeToSystem [	
	SystemAnnouncer uniqueInstance weak
		when: RPackageRegistered send: #onSystemPackageRegistered: to: self;
		when: RPackageRenamed send: #onSystemPackageRenamed: to: self;
		when: RPackageUnregistered send: #onSystemPackageUnregistered: to: self
]
