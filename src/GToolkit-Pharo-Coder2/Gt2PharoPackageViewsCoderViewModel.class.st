Class {
	#name : #Gt2PharoPackageViewsCoderViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithSelectedPackageViewCoderViewModel',
	#classTraits : 'TGt2WithSelectedPackageViewCoderViewModel classTrait',
	#instVars : [
		'phlowViews',
		'pharoPackageViewCoderViewModels',
		'parentPharoPackageCoderViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - View Models'
}

{ #category : #'api - adding' }
Gt2PharoPackageViewsCoderViewModel >> addPharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #packageView>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesPharoPackageViewCoderViewModels: aPharoPackageViewCoderViewModel)
		ifTrue: [ ^ self ].
	
	self primitiveAddPharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel.
	self pharoPackageViewCoderViewModels add: aPharoPackageViewCoderViewModel.
	self onPharoPackageViewCoderViewModelAdded: aPharoPackageViewCoderViewModel
]

{ #category : #'api - announcer' }
Gt2PharoPackageViewsCoderViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackageCoderViewModel
		ifTrue: [ self parentPharoPackageCoderViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoPackageViewsCoderViewModel >> createPharoPackageViewCoderViewModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #Gt2PharoPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self phlowViews yourself collect: [ :eachModel |
		self createPharoPackageViewCoderViewModelsFor: eachModel ] as: OrderedCollection
]

{ #category : #'private - instance creation' }
Gt2PharoPackageViewsCoderViewModel >> createPharoPackageViewCoderViewModelsFor: aChildModel [
	<return: #Gt2PharoPackageViewCoderViewModel>
	<childObjectCreator: #packageView>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := Gt2PharoPackageViewCoderViewModel new.
	aNewChild parentPharoPackageViewsCoderViewModel: self.
	aNewChild phlowView: aChildModel.
	^ aNewChild
]

{ #category : #'api - selection' }
Gt2PharoPackageViewsCoderViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
Gt2PharoPackageViewsCoderViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
	self deselectPackageViewCoderViewModel.
]

{ #category : #'api - accessing' }
Gt2PharoPackageViewsCoderViewModel >> findPharoPackageViewCoderViewModels: aPackageView [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #Gt2PharoPackageViewCoderViewModel or: nil>
	<childObjectDetector: #packageView>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findPharoPackageViewCoderViewModels: aPackageView
		ifFound: [ :aPharoPackageViewCoderViewModels | aPharoPackageViewCoderViewModels ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
Gt2PharoPackageViewsCoderViewModel >> findPharoPackageViewCoderViewModels: aPackageView ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self pharoPackageViewCoderViewModels
		detect: [ :eachPharoPackageViewCoderViewModels |
			eachPharoPackageViewCoderViewModels phlowView = aPackageView ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-extentions' }
Gt2PharoPackageViewsCoderViewModel >> gtPackageViewListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'PackageView';
		items: [ self pharoPackageViewCoderViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoPackageViewsCoderViewModel >> hasParentPharoPackageCoderViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackageCoderViewModel notNil
]

{ #category : #'api - phlow views' }
Gt2PharoPackageViewsCoderViewModel >> hasPhlowViews [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #phlowViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ phlowViews notNil
]

{ #category : #'api - testing' }
Gt2PharoPackageViewsCoderViewModel >> includesPharoPackageViewCoderViewModels: aPharoPackageViewCoderViewModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #packageView>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self pharoPackageViewCoderViewModels anySatisfy: [ :eachPharoPackageViewCoderViewModels |
		eachPharoPackageViewCoderViewModels == aPharoPackageViewCoderViewModels ]
]

{ #category : #'private - notifying' }
Gt2PharoPackageViewsCoderViewModel >> notifyPharoPackageViewCoderViewModelAdded: aPharoPackageViewCoderViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoPackageViewCoderViewModelAddedAnnouncement new
		pharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel) 
]

{ #category : #'private - notifying' }
Gt2PharoPackageViewsCoderViewModel >> notifyPharoPackageViewCoderViewModelRemoved: aPharoPackageViewCoderViewModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoPackageViewCoderViewModelRemovedAnnouncement new
		pharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel) 
]

{ #category : #'api - selected package view coder view model' }
Gt2PharoPackageViewsCoderViewModel >> notifySelectedPackageViewCoderViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>

	self announce: Gt2PharoSelectedPackageViewCoderViewModelChanged new
]

{ #category : #'api - accessing' }
Gt2PharoPackageViewsCoderViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #packageViews
]

{ #category : #'api - selected package view coder view model' }
Gt2PharoPackageViewsCoderViewModel >> onNewSelectedPackageViewCoderViewModelSet: aNewSelectedPackageViewCoderViewModel [
	"Is sent after a new value of the selectedPackageViewCoderViewModel is assigned"
	<propertySetHook: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>

	aNewSelectedPackageViewCoderViewModel notifyPackageViewSelected
]

{ #category : #'api - adding' }
Gt2PharoPackageViewsCoderViewModel >> onPharoPackageViewCoderViewModelAdded: aPharoPackageViewCoderViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoPackageViewCoderViewModel parentPharoPackageViewsCoderViewModel: self.
	self notifyPharoPackageViewCoderViewModelAdded: aPharoPackageViewCoderViewModel.
]

{ #category : #'api - adding' }
Gt2PharoPackageViewsCoderViewModel >> onPharoPackageViewCoderViewModelRemoved: aPharoPackageViewCoderViewModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoPackageViewCoderViewModelRemoved: aPharoPackageViewCoderViewModel.
]

{ #category : #'api - phlow views' }
Gt2PharoPackageViewsCoderViewModel >> onPhlowViewsChanged [
	"Is sent when a new phlowViews is assigned to the receiver.
	Note: #onPhlowViewsChanged is sent before #subscribeToPhlowViews
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPhlowViewsChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - phlow views' }
Gt2PharoPackageViewsCoderViewModel >> onPostPhlowViewsChanged [
	"I am an optional hook method that is sent after #subscribeToPhlowViews.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - selected package view coder view model' }
Gt2PharoPackageViewsCoderViewModel >> onPreviousSelectedPackageViewCoderViewModelUnset: aPreviousSelectedPackageViewCoderViewModel [
	"Is sent after a previous value of the selectedPackageViewCoderViewModel is de-assigned"
	<propertyUnsetHook: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>

	aPreviousSelectedPackageViewCoderViewModel deselectChildren.
	aPreviousSelectedPackageViewCoderViewModel notifyPackageViewDeselected
]

{ #category : #'api - accessing' }
Gt2PharoPackageViewsCoderViewModel >> parentPharoPackageCoderViewModel [
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
Gt2PharoPackageViewsCoderViewModel >> parentPharoPackageCoderViewModel: aGt2PharoPackageCoderViewModel [
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
Gt2PharoPackageViewsCoderViewModel >> pharoPackageViewCoderViewModels [
	"Return a collection of objects (${class:Gt2PharoPackageViewCoderViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoPackageViewCoderViewModel>
	<childObjectGetter: #packageView>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  pharoPackageViewCoderViewModels ifNil: [ pharoPackageViewCoderViewModels := self createPharoPackageViewCoderViewModels ]
]

{ #category : #'api - accessing' }
Gt2PharoPackageViewsCoderViewModel >> pharoPackageViewCoderViewModels: aCollectionOfGt2PharoPackageViewCoderViewModel [
	"Silently assign a collection of given objects as my children without triggering any event. This is part of the #initialization protocol."
	<modelSetter: #packageViews>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsSetterTemplate'>
	
	pharoPackageViewCoderViewModels := aCollectionOfGt2PharoPackageViewCoderViewModel asOrderedCollection.
	pharoPackageViewCoderViewModels do: [ :eachGt2PharoPackageViewCoderViewModel |
		eachGt2PharoPackageViewCoderViewModel parentPharoPackageViewsCoderViewModel: self ]
]

{ #category : #'api - phlow views' }
Gt2PharoPackageViewsCoderViewModel >> phlowViews [
	"Return a not-null phlowViews assigned to the receiver"
	<modelGetter: #phlowViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ phlowViews notNil ]
		description: [ 'phlowViews should be initialized' ].

	^ phlowViews
]

{ #category : #'api - phlow views' }
Gt2PharoPackageViewsCoderViewModel >> phlowViews: aPhlowViews [
	"Set a not-null phlowViews assigned to the receiver"
	<modelSetter: #phlowViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPhlowViews notNil ]
		description: [ 'phlowViews must not be nil' ].

	phlowViews == aPhlowViews
		ifTrue: [ ^ self ].

	phlowViews ifNotNil: [ self unsubscribeFromPhlowViews ].
	phlowViews := aPhlowViews.

	self onPhlowViewsChanged.
	self subscribeToPhlowViews.
	self onPostPhlowViewsChanged
]

{ #category : #'private - adding' }
Gt2PharoPackageViewsCoderViewModel >> primitiveAddPharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel [
	"Is sent right before adding aPharoPackageViewCoderViewModel as my child.
	Override this method to implement primitive addition behavior such as for example adding a new folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#primitiveAddTemplate'>
]

{ #category : #'private - removing' }
Gt2PharoPackageViewsCoderViewModel >> primitiveRemovePharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel [
	"Is sent right before removing aPharoPackageViewCoderViewModel from my children.
	Override this method to implement primitive removal behavior such as for example removing a folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#primitiveRemoveTemplate'>
]

{ #category : #printing }
Gt2PharoPackageViewsCoderViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self phlowViews
]

{ #category : #'api - adding' }
Gt2PharoPackageViewsCoderViewModel >> removePharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #packageView>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesPharoPackageViewCoderViewModels: aPharoPackageViewCoderViewModel)
		ifFalse: [ ^ self ].
	
	self primitiveRemovePharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel.
	self pharoPackageViewCoderViewModels
		remove: aPharoPackageViewCoderViewModel
		ifAbsent: [ ^ self ].
	self onPharoPackageViewCoderViewModelRemoved: aPharoPackageViewCoderViewModel
]

{ #category : #'api - phlow views' }
Gt2PharoPackageViewsCoderViewModel >> subscribeToPhlowViews [
	"Is sent after a new phlowViews is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPhlowViews if the receiver subscribes to them"
	<modelSubscriber: #phlowViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - selection' }
Gt2PharoPackageViewsCoderViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	aBlock value: self.
]

{ #category : #'api - announcer' }
Gt2PharoPackageViewsCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - phlow views' }
Gt2PharoPackageViewsCoderViewModel >> unsubscribeFromPhlowViews [
	"Is sent before a new phlowViews is assigned to the receiver.
	Objects that subscribe to phlowViews are required to implement this method."
	<modelUnsubscriber: #phlowViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoPackageViewsCoderViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackageViewsCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
