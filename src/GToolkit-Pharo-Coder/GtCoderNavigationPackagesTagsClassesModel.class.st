Class {
	#name : #GtCoderNavigationPackagesTagsClassesModel,
	#superclass : #GtCoderNavigationModel,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'coder',
		'selectedPackage',
		'selectedTag',
		'selectedProtocol',
		'selectedMethod',
		'selectedSlot',
		'selectedClass'
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
	self selectedPackage
		ifNil: [ ^ self ]
		ifNotNil: [ :aPackage |
			(aPackage includesClassesAffectedBy: aClassAdded)
				ifFalse: [ ^ self ] ].

	self notifyClassesToShowChanged
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> classModificationApplied: aClassModificationApplied [
	self selectedPackage
		ifNil: [ ^ self ]
		ifNotNil: [ :aPackage |
			(aPackage includesClassesAffectedBy: aClassModificationApplied)
				ifFalse: [ ^ self ] ].

	self notifyClassesToShowChanged.

	self announcer announce: (GtCoderNavigationClassModified new 
		coder: coder;
		package: aClassModificationApplied packageAffected;
		tag: aClassModificationApplied classTagAffected;
		theClass: aClassModificationApplied classAffected)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> classRemoved: aClassRemoved [	
	self selectedPackage
		ifNil: [ ^ self ]
		ifNotNil: [ :aPackage |
			(aPackage includesClassesAffectedBy: aClassRemoved)
				ifFalse: [ ^ self ] ].

	aClassRemoved classRemoved = self selectedClass
		ifTrue: [ self deselectClass ].

	self notifyClassesToShowChanged
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> classRenamed: aClassRenamed [
	self selectedPackage
		ifNil: [ ^ self ]
		ifNotNil: [ :aPackage |
			(aPackage includesClassesAffectedBy: aClassRenamed)
				ifFalse: [ ^ self ] ].

	self notifyClassesToShowChanged.
	
	"we should still emit it, because GtCoderElement listens to it to update the label"
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
		to: self.
		
	self announce: (GtCoderNavigationCoderChanged new coder: aCoder)
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> coderDo: aBlock [
	coder ifNotNil: aBlock
]

{ #category : #initialization }
GtCoderNavigationPackagesTagsClassesModel >> createAllProtocol: aClass [
	^ GtPharoProtocol
		protocol: (AllProtocol protocolOrganizer: aClass organization protocolOrganizer)
		class: aClass
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> deselectClass [
	"Deselect any currently selected class and other entities such as protocols, slots and methods. Deselecting a class means that the model no longer shows any methods, slots or protocols but still continues to display classes".

	(self privateJustDeselectClass)
		ifFalse: [ ^ self ].
	
	self deselectProtocol.
	self notifyProtocolsToShowChanged.
	self deselectSlot.
	self notifySlotsToShowChanged
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> deselectMethod [
	"Deselect any currently selected method and notify about the changes.
	Deselecting a method has no influence on the currently selected protocol, slot or package."

	self privateJustDeselectMethod
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> deselectProtocol [
	"Deselect a currently selected protocol and no longer display methods"
	
	(self privateJustDeselectProtocol)
		ifFalse: [ ^ self ].
	
	self deselectMethod.
	self notifyMethodsToShowChanged
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> deselectSlot [
	"Deselect a currently selected slot and no longer display methods"
	
	(self privateJustDeselectSlot)
		ifFalse: [ ^ self ].
	
	self deselectMethod.
	self notifyMethodsToShowChanged
]

{ #category : #'api - testing' }
GtCoderNavigationPackagesTagsClassesModel >> hasPackageTagsIn: aRPackage [
	<return: #Boolean>
	| hasTags hasExtensions |
	hasTags := (aRPackage classTags size = 1
			and: [ aRPackage classTags anyOne name = aRPackage name ]) not.
	hasExtensions := aRPackage gtDoesExtendClasses.
	^ hasTags or: [ hasExtensions ]
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
	self selectedClass
		ifNil: [ ^ self ]
		ifNotNil: [ :aClass |
			(aClass includesMethodsAffectedBy: aMethodAdded)
				ifFalse: [ ^ self ] ].
	
	self notifyProtocolsToShowChanged.
	self notifySlotsToShowChanged.
	self notifyMethodsToShowChanged
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> methodRecategorized: aMethodRecategorized [
	| theClass aPackage aTag |
	
	self selectedClass
		ifNil: [ ^ self ]
		ifNotNil: [ :aClass |
			(aClass includesMethodsAffectedBy: aMethodRecategorized)
				ifFalse: [ ^ self ] ].
				
	self selectedMethod = aMethodRecategorized methodRecategorized
		ifTrue: [ self deselectMethod ].

	self selectedProtocol ifNotNil: [ :aProtocol |
		(aProtocol name = aMethodRecategorized oldProtocol
			and: [ aProtocol methodSelectors isEmpty ])
				ifTrue: [
					| aNewProtocol |
					
					aNewProtocol := self privateProtocolOfMethod: aMethodRecategorized methodRecategorized.

					self selectProtocol: aNewProtocol ] ].

	self notifyProtocolsToShowChanged.
	self notifyMethodsToShowChanged.

	theClass := aMethodRecategorized methodRecategorized methodClass.
	aPackage := theClass package.
	aTag := (GtTagDefinition fromBehavior: theClass) name.
	
	self announcer announce: (GtCoderNavigationClassModified new 
		coder: coder;
		package: aPackage;
		tag: aTag;
		theClass: theClass)
]

{ #category : #'event handling' }
GtCoderNavigationPackagesTagsClassesModel >> methodRemoved: aMethodRemoved [
	self selectedClass
		ifNil: [ ^ self ]
		ifNotNil: [ :aClass |
			(aClass includesMethodsAffectedBy: aMethodRemoved)
				ifFalse: [ ^ self ] ].

	self selectedMethod = aMethodRemoved
		ifTrue: [ self deselectMethod ].
	
	self notifyProtocolsToShowChanged.
	self notifySlotsToShowChanged.
	self notifyMethodsToShowChanged
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> methodsToShow [
	| anInstanceSideClass aClassSideClass |
	anInstanceSideClass := (self selectedClass ifNil: [ ^ #() ]) instanceSide.
	aClassSideClass := anInstanceSideClass classSide.

	self selectedSlot
		ifNotNil: [ :aSlot | 
			^ Array
				streamContents: [ :aStream | 
					aStream nextPutAll: (anInstanceSideClass methodsAccessingSlot: aSlot).
					aStream nextPutAll: (aClassSideClass methodsAccessingSlot: aSlot) ] ].

	^ Array
		streamContents: [ :aStream | 
			| aProtocol |
			aProtocol := self selectedProtocol
					ifNil: [ GtPharoProtocol
							protocol: (AllProtocol
									protocolOrganizer: anInstanceSideClass organization protocolOrganizer)
							class: anInstanceSideClass ].
			aProtocol methodSelectors
				do: [ :eachSelector | 
					| eachMethod |
					eachMethod := aProtocol protocolClass >> eachSelector.
					(eachMethod methodClass isClassSide and: [ eachMethod isFromTrait ])
						ifFalse: [ aStream nextPut: eachMethod ] ] ]
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyClassDeselected: aPreviouslySelectedClass [
	self announce: (GtCoderNavigationClassDeselected new
		theClass: aPreviouslySelectedClass;
		coder: coder)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyClassSelected: aClass [
	self
		announce:
			(GtCoderNavigationClassSelected new
				coder: coder;
				package: selectedPackage;
				tag: selectedTag;
				theClass: aClass)
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

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyClassesToShowChanged [
	self announce: (GtCoderNavigationClassesToShowChanged new coder: coder)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyCoderSelected [
	self announce: (GtCoderNavigationPackagesSelected new coder: coder)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyMethodDeselected: aPreviouslySelectedMethod [ 
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyMethodSelected: aMethod [
	coder withSelectedMethod: aMethod.
	self
		announce:
			(GtCoderNavigationMethodSelected new
				coder: coder;
				method: aMethod)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyMethodsToShowChanged [
	self announce: (GtCoderNavigationMethodsToShowChanged new coder: coder)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyPackageSelected: anRPackage [
	self
		announce:
			(GtCoderNavigationPackageSelected new
				coder: coder;
				package: anRPackage)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyPackageSelected: anRPackage tag: anRPackageTag [
	self
		announce:
			(GtCoderNavigationPackageTagSelected new
				coder: coder;
				package: anRPackage;
				tag: anRPackageTag)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyProtocolDeselected: aGtPharoProtocol [
	self
		announce:
			(GtCoderNavigationProtocolDeselected new
				coder: coder;
				protocol: aGtPharoProtocol)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyProtocolSelected: aGtPharoProtocol source: aSource [
	self
		announce:
			(GtCoderNavigationProtocolSelected new
				coder: coder;
				protocol: aGtPharoProtocol).
	
	coder withMethodProtocol: aGtPharoProtocol source: aSource
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifyProtocolsToShowChanged [
	self announce: (GtCoderNavigationProtocolsToShowChanged new coder: coder)
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifySlotDeselected: aPreviouslySelectedProtocol [ 
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifySlotSelected: aSlot source: aSource [
	coder withSlot: aSlot source: aSource
]

{ #category : #'private - notifying' }
GtCoderNavigationPackagesTagsClassesModel >> notifySlotsToShowChanged [
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

{ #category : #'private - selection' }
GtCoderNavigationPackagesTagsClassesModel >> privateJustDeselectClass [
	"Just deselect any currently selected class and notify about the changes/
	Return true if there was a class to deselect"
	<return: #Boolean>
	| aPreviouslySelectedClass |

	selectedClass ifNil: [ ^ false ].
	aPreviouslySelectedClass := selectedClass.
	selectedClass := nil.
	self notifyClassDeselected: aPreviouslySelectedClass.
	^ true
]

{ #category : #'private - selection' }
GtCoderNavigationPackagesTagsClassesModel >> privateJustDeselectMethod [
	"Just deselect any currently selected method and notify about the changes.
	Return true if there was a method to deselect"
	<return: #Boolean>
	| aPreviouslySelectedMethod |

	selectedMethod ifNil: [ ^ false ].
	aPreviouslySelectedMethod := selectedMethod.
	selectedMethod := nil.
	self notifyMethodDeselected: aPreviouslySelectedMethod.
	^ true
]

{ #category : #'private - selection' }
GtCoderNavigationPackagesTagsClassesModel >> privateJustDeselectProtocol [
	"Just deselect any currently selected protocol and notify about the changes.
	Return true if there was a protocol to deselect"
	<return: #Boolean>
	| aPreviouslySelectedProtocol |

	selectedProtocol ifNil: [ ^ false ].
	aPreviouslySelectedProtocol := selectedProtocol.
	selectedProtocol := nil.
	self notifyProtocolDeselected: aPreviouslySelectedProtocol.
	^ true
]

{ #category : #'private - selection' }
GtCoderNavigationPackagesTagsClassesModel >> privateJustDeselectSlot [
	"Just deselect any currently selected slot and notify about the changes.
	Return true if there was a slot to deselect"
	<return: #Boolean>
	| aPreviouslySelectedSlot |

	selectedSlot ifNil: [ ^ false ].
	aPreviouslySelectedSlot := selectedSlot.
	selectedSlot := nil.
	self notifySlotDeselected: aPreviouslySelectedSlot.
	^ true
]

{ #category : #'private - selection' }
GtCoderNavigationPackagesTagsClassesModel >> privateJustSelectClass: aClass [
	"Just select a class and its corresponding package or tag and notify about the changes"
	| aPackageToSelect aTagToSelect shouldSelectTag |
	<return: #Boolean>
	
	aPackageToSelect := selectedPackage
		ifNil: [ aClass package ]
		ifNotNil: [ :pkg |
			(pkg extendsClass: aClass)
				ifTrue: [ pkg ]
				ifFalse: [ aClass package ] ].

	"Pre-select a tag under the following conditions:
	 - class comes from a different package than the selected one
	 - there is a selected tag from the same package as a class"
	shouldSelectTag := aPackageToSelect ~= self selectedPackage.
	shouldSelectTag ifFalse: [
			shouldSelectTag := aPackageToSelect = self selectedPackage
				and: [ self hasSelectedTag ] ].
	shouldSelectTag := shouldSelectTag and: [ self hasPackageTagsIn: aPackageToSelect ].


	shouldSelectTag
		ifTrue: [
			aTagToSelect := aPackageToSelect classTagForClass: aClass.
			"pharo issue: tag of an uncategorized classe is the same as a package.
			we have to compare names to make sure we don't select a tag that doesn't exist"
			(aTagToSelect isNotNil and: [ aTagToSelect name = aPackageToSelect name ])
				ifTrue: [ aTagToSelect := nil ].
			aTagToSelect := aTagToSelect
				ifNil: [
					(aPackageToSelect extendsClass: aClass)
						ifTrue: [ GtCoderPackageExtensionTag forPackage: aPackageToSelect ] ].
		].
	
	aTagToSelect
		ifNil:  [ self privateJustSelectPackage: aPackageToSelect ]
		ifNotNil: [ self privateJustSelectPackage: aPackageToSelect tag: aTagToSelect ].
	
	selectedClass = aClass
		ifTrue: [ ^ false ].

	selectedClass := aClass.
	self notifyClassSelected: aClass.
	^ true
]

{ #category : #'private - selection' }
GtCoderNavigationPackagesTagsClassesModel >> privateJustSelectPackage: aPackage [
	"Just select a class a notify about the changes"

	selectedPackage = aPackage
		ifTrue: [ ^ self ].

	selectedPackage := aPackage.
	selectedTag := nil.
	self notifyPackageSelected: aPackage.
	self notifyClassesToShowChanged
]

{ #category : #'private - selection' }
GtCoderNavigationPackagesTagsClassesModel >> privateJustSelectPackage: aPackage tag: aTag [
	"Just select a package and a tag a notify about the changes"

	(selectedPackage = aPackage and: [ selectedTag = aTag ])
		ifTrue: [ ^ self ].

	selectedPackage := aPackage.
	selectedTag := aTag.
	self notifyPackageSelected: aPackage tag: aTag.
	self notifyClassesToShowChanged
]

{ #category : #'private - selection' }
GtCoderNavigationPackagesTagsClassesModel >> privateJustSelectProtocol: aGtPharoProtocol source: aSourceObject [
	"Just select a protocol a notify about the changes"

	selectedProtocol = aGtPharoProtocol
		ifTrue: [ ^ false ].

	selectedProtocol := aGtPharoProtocol.
	self notifyProtocolSelected: aGtPharoProtocol source: aSourceObject.
	^ true
]

{ #category : #'private - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> privateProtocolOfMethod: aCompiledMethod [
	| aProtocol |
	aProtocol := aCompiledMethod methodClass organization
			protocolNamed: aCompiledMethod protocol.

	^ aProtocol
		ifNotNil: [ GtPharoProtocol protocol: aProtocol class: aCompiledMethod methodClass ]
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> protocolsToShow [
	<return: #Collection of: #GtPharoProtocol>
	| currentClass classProtocols methodProtocols extension allProtocol |

	self hasSelectedClass
		ifFalse: [ ^ #() ].

	currentClass := self selectedClass.

	classProtocols := currentClass class organization protocols
			reject: [ :prot | 
				(self selectedClass class methods
					select: [ :meth | (prot includesSelector: meth selector) and: [ meth isFromTrait not ] ])
					isEmpty ].
	methodProtocols := currentClass organization protocols.
	extension := false.
	self
		selectedPackageDo: [ :pkg | 
			pkg ~= currentClass package
				ifTrue: [ | protocolName |
					extension := true.
					protocolName := '*' , pkg name.
					methodProtocols := methodProtocols
							select: [ :each | each name beginsWith: protocolName ].
					classProtocols := classProtocols
							select: [ :each | each name beginsWith: protocolName ] ] ].

	methodProtocols := methodProtocols collect: [ :eachProtocol |
		GtPharoProtocol
			protocol: eachProtocol
			class: currentClass instanceSide ].

	classProtocols := classProtocols collect: [ :eachProtocol |
		GtPharoProtocol
			protocol: eachProtocol
			class: currentClass classSide ].
	
	allProtocol := self createAllProtocol: currentClass.

	^ {allProtocol}, methodProtocols, classProtocols
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectClass: aClass [
	self
		selectClass: aClass
		withCoder: [ GtPharoBehaviorCoder forClass: aClass ]
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectClass: aClass withCoder: aBlockThatCreatesCoder [
	"Do nothing if a class is already selected"
	(selectedClass = aClass
		and: [ coder isForClass
			and: [ coder theClass = aClass ] ])
		ifTrue: [ ^ self ].

	self coder: (aBlockThatCreatesCoder cull: aClass).
	
	(self privateJustSelectClass: aClass)
		ifFalse: [ ^ self ].

	self deselectSlot.
	self notifySlotsToShowChanged.
	self notifyProtocolsToShowChanged.

	selectedProtocol
		ifNil: [ self selectProtocol: (self createAllProtocol: aClass) ]
		ifNotNil: [ :aCurrentlySelectedProtocol | 
			self protocolsToShow
				detect: [ :eachProtocol | eachProtocol name = aCurrentlySelectedProtocol name ]
				ifFound: [ :aSimilarProtocol | self selectProtocol: aSimilarProtocol ]
				ifNone: [ self selectProtocol: (self createAllProtocol: aClass) ] ]
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
			^ self notifyPackageSelected: selectedPackage tag: selectedTag ].

	aCoder isForClass
		ifTrue: [
			^ self
				selectClass: aCoder theClass
				withCoder: [ aCoder ] ].

	self assertCoder: aCoder.
	self coder: aCoder.
	self notifyCoderSelected
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectMethod: aMethod [
	self selectClass: aMethod methodClass instanceSide.

	selectedMethod := aMethod.
	self notifyMethodSelected: aMethod
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectPackage: anRPackage [
	| aCoder |

	(self showPackage: anRPackage)
		ifFalse: [ ^ self ].

	(coder isForPackage and: [ selectedPackage = anRPackage ])
		ifTrue: [ ^ self ].

	selectedPackage := anRPackage.
	selectedTag := nil.
	aCoder := coder isForPackageTag
			ifTrue: [ coder packageCoder ]
			ifFalse: [ GtPharoPackageCoder forPackage: anRPackage ].
	self coder: aCoder.

	self deselectClass.
	self notifyClassesToShowChanged.

	self notifyPackageSelected: anRPackage
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectPackageTag: aRPackageTag [
	| packageCoder aCoder |

	aRPackageTag
		ifNil: [ ^ self ].

	(self showPackage: aRPackageTag package)
		ifFalse: [ ^ self ].

	(coder isForPackageTag
		and: [ selectedPackage = aRPackageTag package and: [ selectedTag = aRPackageTag ] ])
		ifTrue: [ ^ self ].

	packageCoder := ((coder isForPackage
			and: [ selectedPackage = aRPackageTag package ]) ifTrue: [ coder ])
			ifNil: [ selectedPackage := aRPackageTag package.
				GtPharoPackageCoder forPackage: aRPackageTag package ].
	aCoder := packageCoder packageTagCoderFor: aRPackageTag.
	self coder: aCoder.
	
	selectedPackage := aRPackageTag package.
	selectedTag := aRPackageTag.
	
	self deselectClass.
	self notifyClassesToShowChanged.

	self
		notifyPackageSelected: aRPackageTag package
		tag: aRPackageTag
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectProtocol: aPharoProtocol [
	self selectProtocol: aPharoProtocol source: nil
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectProtocol: aPharoProtocol source: aSource [
	self privateJustSelectClass: aPharoProtocol protocolClass instanceSide.
	
	(self privateJustSelectProtocol: aPharoProtocol source: aSource)
		ifFalse: [ ^ self ].
		
	self privateJustDeselectSlot.
	self notifyMethodsToShowChanged
]

{ #category : #'api - selection' }
GtCoderNavigationPackagesTagsClassesModel >> selectSlot: aSlot source: aSource [
	selectedSlot := aSlot.
	selectedProtocol := nil.
	self notifySlotSelected: aSlot source: aSource
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedClass [
	<return: #Class>
	^ selectedClass
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedClassDo: aBlock [
	self selectedClass ifNotNil: aBlock
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedMethod [
	<return: #CompiledMethod>

	^ selectedMethod
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedPackage [
	<return: #RPackage>
	^ selectedPackage
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedPackageDo: aBlock [
	self selectedPackage ifNotNil: aBlock
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedProtocol [
	<return: #GtPharoProtocol>

	^ selectedProtocol
]

{ #category : #'api - accessing' }
GtCoderNavigationPackagesTagsClassesModel >> selectedSlot [
	^ selectedSlot
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
		when: ClassTagRenamed send: #packageTagRenamed: to: self;
		when: ClassTagAdded send: #packageTagAdded: to: self;
		when: ClassTagRemoved send: #packageTagRemoved: to: self;
		when: ClassAdded send: #classAdded: to: self;
		when: ClassRenamed send: #classRenamed: to: self;
		when: ClassRemoved send: #classRemoved: to: self;
		when: ClassModificationApplied send: #classModificationApplied: to: self;
		when: MethodAdded send: #methodAdded: to: self;
		when: MethodRemoved send: #methodRemoved: to: self;
		when: MethodRecategorized send: #methodRecategorized: to: self
]

{ #category : #'api - subscriptions' }
GtCoderNavigationPackagesTagsClassesModel >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
