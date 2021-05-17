Class {
	#name : #Gt2PharoPackagesCoderNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithPharoPackagesCoder + TGt2WithSelectedPackageCoderNavigationViewModel',
	#classTraits : 'TGt2WithPharoPackagesCoder classTrait + TGt2WithSelectedPackageCoderNavigationViewModel classTrait',
	#instVars : [
		'pharoPackageCoderNavigationViewModels',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - View Models'
}

{ #category : #'api - adding' }
Gt2PharoPackagesCoderNavigationViewModel >> addPharoPackageCoder: aPharoPackage [
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition to the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addDelegateTemplate'>
	self pharoPackagesCoder addPharoPackageCoder: aPharoPackage
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoderNavigationViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoPackagesCoderNavigationViewModel >> createPharoPackageCoderNavigationViewModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #Gt2PharoPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self pharoPackagesCoder pharoPackageCoders collect: [ :eachModel |
		self createPharoPackageCoderNavigationViewModelsFor: eachModel ] as: OrderedCollection
]

{ #category : #'private - instance creation' }
Gt2PharoPackagesCoderNavigationViewModel >> createPharoPackageCoderNavigationViewModelsFor: aChildModel [
	<return: #Gt2PharoPackageCoderNavigationViewModel>
	<childObjectCreator: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := Gt2PharoPackageCoderNavigationViewModel new.
	aNewChild parentPharoPackagesCoderNavigationViewModel: self.
	aNewChild pharoPackageCoder: aChildModel.
	^ aNewChild
]

{ #category : #'api - selection' }
Gt2PharoPackagesCoderNavigationViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
Gt2PharoPackagesCoderNavigationViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
	self deselectPackageCoderNavigationViewModel.
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoderNavigationViewModel >> findPharoPackageCoderNavigationViewModels: aPackage [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #Gt2PharoPackageCoderNavigationViewModel or: nil>
	<childObjectDetector: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findPharoPackageCoderNavigationViewModels: aPackage
		ifFound: [ :aPharoPackageCoderNavigationViewModels | aPharoPackageCoderNavigationViewModels ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoderNavigationViewModel >> findPharoPackageCoderNavigationViewModels: aPackage ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self pharoPackageCoderNavigationViewModels
		detect: [ :eachPharoPackageCoderNavigationViewModels |
			eachPharoPackageCoderNavigationViewModels pharoPackageCoder = aPackage ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-extentions' }
Gt2PharoPackagesCoderNavigationViewModel >> gtPackageListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Package';
		items: [ self pharoPackageCoderNavigationViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoderNavigationViewModel >> includesPharoPackageCoderNavigationViewModels: aPharoPackageCoderNavigationViewModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self pharoPackageCoderNavigationViewModels anySatisfy: [ :eachPharoPackageCoderNavigationViewModels |
		eachPharoPackageCoderNavigationViewModels == aPharoPackageCoderNavigationViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoderNavigationViewModel >> isPharoBehaviorCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoderNavigationViewModel >> isPharoBehaviorsCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoderNavigationViewModel >> isPharoPackageCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackageCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoderNavigationViewModel >> isPharoPackagesCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackagesCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoderNavigationViewModel >> isPharoTagCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoderNavigationViewModel >> isPharoTagsCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'private - notifying' }
Gt2PharoPackagesCoderNavigationViewModel >> notifyPharoPackageCoderNavigationViewModelAdded: aPharoPackageCoderNavigationViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoPackageCoderNavigationViewModelAddedAnnouncement new
		pharoPackageCoderNavigationViewModel: aPharoPackageCoderNavigationViewModel) 
]

{ #category : #'private - notifying' }
Gt2PharoPackagesCoderNavigationViewModel >> notifyPharoPackageCoderNavigationViewModelRemoved: aPharoPackageCoderNavigationViewModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoPackageCoderNavigationViewModelRemovedAnnouncement new
		pharoPackageCoderNavigationViewModel: aPharoPackageCoderNavigationViewModel) 
]

{ #category : #'api - selected package coder navigation view model' }
Gt2PharoPackagesCoderNavigationViewModel >> notifySelectedPackageCoderNavigationViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>

	self announce: Gt2PharoSelectedPackageCoderNavigationViewModelChanged new
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoderNavigationViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #packages
]

{ #category : #'api - selected package coder navigation view model' }
Gt2PharoPackagesCoderNavigationViewModel >> onNewSelectedPackageCoderNavigationViewModelSet: aNewSelectedPackageCoderNavigationViewModel [
	"Is sent after a new value of the selectedPackageCoderNavigationViewModel is assigned"
	<propertySetHook: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>

	aNewSelectedPackageCoderNavigationViewModel notifyPackageSelected
]

{ #category : #'private - event handling' }
Gt2PharoPackagesCoderNavigationViewModel >> onPharoPackageAdded: aGt2PharoPackageCoderAddedAnnouncement [
	"Is sent when a new Package is added to the model of the receiver due to
	the handled ${class:Gt2PharoPackageCoderAddedAnnouncement}$ announcement."
	<modelEventHandler: #package event: #Gt2PharoPackageCoderAddedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#onAddedEventHanderTemplate'>
	| aNewChildObject |

	aNewChildObject := self createPharoPackageCoderNavigationViewModelsFor: aGt2PharoPackageCoderAddedAnnouncement pharoPackageCoder.
	self pharoPackageCoderNavigationViewModels add: aNewChildObject.
	self onPharoPackageCoderNavigationViewModelAdded: aNewChildObject
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoderNavigationViewModel >> onPharoPackageCoderNavigationViewModelAdded: aPharoPackageCoderNavigationViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoPackageCoderNavigationViewModel parentPharoPackagesCoderNavigationViewModel: self.
	self notifyPharoPackageCoderNavigationViewModelAdded: aPharoPackageCoderNavigationViewModel.
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoderNavigationViewModel >> onPharoPackageCoderNavigationViewModelRemoved: aPharoPackageCoderNavigationViewModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoPackageCoderNavigationViewModelRemoved: aPharoPackageCoderNavigationViewModel.
]

{ #category : #'private - event handling' }
Gt2PharoPackagesCoderNavigationViewModel >> onPharoPackageRemoved: aGt2PharoPackageCoderRemovedAnnouncement [
	"Is sent when an existing Package is removed from the model of the receiver due to
	the handled ${class:Gt2PharoPackageCoderRemovedAnnouncement}$ announcement."
	<modelEventHandler: #package event: #Gt2PharoPackageCoderRemovedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#onRemovedEventHanderTemplate'>
	| aChildObject |
	
	aChildObject := (self findPharoPackageCoderNavigationViewModels: aGt2PharoPackageCoderRemovedAnnouncement pharoPackageCoder)
		ifNil: [ ^ self ].

	self pharoPackageCoderNavigationViewModels
		remove: aChildObject
		ifAbsent: [ ^ self ].

	self onPharoPackageCoderNavigationViewModelRemoved: aChildObject
]

{ #category : #'api - selected package coder navigation view model' }
Gt2PharoPackagesCoderNavigationViewModel >> onPreviousSelectedPackageCoderNavigationViewModelUnset: aPreviousSelectedPackageCoderNavigationViewModel [
	"Is sent after a previous value of the selectedPackageCoderNavigationViewModel is de-assigned"
	<propertyUnsetHook: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>

	aPreviousSelectedPackageCoderNavigationViewModel deselectChildren.
	aPreviousSelectedPackageCoderNavigationViewModel notifyPackageDeselected
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoderNavigationViewModel >> pharoPackageCoderNavigationViewModels [
	"Return a collection of objects (${class:Gt2PharoPackageCoderNavigationViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoPackageCoderNavigationViewModel>
	<childObjectGetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  pharoPackageCoderNavigationViewModels ifNil: [ pharoPackageCoderNavigationViewModels := self createPharoPackageCoderNavigationViewModels ]
]

{ #category : #printing }
Gt2PharoPackagesCoderNavigationViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoPackagesCoder
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoderNavigationViewModel >> removePharoPackageCoder: aPharoPackage [
	"Request the model to remove a given child object.
	I do nothing and simply delegate the removal from the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeDelegateTemplate'>
	self pharoPackagesCoder removePharoPackageCoder: aPharoPackage
]

{ #category : #'api - pharo packages coder' }
Gt2PharoPackagesCoderNavigationViewModel >> subscribeToPharoPackagesCoder [
	"Is sent after a new pharoPackagesCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackagesCoder if the receiver subscribes to them"
	<modelSubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	self pharoPackagesCoder when: Gt2PharoPackageCoderAddedAnnouncement send: #onPharoPackageAdded: to: self.
	self pharoPackagesCoder when: Gt2PharoPackageCoderRemovedAnnouncement send: #onPharoPackageRemoved: to: self.
]

{ #category : #'api - selection' }
Gt2PharoPackagesCoderNavigationViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	aBlock value: self.
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoderNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo packages coder' }
Gt2PharoPackagesCoderNavigationViewModel >> unsubscribeFromPharoPackagesCoder [
	"Is sent before a new pharoPackagesCoder is assigned to the receiver.
	Objects that subscribe to pharoPackagesCoder are required to implement this method."
	<modelUnsubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	self pharoPackagesCoder unsubscribe: self.
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoderNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoderNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
