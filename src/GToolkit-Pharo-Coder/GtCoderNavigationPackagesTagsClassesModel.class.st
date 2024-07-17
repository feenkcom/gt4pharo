Class {
	#name : #GtCoderNavigationPackagesTagsClassesModel,
	#superclass : #GtCoderNavigationModel,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'coder',
		'selectedPackage',
		'selectedTag'
	],
	#category : #'GToolkit-Pharo-Coder-Navigation'
}

{ #category : #announcer }
GtCoderNavigationPackagesTagsClassesModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #asserting }
GtCoderNavigationPackagesTagsClassesModel >> assertCoder: aCoder [
	self 
		assert: [ aCoder isNotNil ]
		description: [ 'Coder must be non-nil' ].
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> classAdded: aClassAdded [
	(self packagesToShow includes: aClassAdded packageAffected) ifFalse: [ ^ self ].
	self announcer announce: (GtCoderNavigationClassAdded new 
		coder: coder;
		package: aClassAdded packageAffected;
		tag: aClassAdded classTagAffected;
		theClass: aClassAdded classAdded)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> classModificationApplied: anAnnouncement [
	(self packagesToShow includes: anAnnouncement packageAffected) ifFalse: [ ^ self ].
	self announcer announce: (GtCoderNavigationClassModified new 
		coder: coder;
		package: anAnnouncement packageAffected;
		tag: anAnnouncement classTagAffected;
		theClass: anAnnouncement classAffected)
]

{ #category : #'api - subscriptions' }
GtCoderNavigationPackagesTagsClassesModel >> classRemoved: aClassRemoved [
	(self packagesToShow includes: aClassRemoved packageAffected)
		ifFalse: [ ^ self ].
	self announcer
		announce: (GtCoderNavigationClassRemoved new
				coder: coder;
				package: aClassRemoved packageAffected;
				tag: aClassRemoved classTagAffected;
				theClass: aClassRemoved classRemoved)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> classRenamed: aClassRenamed [
	(self packagesToShow includes: aClassRenamed packageAffected) ifFalse: [ ^ self ].
	self announcer announce: (GtCoderNavigationClassRenamed new 
		coder: coder;
		package: aClassRenamed packageAffected;
		tag: aClassRenamed classTagAffected;
		theClass: aClassRenamed classRenamed;
		oldName: aClassRenamed oldName;
		newName: aClassRenamed newName)
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> classesToShow [
	<return: #Collection of: #Class>

	self hasSelectedPackage
		ifFalse: [ ^ #() ].
		
	^ self hasSelectedTag
		ifTrue: [ self selectedTag classes ]
		ifFalse: [ self selectedPackage definedClasses ]
]

{ #category : #'private - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> coder: aCoder [
	coder == aCoder ifTrue: [ ^ self ].
	coder ifNotNil: [ :oldCoder | 
		oldCoder announcer unsubscribe: self ].
	
	coder := aCoder.
	
	"forward coder announcements"
	aCoder announcer weak
		when: Announcement
		send: #onCoderAnnouncement:
		to: self
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> coderDo: aBlock [
	coder ifNotNil: aBlock
]

{ #category : #'api - testing' }
GtCoderNavigationPackagesTagsClassesModel >> hasSelectedClass [
	<return: #Boolean>
	^ self selectedClass notNil
]

{ #category : #'api - testing' }
GtCoderNavigationPackagesTagsClassesModel >> hasSelectedPackage [
	<return: #Boolean>
	^ self selectedPackage notNil
]

{ #category : #'api - testing' }
GtCoderNavigationPackagesTagsClassesModel >> hasSelectedTag [
	<return: #Boolean>
	^ self selectedTag notNil
]

{ #category : #initialization }
GtCoderNavigationPackagesTagsClassesModel >> initialize [
	super initialize.
	self coder: GtPharoPackagesCoder forAllPackages
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> methodAdded: aMethodAdded [
	self selectedClass == aMethodAdded methodAdded methodClass ifFalse: [ ^ self ].
	self announcer
		announce: (GtCoderNavigationMethodModification new methodModified: aMethodAdded)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> methodRemoved: aMethodRemoved [
	self selectedClass == aMethodRemoved methodRemoved methodClass ifFalse: [ ^ self ].
	self announcer
		announce: (GtCoderNavigationMethodModification new methodModified: aMethodRemoved)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyClassSelected: aClass package: anRPackage tag: anRPackageTag [
	self
		announce:
			(GtCoderNavigationClassSelected new
				coder: coder;
				package: anRPackage;
				tag: anRPackageTag;
				theClass: aClass)
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> notifyCoderSelected [
	self announce: (GtCoderNavigationPackagesSelected new coder: coder)
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> notifyMethodProtocolSelected: aMethodProtocol source: aSource [
	coder withMethodProtocol: aMethodProtocol source: aSource
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyMethodSelected: aMethod [
	coder withSelectedMethod: aMethod
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyPackageSelected: anRPackage [
	self
		announce:
			(GtCoderNavigationPackageSelected new
				coder: coder;
				package: anRPackage)
]

{ #category : #accessing }
GtCoderNavigationPackagesTagsClassesModel >> notifySlotSelected: aSlot source: aSource [
	coder withSlot: aSlot source: aSource
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyTagSelected: anRPackageTag package: anRPackage [
	self
		announce:
			(GtCoderNavigationPackageTagSelected new
				coder: coder;
				package: anRPackage;
				tag: anRPackageTag)
]

{ #category : #'private - announcement handling' }
GtCoderNavigationPackagesTagsClassesModel >> onCoderAnnouncement: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> packageRegistered: aRPackageRegistered [
	(self packagesToShow includes: aRPackageRegistered package) ifFalse: [ ^ self ].
	self announcer announce: (GtCoderNavigationPackageRegistered new 
		coder: coder;
		package: aRPackageRegistered package)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> packageRenamed: aRPackageRenamed [
	(self packagesToShow includes: aRPackageRenamed package) ifFalse: [ ^ self ].
	self announcer announce: (GtCoderNavigationPackageRenamed new 
		coder: coder;
		package: aRPackageRenamed package;
		oldName: aRPackageRenamed oldName;
		newName: aRPackageRenamed newName)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> packageTagAdded: aClassTagAdded [
	(self packagesToShow includes: aClassTagAdded package) ifFalse: [ ^ self ].
	self announcer announce: (GtCoderNavigationPackageTagAdded new 
		coder: coder;
		package: aClassTagAdded package;
		tag: aClassTagAdded tag)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> packageTagRemoved: aClassTagRemoved [
	(self packagesToShow includes: aClassTagRemoved package) ifFalse: [ ^ self ].
	self announcer announce: (GtCoderNavigationPackageTagRemoved new 
		coder: coder;
		package: aClassTagRemoved package;
		tag: aClassTagRemoved tag)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> packageTagRenamed: aClassTagRenamed [
	(self packagesToShow includes: aClassTagRenamed package) ifFalse: [ ^ self ].
	self announcer
		announce: (GtCoderNavigationPackageTagRenamed new
				coder: coder;
				package: aClassTagRenamed package;
				oldName: aClassTagRenamed tag;
				newName: aClassTagRenamed newName)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> packageUnregistered: aRPackageUnregistered [
	self announcer announce: (GtCoderNavigationPackageUnregistered new 
		coder: coder;
		package: aRPackageUnregistered package)
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> packagesToShow [
	<return: #Collection of: #RPackage>

	^ RPackageOrganizer default gtSortedPackages
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectClass: aClass [
	| aCoder newPackage |
	(coder isForClass and: [ coder theClass = aClass ]) ifTrue: [ ^ self ].
	aCoder := GtPharoBehaviorCoder forClass: aClass.
	self assertCoder: aCoder.
	newPackage := selectedPackage
			ifNil: [ aClass package ]
			ifNotNil: [ :pkg | (pkg extendsClass: aClass) ifTrue: [ pkg ] ifFalse: [ aClass package ] ].
	newPackage = selectedPackage ifFalse: [ selectedPackage := newPackage ].
	selectedTag := selectedPackage classTagForClass: aClass.
	selectedTag := selectedTag
			ifNil: [ (selectedPackage extendsClass: aClass)
					ifTrue: [ GtCoderPackageExtensionTag forPackage: selectedPackage ] ].
	self coder: aCoder.
	self
		notifyClassSelected: aClass
		package: selectedPackage
		tag: ((selectedTag isNil or: [ selectedTag isRoot ])
				ifTrue: [ nil ]
				ifFalse: [ selectedTag ])
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectCoder: aCoder [
	aCoder isForPackage
		ifTrue: [ (coder isForPackage and: [ aCoder package = coder package ])
				ifTrue: [ ^ self ].
			self assertCoder: aCoder.
			selectedPackage := aCoder package.
			selectedTag := nil.
			self coder: aCoder.
			^ self notifyPackageSelected: selectedPackage ].
	aCoder isForPackageTag
		ifTrue:
			[ (coder isForPackageTag and: [ aCoder packageTag = coder packageTag ])
				ifTrue: [ ^ self ].
			self assertCoder: aCoder.
			selectedPackage := aCoder package.
			selectedTag := aCoder packageTag.
			self coder: aCoder.
			^ self notifyTagSelected: selectedTag package: selectedPackage ].
	aCoder isForClass
		ifTrue: [ (coder isForClass and: [ aCoder theClass = coder theClass ])
				ifTrue: [ ^ self ].
			self assertCoder: aCoder.
			self coder: aCoder.
			selectedPackage := selectedPackage ifNil: [coder theClass package].
			selectedTag := selectedTag ifNil: [coder packageTag].
			^ self
				notifyClassSelected: coder theClass
				package: selectedPackage
				tag: selectedTag ].
	self assertCoder: aCoder.
	self coder: aCoder.
	self notifyCoderSelected
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectMethod: aMethod [
	self selectClass: aMethod methodClass instanceSide.
	self notifyMethodSelected: aMethod
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectMethodProtocol: aMethodProtocol source: aSource [
	self notifyMethodProtocolSelected: aMethodProtocol source: aSource
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectPackage: anRPackage [
	| aCoder |
	(self showPackage: anRPackage) ifFalse: [ ^ self ].
	(coder isForPackage and: [ selectedPackage = anRPackage ]) ifTrue: [ ^ self ].
	selectedPackage := anRPackage.
	selectedTag := nil.
	aCoder := coder isForPackageTag
			ifTrue: [ coder packageCoder ]
			ifFalse: [ GtPharoPackageCoder forPackage: anRPackage ].
	self assertCoder: aCoder.
	self coder: aCoder.
	self notifyPackageSelected: anRPackage
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectPackageTag: aRPackageTag [
	| packageCoder aCoder |
	aRPackageTag isNil ifTrue: [ ^ self ].
	(self showPackage: aRPackageTag package) ifFalse: [ ^ self ].
	(coder isForPackageTag
		and: [ selectedPackage = aRPackageTag package and: [ selectedTag = aRPackageTag ] ])
		ifTrue: [ ^ self ].
	selectedTag := aRPackageTag.
	packageCoder := ((coder isForPackage
			and: [ selectedPackage = aRPackageTag package ]) ifTrue: [ coder ])
			ifNil: [ selectedPackage := aRPackageTag package.
				GtPharoPackageCoder forPackage: aRPackageTag package ].
	aCoder := packageCoder packageTagCoderFor: aRPackageTag.
	self assertCoder: aCoder.
	self coder: aCoder.
	self notifyTagSelected: aRPackageTag package: aRPackageTag package
]

{ #category : #accessing }
GtCoderNavigationPackagesTagsClassesModel >> selectSlot: aSlot source: aSource [
	self notifySlotSelected: aSlot source: aSource
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedClass [
	<return: #Class>
	^ coder theClass
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedClassDo: aBlock [
	self selectedClass ifNotNil: aBlock
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectedPackage [
	<return: #RPackage>
	^ selectedPackage
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedPackageDo: aBlock [
	self selectedPackage ifNotNil: aBlock
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedTag [
	<return: #RPackageTag>
	^ selectedTag
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedTagDo: aBlock [
	self selectedTag ifNotNil: aBlock
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> showPackage: anRPackage [
	^ true
]

{ #category : #'api - subscriptions' }
GtCoderNavigationPackagesTagsClassesModel >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: RPackageRegistered send: #packageRegistered: to: self;
		when: RPackageUnregistered send: #packageUnregistered: to: self;
		when: RPackageRenamed send: #packageRenamed: to: self;
		when: ClassTagAnnouncement send: #packageTagRenamed: to: self;
		when: ClassTagAdded send: #packageTagAdded: to: self;
		when: ClassTagRemoved send: #packageTagRemoved: to: self;
		when: ClassAdded send: #classAdded: to: self;
		when: ClassRenamed send: #classRenamed: to: self;
		when: ClassRemoved send: #classRemoved: to: self;
		when: ClassModificationApplied send: #classModificationApplied: to: self;
		when: MethodAdded send: #methodAdded: to: self;
		when: MethodRemoved send: #methodRemoved: to: self
]

{ #category : #'api - subscriptions' }
GtCoderNavigationPackagesTagsClassesModel >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
