Class {
	#name : #Gt2PharoTagsCoderNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithPharoTagsCoder + TGt2WithSelectedTagCoderNavigationViewModel',
	#classTraits : 'TGt2WithPharoTagsCoder classTrait + TGt2WithSelectedTagCoderNavigationViewModel classTrait',
	#instVars : [
		'pharoTagCoderNavigationViewModels',
		'parentPharoPackageCoderNavigationViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - View Models'
}

{ #category : #'api - adding' }
Gt2PharoTagsCoderNavigationViewModel >> addPharoTagCoder: aPharoTag [
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition to the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addDelegateTemplate'>
	self pharoTagsCoder addPharoTagCoder: aPharoTag
]

{ #category : #'api - announcer' }
Gt2PharoTagsCoderNavigationViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackageCoderNavigationViewModel
		ifTrue: [ self parentPharoPackageCoderNavigationViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoTagsCoderNavigationViewModel >> createPharoTagCoderNavigationViewModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #Gt2PharoTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self pharoTagsCoder pharoTagCoders collect: [ :eachModel |
		self createPharoTagCoderNavigationViewModelsFor: eachModel ] as: OrderedCollection
]

{ #category : #'private - instance creation' }
Gt2PharoTagsCoderNavigationViewModel >> createPharoTagCoderNavigationViewModelsFor: aChildModel [
	<return: #Gt2PharoTagCoderNavigationViewModel>
	<childObjectCreator: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := Gt2PharoTagCoderNavigationViewModel new.
	aNewChild parentPharoTagsCoderNavigationViewModel: self.
	aNewChild pharoTagCoder: aChildModel.
	^ aNewChild
]

{ #category : #'api - selection' }
Gt2PharoTagsCoderNavigationViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
Gt2PharoTagsCoderNavigationViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
	self deselectTagCoderNavigationViewModel.
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoderNavigationViewModel >> findPharoTagCoderNavigationViewModels: aTag [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #Gt2PharoTagCoderNavigationViewModel or: nil>
	<childObjectDetector: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findPharoTagCoderNavigationViewModels: aTag
		ifFound: [ :aPharoTagCoderNavigationViewModels | aPharoTagCoderNavigationViewModels ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoderNavigationViewModel >> findPharoTagCoderNavigationViewModels: aTag ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self pharoTagCoderNavigationViewModels
		detect: [ :eachPharoTagCoderNavigationViewModels |
			eachPharoTagCoderNavigationViewModels pharoTagCoder = aTag ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-extentions' }
Gt2PharoTagsCoderNavigationViewModel >> gtTagListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Tag';
		items: [ self pharoTagCoderNavigationViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoTagsCoderNavigationViewModel >> hasParentPharoPackageCoderNavigationViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackageCoderNavigationViewModel notNil
]

{ #category : #'api - testing' }
Gt2PharoTagsCoderNavigationViewModel >> includesPharoTagCoderNavigationViewModels: aPharoTagCoderNavigationViewModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self pharoTagCoderNavigationViewModels anySatisfy: [ :eachPharoTagCoderNavigationViewModels |
		eachPharoTagCoderNavigationViewModels == aPharoTagCoderNavigationViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoTagsCoderNavigationViewModel >> isPharoBehaviorCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoderNavigationViewModel >> isPharoBehaviorsCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoderNavigationViewModel >> isPharoPackageCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackageCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoderNavigationViewModel >> isPharoPackagesCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackagesCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoderNavigationViewModel >> isPharoTagCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoderNavigationViewModel >> isPharoTagsCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'private - notifying' }
Gt2PharoTagsCoderNavigationViewModel >> notifyPharoTagCoderNavigationViewModelAdded: aPharoTagCoderNavigationViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoTagCoderNavigationViewModelAddedAnnouncement new
		pharoTagCoderNavigationViewModel: aPharoTagCoderNavigationViewModel) 
]

{ #category : #'private - notifying' }
Gt2PharoTagsCoderNavigationViewModel >> notifyPharoTagCoderNavigationViewModelRemoved: aPharoTagCoderNavigationViewModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoTagCoderNavigationViewModelRemovedAnnouncement new
		pharoTagCoderNavigationViewModel: aPharoTagCoderNavigationViewModel) 
]

{ #category : #'api - selected tag coder navigation view model' }
Gt2PharoTagsCoderNavigationViewModel >> notifySelectedTagCoderNavigationViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>

	self announce: Gt2PharoSelectedTagCoderNavigationViewModelChanged new
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoderNavigationViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #tags
]

{ #category : #'api - selected tag coder navigation view model' }
Gt2PharoTagsCoderNavigationViewModel >> onNewSelectedTagCoderNavigationViewModelSet: aNewSelectedTagCoderNavigationViewModel [
	"Is sent after a new value of the selectedTagCoderNavigationViewModel is assigned"
	<propertySetHook: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>

	self hasParentPharoPackageCoderNavigationViewModel
		ifTrue: [ self parentPharoPackageCoderNavigationViewModel selectPackage ].
	aNewSelectedTagCoderNavigationViewModel notifyTagSelected
]

{ #category : #'private - event handling' }
Gt2PharoTagsCoderNavigationViewModel >> onPharoTagAdded: aGt2PharoTagCoderAddedAnnouncement [
	"Is sent when a new Tag is added to the model of the receiver due to
	the handled ${class:Gt2PharoTagCoderAddedAnnouncement}$ announcement."
	<modelEventHandler: #tag event: #Gt2PharoTagCoderAddedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#onAddedEventHanderTemplate'>
	| aNewChildObject |

	aNewChildObject := self createPharoTagCoderNavigationViewModelsFor: aGt2PharoTagCoderAddedAnnouncement pharoTagCoder.
	self pharoTagCoderNavigationViewModels add: aNewChildObject.
	self onPharoTagCoderNavigationViewModelAdded: aNewChildObject
]

{ #category : #'api - adding' }
Gt2PharoTagsCoderNavigationViewModel >> onPharoTagCoderNavigationViewModelAdded: aPharoTagCoderNavigationViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoTagCoderNavigationViewModel parentPharoTagsCoderNavigationViewModel: self.
	self notifyPharoTagCoderNavigationViewModelAdded: aPharoTagCoderNavigationViewModel.
]

{ #category : #'api - adding' }
Gt2PharoTagsCoderNavigationViewModel >> onPharoTagCoderNavigationViewModelRemoved: aPharoTagCoderNavigationViewModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoTagCoderNavigationViewModelRemoved: aPharoTagCoderNavigationViewModel.
]

{ #category : #'private - event handling' }
Gt2PharoTagsCoderNavigationViewModel >> onPharoTagRemoved: aGt2PharoTagCoderRemovedAnnouncement [
	"Is sent when an existing Tag is removed from the model of the receiver due to
	the handled ${class:Gt2PharoTagCoderRemovedAnnouncement}$ announcement."
	<modelEventHandler: #tag event: #Gt2PharoTagCoderRemovedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#onRemovedEventHanderTemplate'>
	| aChildObject |
	
	aChildObject := (self findPharoTagCoderNavigationViewModels: aGt2PharoTagCoderRemovedAnnouncement pharoTagCoder)
		ifNil: [ ^ self ].

	self pharoTagCoderNavigationViewModels
		remove: aChildObject
		ifAbsent: [ ^ self ].

	self onPharoTagCoderNavigationViewModelRemoved: aChildObject
]

{ #category : #'api - selected tag coder navigation view model' }
Gt2PharoTagsCoderNavigationViewModel >> onPreviousSelectedTagCoderNavigationViewModelUnset: aPreviousSelectedTagCoderNavigationViewModel [
	"Is sent after a previous value of the selectedTagCoderNavigationViewModel is de-assigned"
	<propertyUnsetHook: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>

	aPreviousSelectedTagCoderNavigationViewModel deselectChildren.
	aPreviousSelectedTagCoderNavigationViewModel notifyTagDeselected
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoderNavigationViewModel >> parentPharoPackageCoderNavigationViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoPackageCoderNavigationViewModel>
	<parentObjectGetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoPackageCoderNavigationViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoPackageCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoderNavigationViewModel >> parentPharoPackageCoderNavigationViewModel: aGt2PharoPackageCoderNavigationViewModel [
	"Assign a parent object (${class:Gt2PharoPackageCoderNavigationViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoPackageCoderNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackageCoderNavigationViewModel := aGt2PharoPackageCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoderNavigationViewModel >> pharoTagCoderNavigationViewModels [
	"Return a collection of objects (${class:Gt2PharoTagCoderNavigationViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoTagCoderNavigationViewModel>
	<childObjectGetter: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  pharoTagCoderNavigationViewModels ifNil: [ pharoTagCoderNavigationViewModels := self createPharoTagCoderNavigationViewModels ]
]

{ #category : #printing }
Gt2PharoTagsCoderNavigationViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoTagsCoder
]

{ #category : #'api - adding' }
Gt2PharoTagsCoderNavigationViewModel >> removePharoTagCoder: aPharoTag [
	"Request the model to remove a given child object.
	I do nothing and simply delegate the removal from the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeDelegateTemplate'>
	self pharoTagsCoder removePharoTagCoder: aPharoTag
]

{ #category : #'api - pharo tags coder' }
Gt2PharoTagsCoderNavigationViewModel >> subscribeToPharoTagsCoder [
	"Is sent after a new pharoTagsCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTagsCoder if the receiver subscribes to them"
	<modelSubscriber: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	self pharoTagsCoder when: Gt2PharoTagCoderAddedAnnouncement send: #onPharoTagAdded: to: self.
	self pharoTagsCoder when: Gt2PharoTagCoderRemovedAnnouncement send: #onPharoTagRemoved: to: self.
]

{ #category : #'api - selection' }
Gt2PharoTagsCoderNavigationViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	| aCurrentParent aParentFound |
	
	aParentFound := false.
	
	aCurrentParent := self.
	(aCurrentParent notNil and: [ aCurrentParent hasParentPharoPackageCoderNavigationViewModel ])
		ifFalse: [ aCurrentParent := nil ]
		ifTrue: [ aCurrentParent := aCurrentParent parentPharoPackageCoderNavigationViewModel ].
	
	aCurrentParent
		ifNotNil: [
			aParentFound := true.
			aCurrentParent topMostParentsWithSelectionDo: aBlock ].
	
	
	"there is no assigned parent, meaning I am the topmost"
	aParentFound
		ifFalse: [ aBlock value: self ].
]

{ #category : #'api - announcer' }
Gt2PharoTagsCoderNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo tags coder' }
Gt2PharoTagsCoderNavigationViewModel >> unsubscribeFromPharoTagsCoder [
	"Is sent before a new pharoTagsCoder is assigned to the receiver.
	Objects that subscribe to pharoTagsCoder are required to implement this method."
	<modelUnsubscriber: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	self pharoTagsCoder unsubscribe: self.
]

{ #category : #'api - announcer' }
Gt2PharoTagsCoderNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoTagsCoderNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
