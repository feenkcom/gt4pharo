Class {
	#name : #GtCoderNavigationPackagesTagsClassesModelExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #'examples - protocols' }
GtCoderNavigationPackagesTagsClassesModelExamples >> addNewClassSideProtocol [
	"Tests what happens when we add a new empty class side protocol"
	<gtExample>
	| aModel protocolsToShow newProtocolName announcements |
	
	aModel := self navigateToClass_03_selectClass.
	
	protocolsToShow := aModel protocolsToShow collect: [ :each | each name ].
	
	newProtocolName := 'new class side protocol'.
	
	self assert: (protocolsToShow includes: newProtocolName) not.
	
	[
		announcements := self recordAnnouncementsOf: aModel during: [
			(RBAddProtocolChange
				addProtocolNamed: newProtocolName
				in: self dummySuperclass classSide) execute ].

		protocolsToShow := aModel protocolsToShow collect: [ :each | each name ].
		self assert: (protocolsToShow includes: newProtocolName).
		
		self assert: announcements size equals: 1.
		self assert: (announcements first isKindOf: GtCoderNavigationProtocolsToShowChanged).

	] ensure: [
		(RBRemoveProtocolChange
			removeProtocolNamed: newProtocolName
			in: self dummySuperclass classSide) execute ].

	^ aModel
]

{ #category : #'examples - protocols' }
GtCoderNavigationPackagesTagsClassesModelExamples >> addNewInstanceSideProtocol [
	"Tests what happens when we add a new empty instance side protocol"
	<gtExample>
	| aModel protocolsToShow newProtocolName announcements |
	
	aModel := self navigateToClass_03_selectClass.
	
	protocolsToShow := aModel protocolsToShow collect: [ :each | each name ].
	
	newProtocolName := 'new instance side protocol'.
	
	self assert: (protocolsToShow includes: newProtocolName) not.
	
	[	
		announcements := self recordAnnouncementsOf: aModel during: [
			(RBAddProtocolChange
				addProtocolNamed: newProtocolName
				in: self dummySuperclass instanceSide) execute ].

		protocolsToShow := aModel protocolsToShow collect: [ :each | each name ].
		self assert: (protocolsToShow includes: newProtocolName).
		
		self assert: announcements size equals: 1.
		self assert: (announcements first isKindOf: GtCoderNavigationProtocolsToShowChanged).

	] ensure: [
		(RBRemoveProtocolChange
			removeProtocolNamed: newProtocolName
			in: self dummySuperclass instanceSide) execute ].

	^ aModel
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> assertNoMethods: aNavigationModel [
	self assert: aNavigationModel hasSelectedProtocol not.
	self assert: aNavigationModel hasSelectedSlot not.
	self assert: aNavigationModel hasSelectedMethod not.
	self assert: aNavigationModel protocolsToShow equals: #().
	self assert: aNavigationModel methodsToShow equals: #().
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> assertNoProtocolsNoSlotsNoMethods: aNavigationModel [
	self assert: aNavigationModel hasSelectedClass not.
	self assert: aNavigationModel hasSelectedProtocol not.
	self assert: aNavigationModel hasSelectedSlot not.
	self assert: aNavigationModel hasSelectedMethod not.
	self assert: aNavigationModel protocolsToShow equals: #().
	self assert: aNavigationModel methodsToShow equals: #().
]

{ #category : #'examples - navigate to class' }
GtCoderNavigationPackagesTagsClassesModelExamples >> assertSelectedPackageTagClass: aModel ofClass: aClassToSelect [
	| aTag |
	self assert: aModel hasSelectedPackage.
	self assert: aModel selectedPackage equals: aClassToSelect package.

	aTag := aClassToSelect package tagOf: aClassToSelect.
	self assert: aModel hasSelectedTag.
	self assert: aModel selectedTag equals: aTag.

	self assert: aModel hasSelectedClass.
	self assert: aModel selectedClass equals: aClassToSelect
]

{ #category : #examples }
GtCoderNavigationPackagesTagsClassesModelExamples >> defaultModel [
	<gtExample>
	| aModel packagesToShow |
	
	aModel := GtCoderNavigationPackagesTagsClassesModel new.
	self assert: aModel hasSelectedPackage not.
	self assert: aModel selectedPackage isNil.
	
	packagesToShow := aModel packagesToShow.
	self assert: (packagesToShow includes: 'GT-PackageWithSuperclasses' asPackage).
	self assert: (packagesToShow includes: 'GT-PackageWithSubclasses' asPackage).
	self assert: (packagesToShow includes: 'GT-PackageWithExtensions' asPackage).
	
	^ aModel
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> dummySubclass [
	^ GtCoderDummySubclass
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> dummySuperclass [
	^ GtCoderDummySuperclass
]

{ #category : #'examples - navigate to class' }
GtCoderNavigationPackagesTagsClassesModelExamples >> navigateToClass_01_selectPackage [
	<gtExample>
	| aModel classesToShow |

	aModel := self defaultModel.
	aModel selectPackage: self packageWithSuperclasses.

	self assert: aModel hasSelectedPackage.
	self assert: aModel selectedPackage equals: self packageWithSuperclasses.

	self assert: aModel hasSelectedTag not.
	self assert: aModel hasSelectedClass not.
	
	classesToShow := aModel classesToShow.
	self assert: (classesToShow includes: self dummySuperclass).
	
	self assertNoProtocolsNoSlotsNoMethods: aModel.

	^ aModel
]

{ #category : #'examples - navigate to class' }
GtCoderNavigationPackagesTagsClassesModelExamples >> navigateToClass_02_selectTag [
	<gtExample>
	| aModel aTag classesToShow |
	
	aTag := self packageWithSuperclasses tagNamed: 'Classes'.

	aModel := self navigateToClass_01_selectPackage.
	aModel selectPackageTag: aTag.

	self assert: aModel hasSelectedPackage.
	self assert: aModel selectedPackage equals: self packageWithSuperclasses.

	self assert: aModel hasSelectedTag.
	self assert: aModel selectedTag equals: aTag.
	
	self assert: aModel hasSelectedClass not.
	
	classesToShow := aModel classesToShow.
	self assert: (classesToShow includes: self dummySuperclass).
	
	self assertNoProtocolsNoSlotsNoMethods: aModel.

	^ aModel
]

{ #category : #'examples - navigate to class' }
GtCoderNavigationPackagesTagsClassesModelExamples >> navigateToClass_03_selectClass [
	<gtExample>
	| aModel classesToShow protocolsToShow aClassToSelect methodsToShow slotsToShow |

	aClassToSelect := self dummySuperclass.
	
	aModel := self navigateToClass_02_selectTag.
	aModel selectClass: aClassToSelect.

	self assertSelectedPackageTagClass: aModel ofClass: aClassToSelect.

	classesToShow := aModel classesToShow.
	self assert: (classesToShow includes: aClassToSelect).

	protocolsToShow := aModel protocolsToShow collect: [ :each | each name ].

	self assert: (protocolsToShow includes: 'All').
	self assert: (protocolsToShow includes: 'api').
	self assert: (protocolsToShow includes: 'as yet unclassified').
	self assert: (protocolsToShow includes: 'instance creation').
	
	self assert: aModel hasSelectedProtocol.
	self assert: aModel selectedProtocol name equals: 'All'.
	
	self assert: aModel hasSelectedSlot not.
	
	methodsToShow := aModel methodsToShow.
	
	self assert: (methodsToShow includes: aClassToSelect >> #unclassifiedMethod).
	self assert: (methodsToShow includes: aClassToSelect >> #methodInApiProtocol).
	self assert: (methodsToShow includes: aClassToSelect class >> #instanceCreationMethod).
	
	slotsToShow := aModel slotsToShow.
	self assert: (slotsToShow detect: [ :each| each name = #slotA ]) isNotNil.
	self assert: (slotsToShow detect: [ :each| each name = #classSlotA ]) isNotNil.
	self assert: (slotsToShow detect: [ :each| each name = #classVarA ]) isNotNil.

	^ aModel
]

{ #category : #'examples - navigate to class' }
GtCoderNavigationPackagesTagsClassesModelExamples >> navigateToClass_04_selectSlot [
	<gtExample>
	| aModel aSlotToSelect |

	aModel := self navigateToClass_03_selectClass.
	
	aSlotToSelect := aModel slotsToShow detect: [ :each | each name = #slotA ].
	aModel selectSlot: aSlotToSelect.
	
	self assert: aModel hasSelectedProtocol not.
	self assert: aModel hasSelectedMethod not.
	
	self assert: aModel selectedSlot equals: aSlotToSelect.

	^ aModel
]

{ #category : #'examples - navigate to extensions' }
GtCoderNavigationPackagesTagsClassesModelExamples >> navigateToPackageWithExtensions_01_selectPackage [
	<gtExample>
	| aModel classesToShow |

	aModel := self defaultModel.
	aModel selectPackage: self packageWithExtensions.

	self assert: aModel hasSelectedPackage.
	self assert: aModel selectedPackage equals: self packageWithExtensions.

	self assert: aModel hasSelectedTag not.
	self assert: aModel hasSelectedClass not.

	classesToShow := aModel classesToShow.
	self assert: (classesToShow includes: self dummySuperclass).
	self assert: (classesToShow includes: self dummySuperclass class) not.

	self assertNoProtocolsNoSlotsNoMethods: aModel.

	^ aModel
]

{ #category : #'examples - navigate to extensions' }
GtCoderNavigationPackagesTagsClassesModelExamples >> navigateToPackageWithExtensions_02_selectTag [
	<gtExample>
	| aModel aTag classesToShow |

	aModel := self navigateToPackageWithExtensions_01_selectPackage.
	
	aTag := GtCoderPackageExtensionTag forPackage: self packageWithExtensions.
	
	aModel selectPackageTag: aTag.

	self assert: aModel hasSelectedPackage.
	self assert: aModel selectedPackage equals: self packageWithExtensions.
	self assert: aModel hasSelectedTag.
	self assert: aModel selectedTag equals: aTag.
	
	self assert: aModel hasSelectedClass not.

	classesToShow := aModel classesToShow.
	self assert: (classesToShow includes: self dummySuperclass).
	self assert: (classesToShow includes: self dummySuperclass class) not.

	self assertNoProtocolsNoSlotsNoMethods: aModel.

	^ aModel
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> packageNameWithExtensions [
	^ 'GT-PackageWithExtensions'
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> packageNameWithSuperclasses [
	^ 'GT-PackageWithSuperclasses'
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> packageWithExtensions [
	^ self packageNameWithExtensions asPackage
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> packageWithSuperclasses [
	^ self packageNameWithSuperclasses asPackage
]

{ #category : #utilities }
GtCoderNavigationPackagesTagsClassesModelExamples >> recordAnnouncementsOf: aModel during: aBlock [
	| announcements |
	
	announcements := OrderedCollection new.
	
	aModel announcer when: Announcement send: #add: to: announcements.
	aModel subscribeToSystem.
	
	aBlock ensure: [
		aModel unsubscribeFromSystem.
		aModel announcer unsubscribe: announcements ].
	
	^ announcements
]

{ #category : #'examples - slots' }
GtCoderNavigationPackagesTagsClassesModelExamples >> slotsToShowShouldIncludeSuperclasses [
	<gtExample>
	| aModel slotsToShow |

	aModel := self defaultModel.
	aModel selectClass: self dummySubclass.
	
	slotsToShow := aModel slotsToShow.
	"from selected class"
	self assert: (slotsToShow detect: [ :each| each name = #slotB ]) isNotNil.
	self assert: (slotsToShow detect: [ :each| each name = #classSlotB ]) isNotNil.
	self assert: (slotsToShow detect: [ :each| each name = #classVarB ]) isNotNil.
	"from superclass"
	self assert: (slotsToShow detect: [ :each| each name = #slotA ]) isNotNil.
	self assert: (slotsToShow detect: [ :each| each name = #classSlotA ]) isNotNil.
	self assert: (slotsToShow detect: [ :each| each name = #classVarA ]) isNotNil.
	
	^ aModel
]
