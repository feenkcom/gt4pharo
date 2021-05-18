Class {
	#name : #Gt2PharoPackageActionsCoderViewModel,
	#superclass : #Object,
	#instVars : [
		'pharoPackageActionCoderViewModels',
		'parentPharoPackageCoderViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - View Models'
}

{ #category : #'api - adding' }
Gt2PharoPackageActionsCoderViewModel >> addPharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #packageAction>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesPharoPackageActionCoderViewModels: aPharoPackageActionCoderViewModel)
		ifTrue: [ ^ self ].
	
	self primitiveAddPharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel.
	self pharoPackageActionCoderViewModels add: aPharoPackageActionCoderViewModel.
	self onPharoPackageActionCoderViewModelAdded: aPharoPackageActionCoderViewModel
]

{ #category : #'api - announcer' }
Gt2PharoPackageActionsCoderViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackageCoderViewModel
		ifTrue: [ self parentPharoPackageCoderViewModel announce: anAnnouncement ].
]

{ #category : #'gt-extentions' }
Gt2PharoPackageActionsCoderViewModel >> gtPackageActionListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'PackageAction';
		items: [ self pharoPackageActionCoderViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoPackageActionsCoderViewModel >> hasParentPharoPackageCoderViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackageCoderViewModel notNil
]

{ #category : #'api - testing' }
Gt2PharoPackageActionsCoderViewModel >> includesPharoPackageActionCoderViewModels: aPharoPackageActionCoderViewModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #packageAction>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#includesObjectTemplate'>

	^ self pharoPackageActionCoderViewModels anySatisfy: [ :eachPharoPackageActionCoderViewModels |
		eachPharoPackageActionCoderViewModels == aPharoPackageActionCoderViewModels ]
]

{ #category : #'private - notifying' }
Gt2PharoPackageActionsCoderViewModel >> notifyPharoPackageActionCoderViewModelAdded: aPharoPackageActionCoderViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoPackageActionCoderViewModelAddedAnnouncement new
		pharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel) 
]

{ #category : #'private - notifying' }
Gt2PharoPackageActionsCoderViewModel >> notifyPharoPackageActionCoderViewModelRemoved: aPharoPackageActionCoderViewModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoPackageActionCoderViewModelRemovedAnnouncement new
		pharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel) 
]

{ #category : #'api - accessing' }
Gt2PharoPackageActionsCoderViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #packageActions
]

{ #category : #'api - adding' }
Gt2PharoPackageActionsCoderViewModel >> onPharoPackageActionCoderViewModelAdded: aPharoPackageActionCoderViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoPackageActionCoderViewModel parentPharoPackageActionsCoderViewModel: self.
	self notifyPharoPackageActionCoderViewModelAdded: aPharoPackageActionCoderViewModel.
]

{ #category : #'api - adding' }
Gt2PharoPackageActionsCoderViewModel >> onPharoPackageActionCoderViewModelRemoved: aPharoPackageActionCoderViewModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoPackageActionCoderViewModelRemoved: aPharoPackageActionCoderViewModel.
]

{ #category : #'api - accessing' }
Gt2PharoPackageActionsCoderViewModel >> parentPharoPackageCoderViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoPackageCoderViewModel>
	<parentObjectGetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoPackageCoderViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoPackageCoderViewModel
]

{ #category : #'api - accessing' }
Gt2PharoPackageActionsCoderViewModel >> parentPharoPackageCoderViewModel: aGt2PharoPackageCoderViewModel [
	"Assign a parent object (${class:Gt2PharoPackageCoderViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoPackageCoderViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackageCoderViewModel := aGt2PharoPackageCoderViewModel
]

{ #category : #'api - accessing' }
Gt2PharoPackageActionsCoderViewModel >> pharoPackageActionCoderViewModels [
	"Return a collection of objects (${class:Gt2PharoPackageActionCoderViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoPackageActionCoderViewModel>
	<childObjectGetter: #packageAction>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsGetterTemplate'>

	^  pharoPackageActionCoderViewModels ifNil: [ pharoPackageActionCoderViewModels := OrderedCollection new ]
]

{ #category : #'api - accessing' }
Gt2PharoPackageActionsCoderViewModel >> pharoPackageActionCoderViewModels: aCollectionOfGt2PharoPackageActionCoderViewModel [
	"Silently assign a collection of given objects as my children without triggering any event. This is part of the #initialization protocol."
	<modelSetter: #packageActions>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsSetterTemplate'>
	
	pharoPackageActionCoderViewModels := aCollectionOfGt2PharoPackageActionCoderViewModel asOrderedCollection.
	pharoPackageActionCoderViewModels do: [ :eachGt2PharoPackageActionCoderViewModel |
		eachGt2PharoPackageActionCoderViewModel parentPharoPackageActionsCoderViewModel: self ]
]

{ #category : #'private - adding' }
Gt2PharoPackageActionsCoderViewModel >> primitiveAddPharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel [
	"Is sent right before adding aPharoPackageActionCoderViewModel as my child.
	Override this method to implement primitive addition behavior such as for example adding a new folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#primitiveAddTemplate'>
]

{ #category : #'private - removing' }
Gt2PharoPackageActionsCoderViewModel >> primitiveRemovePharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel [
	"Is sent right before removing aPharoPackageActionCoderViewModel from my children.
	Override this method to implement primitive removal behavior such as for example removing a folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#primitiveRemoveTemplate'>
]

{ #category : #printing }
Gt2PharoPackageActionsCoderViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	super printOn: aStream
]

{ #category : #'api - adding' }
Gt2PharoPackageActionsCoderViewModel >> removePharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #packageAction>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesPharoPackageActionCoderViewModels: aPharoPackageActionCoderViewModel)
		ifFalse: [ ^ self ].
	
	self primitiveRemovePharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel.
	self pharoPackageActionCoderViewModels
		remove: aPharoPackageActionCoderViewModel
		ifAbsent: [ ^ self ].
	self onPharoPackageActionCoderViewModelRemoved: aPharoPackageActionCoderViewModel
]

{ #category : #'api - announcer' }
Gt2PharoPackageActionsCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoPackageActionsCoderViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackageActionsCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
