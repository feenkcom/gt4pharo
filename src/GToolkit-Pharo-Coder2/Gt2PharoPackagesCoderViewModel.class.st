Class {
	#name : #Gt2PharoPackagesCoderViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithPharoPackagesCoder',
	#classTraits : 'TGt2WithPharoPackagesCoder classTrait',
	#instVars : [
		'pharoPackageCoderViewModels',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - View Models'
}

{ #category : #'api - adding' }
Gt2PharoPackagesCoderViewModel >> addPharoPackageCoder: aPharoPackage [
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition to the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addDelegateTemplate'>
	self pharoPackagesCoder addPharoPackageCoder: aPharoPackage
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoderViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoPackagesCoderViewModel >> createPharoPackageCoderViewModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #Gt2PharoPackageCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self pharoPackagesCoder pharoPackageCoders collect: [ :eachModel |
		self createPharoPackageCoderViewModelsFor: eachModel ] as: OrderedCollection
]

{ #category : #'private - instance creation' }
Gt2PharoPackagesCoderViewModel >> createPharoPackageCoderViewModelsFor: aChildModel [
	<return: #Gt2PharoPackageCoderViewModel>
	<childObjectCreator: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := Gt2PharoPackageCoderViewModel new.
	aNewChild parentPharoPackagesCoderViewModel: self.
	aNewChild pharoPackageCoder: aChildModel.
	^ aNewChild
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoderViewModel >> findPharoPackageCoderViewModels: aPackage [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #Gt2PharoPackageCoderViewModel or: nil>
	<childObjectDetector: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findPharoPackageCoderViewModels: aPackage
		ifFound: [ :aPharoPackageCoderViewModels | aPharoPackageCoderViewModels ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoderViewModel >> findPharoPackageCoderViewModels: aPackage ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self pharoPackageCoderViewModels
		detect: [ :eachPharoPackageCoderViewModels |
			eachPharoPackageCoderViewModels pharoPackageCoder = aPackage ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-extentions' }
Gt2PharoPackagesCoderViewModel >> gtPackageListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Package';
		items: [ self pharoPackageCoderViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoderViewModel >> includesPharoPackageCoderViewModels: aPharoPackageCoderViewModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self pharoPackageCoderViewModels anySatisfy: [ :eachPharoPackageCoderViewModels |
		eachPharoPackageCoderViewModels == aPharoPackageCoderViewModels ]
]

{ #category : #'private - notifying' }
Gt2PharoPackagesCoderViewModel >> notifyPharoPackageCoderViewModelAdded: aPharoPackageCoderViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoPackageCoderViewModelAddedAnnouncement new
		pharoPackageCoderViewModel: aPharoPackageCoderViewModel) 
]

{ #category : #'private - notifying' }
Gt2PharoPackagesCoderViewModel >> notifyPharoPackageCoderViewModelRemoved: aPharoPackageCoderViewModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoPackageCoderViewModelRemovedAnnouncement new
		pharoPackageCoderViewModel: aPharoPackageCoderViewModel) 
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoderViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #packages
]

{ #category : #'private - event handling' }
Gt2PharoPackagesCoderViewModel >> onPharoPackageAdded: aGt2PharoPackageCoderAddedAnnouncement [
	"Is sent when a new Package is added to the model of the receiver due to
	the handled ${class:Gt2PharoPackageCoderAddedAnnouncement}$ announcement."
	<modelEventHandler: #package event: #Gt2PharoPackageCoderAddedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#onAddedEventHanderTemplate'>
	| aNewChildObject |

	aNewChildObject := self createPharoPackageCoderViewModelsFor: aGt2PharoPackageCoderAddedAnnouncement pharoPackageCoder.
	self pharoPackageCoderViewModels add: aNewChildObject.
	self onPharoPackageCoderViewModelAdded: aNewChildObject
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoderViewModel >> onPharoPackageCoderViewModelAdded: aPharoPackageCoderViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoPackageCoderViewModel parentPharoPackagesCoderViewModel: self.
	self notifyPharoPackageCoderViewModelAdded: aPharoPackageCoderViewModel.
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoderViewModel >> onPharoPackageCoderViewModelRemoved: aPharoPackageCoderViewModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoPackageCoderViewModelRemoved: aPharoPackageCoderViewModel.
]

{ #category : #'private - event handling' }
Gt2PharoPackagesCoderViewModel >> onPharoPackageRemoved: aGt2PharoPackageCoderRemovedAnnouncement [
	"Is sent when an existing Package is removed from the model of the receiver due to
	the handled ${class:Gt2PharoPackageCoderRemovedAnnouncement}$ announcement."
	<modelEventHandler: #package event: #Gt2PharoPackageCoderRemovedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#onRemovedEventHanderTemplate'>
	| aChildObject |
	
	aChildObject := (self findPharoPackageCoderViewModels: aGt2PharoPackageCoderRemovedAnnouncement pharoPackageCoder)
		ifNil: [ ^ self ].

	self pharoPackageCoderViewModels
		remove: aChildObject
		ifAbsent: [ ^ self ].

	self onPharoPackageCoderViewModelRemoved: aChildObject
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoderViewModel >> pharoPackageCoderViewModels [
	"Return a collection of objects (${class:Gt2PharoPackageCoderViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoPackageCoderViewModel>
	<childObjectGetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  pharoPackageCoderViewModels ifNil: [ pharoPackageCoderViewModels := self createPharoPackageCoderViewModels ]
]

{ #category : #printing }
Gt2PharoPackagesCoderViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoPackagesCoder
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoderViewModel >> removePharoPackageCoder: aPharoPackage [
	"Request the model to remove a given child object.
	I do nothing and simply delegate the removal from the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeDelegateTemplate'>
	self pharoPackagesCoder removePharoPackageCoder: aPharoPackage
]

{ #category : #'api - pharo packages coder' }
Gt2PharoPackagesCoderViewModel >> subscribeToPharoPackagesCoder [
	"Is sent after a new pharoPackagesCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackagesCoder if the receiver subscribes to them"
	<modelSubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	self pharoPackagesCoder when: Gt2PharoPackageCoderAddedAnnouncement send: #onPharoPackageAdded: to: self.
	self pharoPackagesCoder when: Gt2PharoPackageCoderRemovedAnnouncement send: #onPharoPackageRemoved: to: self.
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo packages coder' }
Gt2PharoPackagesCoderViewModel >> unsubscribeFromPharoPackagesCoder [
	"Is sent before a new pharoPackagesCoder is assigned to the receiver.
	Objects that subscribe to pharoPackagesCoder are required to implement this method."
	<modelUnsubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	self pharoPackagesCoder unsubscribe: self.
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoderViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
