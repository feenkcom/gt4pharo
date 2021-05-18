Class {
	#name : #Gt2PharoTagCoderNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithPharoTagCoder',
	#classTraits : 'TGt2WithPharoTagCoder classTrait',
	#instVars : [
		'pharoBehaviorsCoderNavigationViewModel',
		'parentPharoTagsCoderNavigationViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - View Models'
}

{ #category : #'api - announcer' }
Gt2PharoTagCoderNavigationViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoTagsCoderNavigationViewModel
		ifTrue: [ self parentPharoTagsCoderNavigationViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoTagCoderNavigationViewModel >> createPharoBehaviorsCoderNavigationViewModel [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #Gt2PharoBehaviorsCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := Gt2PharoBehaviorsCoderNavigationViewModel new.
	childObject parentPharoTagCoderNavigationViewModel: self.
	childObject pharoBehaviorsCoder: self pharoTagCoder pharoBehaviorsCoder.
	^ childObject
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
	self pharoBehaviorsCoderNavigationViewModel deselectBehaviorCoderNavigationViewModel.
]

{ #category : #'gt-extentions' }
Gt2PharoTagCoderNavigationViewModel >> gtBehaviorsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'Behaviors';
		items: [ self pharoBehaviorsCoderNavigationViewModel pharoBehaviorCoderNavigationViewModels ]
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#hasOtherPropertyTesterTemplate'>

	^ self pharoBehaviorsCoderNavigationViewModel hasSelectedBehaviorCoderNavigationViewModel
]

{ #category : #'api - testing' }
Gt2PharoTagCoderNavigationViewModel >> hasParentPharoTagsCoderNavigationViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #tags>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoTagsCoderNavigationViewModel notNil
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> isOnlySelectedTag [
	"Return true if only this tag is selected and not any of the children"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#onlyPropertyStatusTesterTemplate'>

	^ self isSelectedTag and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
Gt2PharoTagCoderNavigationViewModel >> isPharoBehaviorCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoderNavigationViewModel >> isPharoBehaviorsCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoderNavigationViewModel >> isPharoPackageCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackageCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoderNavigationViewModel >> isPharoPackagesCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackagesCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoderNavigationViewModel >> isPharoTagCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoTagCoderNavigationViewModel >> isPharoTagsCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> isSelectedTag [
	"Return true if this tag is selected"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#propertyStatusTesterTemplate'>

	^ self parentPharoTagsCoderNavigationViewModel hasSelectedTagCoderNavigationViewModel
		and: [ self parentPharoTagsCoderNavigationViewModel selectedTagCoderNavigationViewModel == self ]
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> notifyTagDeselected [
	<propertyUnsetNotifier: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertyUnsetTemplate'>

	self announce: (Gt2PharoTagCoderNavigationViewModelViewModelDeselected new pharoTagCoderNavigationViewModel: self)
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> notifyTagSelected [
	<propertySetNotifier: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertySetTemplate'>

	self announce: (Gt2PharoTagCoderNavigationViewModelViewModelSelected new pharoTagCoderNavigationViewModel: self)
]

{ #category : #'api - accessing' }
Gt2PharoTagCoderNavigationViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #tag
]

{ #category : #'api - accessing' }
Gt2PharoTagCoderNavigationViewModel >> parentPharoTagsCoderNavigationViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoTagsCoderNavigationViewModel>
	<parentObjectGetter: #tags>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoTagsCoderNavigationViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoTagsCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoTagCoderNavigationViewModel >> parentPharoTagsCoderNavigationViewModel: aGt2PharoTagsCoderNavigationViewModel [
	"Assign a parent object (${class:Gt2PharoTagsCoderNavigationViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #tags>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoTagsCoderNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoTagsCoderNavigationViewModel := aGt2PharoTagsCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoTagCoderNavigationViewModel >> pharoBehaviorsCoderNavigationViewModel [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #Gt2PharoBehaviorsCoderNavigationViewModel>
	<childObjectGetter: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ pharoBehaviorsCoderNavigationViewModel ifNil: [ pharoBehaviorsCoderNavigationViewModel := self createPharoBehaviorsCoderNavigationViewModel ]
]

{ #category : #printing }
Gt2PharoTagCoderNavigationViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoTagCoder
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> selectTag [
	"Just select a tag without changing children"
	<propertySetter: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectTemplate'>
	
	self hasParentPharoTagsCoderNavigationViewModel
		ifTrue: [ self parentPharoTagsCoderNavigationViewModel selectTagCoderNavigationViewModel: self ]
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> selectTagWithoutOtherEntities [
	"Select a tag and deselect other selected children"

	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectWithoutOtherEntitiesTemplate'>
	self deselectAllFromTopMostParent.
	self selectTag
]

{ #category : #'api - accessing' }
Gt2PharoTagCoderNavigationViewModel >> tagName [
	^ self pharoTagCoder tagName
]

{ #category : #'api - selection' }
Gt2PharoTagCoderNavigationViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	| aCurrentParent aParentFound |
	
	aParentFound := false.
	
	aCurrentParent := self.
	(aCurrentParent notNil and: [ aCurrentParent hasParentPharoTagsCoderNavigationViewModel ])
		ifFalse: [ aCurrentParent := nil ]
		ifTrue: [ aCurrentParent := aCurrentParent parentPharoTagsCoderNavigationViewModel ].
	
	aCurrentParent
		ifNotNil: [
			aParentFound := true.
			aCurrentParent topMostParentsWithSelectionDo: aBlock ].
	
	
	"there is no assigned parent, meaning I am the topmost"
	aParentFound
		ifFalse: [ aBlock value: self ].
]

{ #category : #'api - announcer' }
Gt2PharoTagCoderNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoTagCoderNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoTagCoderNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
