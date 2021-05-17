Class {
	#name : #Gt2PharoBehaviorsCoderNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithPharoBehaviorsCoder + TGt2WithSelectedBehaviorCoderNavigationViewModel',
	#classTraits : 'TGt2WithPharoBehaviorsCoder classTrait + TGt2WithSelectedBehaviorCoderNavigationViewModel classTrait',
	#instVars : [
		'pharoBehaviorCoderNavigationViewModels',
		'parentPharoTagCoderNavigationViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - View Models'
}

{ #category : #'api - adding' }
Gt2PharoBehaviorsCoderNavigationViewModel >> addPharoBehaviorCoder: aPharoBehavior [
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition to the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addDelegateTemplate'>
	self pharoBehaviorsCoder addPharoBehaviorCoder: aPharoBehavior
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorsCoderNavigationViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoTagCoderNavigationViewModel
		ifTrue: [ self parentPharoTagCoderNavigationViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoBehaviorsCoderNavigationViewModel >> createPharoBehaviorCoderNavigationViewModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #Gt2PharoBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self pharoBehaviorsCoder pharoBehaviorCoders collect: [ :eachModel |
		self createPharoBehaviorCoderNavigationViewModelsFor: eachModel ] as: OrderedCollection
]

{ #category : #'private - instance creation' }
Gt2PharoBehaviorsCoderNavigationViewModel >> createPharoBehaviorCoderNavigationViewModelsFor: aChildModel [
	<return: #Gt2PharoBehaviorCoderNavigationViewModel>
	<childObjectCreator: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := Gt2PharoBehaviorCoderNavigationViewModel new.
	aNewChild parentPharoBehaviorsCoderNavigationViewModel: self.
	aNewChild pharoBehaviorCoder: aChildModel.
	^ aNewChild
]

{ #category : #'api - selection' }
Gt2PharoBehaviorsCoderNavigationViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
Gt2PharoBehaviorsCoderNavigationViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
	self deselectBehaviorCoderNavigationViewModel.
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> findPharoBehaviorCoderNavigationViewModels: aBehavior [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #Gt2PharoBehaviorCoderNavigationViewModel or: nil>
	<childObjectDetector: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findPharoBehaviorCoderNavigationViewModels: aBehavior
		ifFound: [ :aPharoBehaviorCoderNavigationViewModels | aPharoBehaviorCoderNavigationViewModels ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> findPharoBehaviorCoderNavigationViewModels: aBehavior ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self pharoBehaviorCoderNavigationViewModels
		detect: [ :eachPharoBehaviorCoderNavigationViewModels |
			eachPharoBehaviorCoderNavigationViewModels pharoBehaviorCoder = aBehavior ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-extentions' }
Gt2PharoBehaviorsCoderNavigationViewModel >> gtBehaviorListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Behavior';
		items: [ self pharoBehaviorCoderNavigationViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> hasParentPharoTagCoderNavigationViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoTagCoderNavigationViewModel notNil
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> includesPharoBehaviorCoderNavigationViewModels: aPharoBehaviorCoderNavigationViewModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self pharoBehaviorCoderNavigationViewModels anySatisfy: [ :eachPharoBehaviorCoderNavigationViewModels |
		eachPharoBehaviorCoderNavigationViewModels == aPharoBehaviorCoderNavigationViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> isPharoBehaviorCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> isPharoBehaviorsCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> isPharoPackageCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackageCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> isPharoPackagesCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackagesCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> isPharoTagCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> isPharoTagsCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'private - notifying' }
Gt2PharoBehaviorsCoderNavigationViewModel >> notifyPharoBehaviorCoderNavigationViewModelAdded: aPharoBehaviorCoderNavigationViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoBehaviorCoderNavigationViewModelAddedAnnouncement new
		pharoBehaviorCoderNavigationViewModel: aPharoBehaviorCoderNavigationViewModel) 
]

{ #category : #'private - notifying' }
Gt2PharoBehaviorsCoderNavigationViewModel >> notifyPharoBehaviorCoderNavigationViewModelRemoved: aPharoBehaviorCoderNavigationViewModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoBehaviorCoderNavigationViewModelRemovedAnnouncement new
		pharoBehaviorCoderNavigationViewModel: aPharoBehaviorCoderNavigationViewModel) 
]

{ #category : #'api - selected behavior coder navigation view model' }
Gt2PharoBehaviorsCoderNavigationViewModel >> notifySelectedBehaviorCoderNavigationViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>

	self announce: Gt2PharoSelectedBehaviorCoderNavigationViewModelChanged new
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #behaviors
]

{ #category : #'api - selected behavior coder navigation view model' }
Gt2PharoBehaviorsCoderNavigationViewModel >> onNewSelectedBehaviorCoderNavigationViewModelSet: aNewSelectedBehaviorCoderNavigationViewModel [
	"Is sent after a new value of the selectedBehaviorCoderNavigationViewModel is assigned"
	<propertySetHook: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>

	self hasParentPharoTagCoderNavigationViewModel
		ifTrue: [ self parentPharoTagCoderNavigationViewModel selectTag ].
	aNewSelectedBehaviorCoderNavigationViewModel notifyBehaviorSelected
]

{ #category : #'private - event handling' }
Gt2PharoBehaviorsCoderNavigationViewModel >> onPharoBehaviorAdded: aGt2PharoBehaviorCoderAddedAnnouncement [
	"Is sent when a new Behavior is added to the model of the receiver due to
	the handled ${class:Gt2PharoBehaviorCoderAddedAnnouncement}$ announcement."
	<modelEventHandler: #behavior event: #Gt2PharoBehaviorCoderAddedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#onAddedEventHanderTemplate'>
	| aNewChildObject |

	aNewChildObject := self createPharoBehaviorCoderNavigationViewModelsFor: aGt2PharoBehaviorCoderAddedAnnouncement pharoBehaviorCoder.
	self pharoBehaviorCoderNavigationViewModels add: aNewChildObject.
	self onPharoBehaviorCoderNavigationViewModelAdded: aNewChildObject
]

{ #category : #'api - adding' }
Gt2PharoBehaviorsCoderNavigationViewModel >> onPharoBehaviorCoderNavigationViewModelAdded: aPharoBehaviorCoderNavigationViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoBehaviorCoderNavigationViewModel parentPharoBehaviorsCoderNavigationViewModel: self.
	self notifyPharoBehaviorCoderNavigationViewModelAdded: aPharoBehaviorCoderNavigationViewModel.
]

{ #category : #'api - adding' }
Gt2PharoBehaviorsCoderNavigationViewModel >> onPharoBehaviorCoderNavigationViewModelRemoved: aPharoBehaviorCoderNavigationViewModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoBehaviorCoderNavigationViewModelRemoved: aPharoBehaviorCoderNavigationViewModel.
]

{ #category : #'private - event handling' }
Gt2PharoBehaviorsCoderNavigationViewModel >> onPharoBehaviorRemoved: aGt2PharoBehaviorCoderRemovedAnnouncement [
	"Is sent when an existing Behavior is removed from the model of the receiver due to
	the handled ${class:Gt2PharoBehaviorCoderRemovedAnnouncement}$ announcement."
	<modelEventHandler: #behavior event: #Gt2PharoBehaviorCoderRemovedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#onRemovedEventHanderTemplate'>
	| aChildObject |
	
	aChildObject := (self findPharoBehaviorCoderNavigationViewModels: aGt2PharoBehaviorCoderRemovedAnnouncement pharoBehaviorCoder)
		ifNil: [ ^ self ].

	self pharoBehaviorCoderNavigationViewModels
		remove: aChildObject
		ifAbsent: [ ^ self ].

	self onPharoBehaviorCoderNavigationViewModelRemoved: aChildObject
]

{ #category : #'api - selected behavior coder navigation view model' }
Gt2PharoBehaviorsCoderNavigationViewModel >> onPreviousSelectedBehaviorCoderNavigationViewModelUnset: aPreviousSelectedBehaviorCoderNavigationViewModel [
	"Is sent after a previous value of the selectedBehaviorCoderNavigationViewModel is de-assigned"
	<propertyUnsetHook: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>

	aPreviousSelectedBehaviorCoderNavigationViewModel deselectChildren.
	aPreviousSelectedBehaviorCoderNavigationViewModel notifyBehaviorDeselected
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> parentPharoTagCoderNavigationViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoTagCoderNavigationViewModel>
	<parentObjectGetter: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoTagCoderNavigationViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoTagCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> parentPharoTagCoderNavigationViewModel: aGt2PharoTagCoderNavigationViewModel [
	"Assign a parent object (${class:Gt2PharoTagCoderNavigationViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoTagCoderNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoTagCoderNavigationViewModel := aGt2PharoTagCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoderNavigationViewModel >> pharoBehaviorCoderNavigationViewModels [
	"Return a collection of objects (${class:Gt2PharoBehaviorCoderNavigationViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoBehaviorCoderNavigationViewModel>
	<childObjectGetter: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  pharoBehaviorCoderNavigationViewModels ifNil: [ pharoBehaviorCoderNavigationViewModels := self createPharoBehaviorCoderNavigationViewModels ]
]

{ #category : #printing }
Gt2PharoBehaviorsCoderNavigationViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoBehaviorsCoder
]

{ #category : #'api - adding' }
Gt2PharoBehaviorsCoderNavigationViewModel >> removePharoBehaviorCoder: aPharoBehavior [
	"Request the model to remove a given child object.
	I do nothing and simply delegate the removal from the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeDelegateTemplate'>
	self pharoBehaviorsCoder removePharoBehaviorCoder: aPharoBehavior
]

{ #category : #'api - pharo behaviors coder' }
Gt2PharoBehaviorsCoderNavigationViewModel >> subscribeToPharoBehaviorsCoder [
	"Is sent after a new pharoBehaviorsCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoBehaviorsCoder if the receiver subscribes to them"
	<modelSubscriber: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	self pharoBehaviorsCoder when: Gt2PharoBehaviorCoderAddedAnnouncement send: #onPharoBehaviorAdded: to: self.
	self pharoBehaviorsCoder when: Gt2PharoBehaviorCoderRemovedAnnouncement send: #onPharoBehaviorRemoved: to: self.
]

{ #category : #'api - selection' }
Gt2PharoBehaviorsCoderNavigationViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	| aCurrentParent aParentFound |
	
	aParentFound := false.
	
	aCurrentParent := self.
	(aCurrentParent notNil and: [ aCurrentParent hasParentPharoTagCoderNavigationViewModel ])
		ifFalse: [ aCurrentParent := nil ]
		ifTrue: [ aCurrentParent := aCurrentParent parentPharoTagCoderNavigationViewModel ].
	
	aCurrentParent
		ifNotNil: [
			aParentFound := true.
			aCurrentParent topMostParentsWithSelectionDo: aBlock ].
	
	
	"there is no assigned parent, meaning I am the topmost"
	aParentFound
		ifFalse: [ aBlock value: self ].
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorsCoderNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo behaviors coder' }
Gt2PharoBehaviorsCoderNavigationViewModel >> unsubscribeFromPharoBehaviorsCoder [
	"Is sent before a new pharoBehaviorsCoder is assigned to the receiver.
	Objects that subscribe to pharoBehaviorsCoder are required to implement this method."
	<modelUnsubscriber: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	self pharoBehaviorsCoder unsubscribe: self.
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorsCoderNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorsCoderNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
