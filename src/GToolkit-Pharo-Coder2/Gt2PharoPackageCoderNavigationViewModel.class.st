Class {
	#name : #Gt2PharoPackageCoderNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithPharoPackageCoder',
	#classTraits : 'TGt2WithPharoPackageCoder classTrait',
	#instVars : [
		'pharoTagsCoderNavigationViewModel',
		'parentPharoPackagesCoderNavigationViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - View Models'
}

{ #category : #'api - announcer' }
Gt2PharoPackageCoderNavigationViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackagesCoderNavigationViewModel
		ifTrue: [ self parentPharoPackagesCoderNavigationViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoPackageCoderNavigationViewModel >> createPharoTagsCoderNavigationViewModel [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #Gt2PharoTagsCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := Gt2PharoTagsCoderNavigationViewModel new.
	childObject parentPharoPackageCoderNavigationViewModel: self.
	childObject pharoTagsCoder: self pharoPackageCoder pharoTagsCoder.
	^ childObject
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
	self pharoTagsCoderNavigationViewModel deselectTagCoderNavigationViewModel.
]

{ #category : #'gt-extentions' }
Gt2PharoPackageCoderNavigationViewModel >> gtTagsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'Tags';
		items: [ self pharoTagsCoderNavigationViewModel pharoTagCoderNavigationViewModels ]
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#hasOtherPropertyTesterTemplate'>

	^ self pharoTagsCoderNavigationViewModel hasSelectedTagCoderNavigationViewModel
]

{ #category : #'api - testing' }
Gt2PharoPackageCoderNavigationViewModel >> hasParentPharoPackagesCoderNavigationViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackagesCoderNavigationViewModel notNil
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> isOnlySelectedPackage [
	"Return true if only this package is selected and not any of the children"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#onlyPropertyStatusTesterTemplate'>

	^ self isSelectedPackage and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
Gt2PharoPackageCoderNavigationViewModel >> isPharoBehaviorCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoderNavigationViewModel >> isPharoBehaviorsCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoderNavigationViewModel >> isPharoPackageCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackageCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoPackageCoderNavigationViewModel >> isPharoPackagesCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackagesCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoderNavigationViewModel >> isPharoTagCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoderNavigationViewModel >> isPharoTagsCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> isSelectedPackage [
	"Return true if this package is selected"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#propertyStatusTesterTemplate'>

	^ self parentPharoPackagesCoderNavigationViewModel hasSelectedPackageCoderNavigationViewModel
		and: [ self parentPharoPackagesCoderNavigationViewModel selectedPackageCoderNavigationViewModel == self ]
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> notifyPackageDeselected [
	<propertyUnsetNotifier: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertyUnsetTemplate'>

	self announce: (Gt2PharoPackageCoderNavigationViewModelViewModelDeselected new pharoPackageCoderNavigationViewModel: self)
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> notifyPackageSelected [
	<propertySetNotifier: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertySetTemplate'>

	self announce: (Gt2PharoPackageCoderNavigationViewModelViewModelSelected new pharoPackageCoderNavigationViewModel: self)
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderNavigationViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #package
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderNavigationViewModel >> packageName [
	^ self pharoPackageCoder packageName
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderNavigationViewModel >> parentPharoPackagesCoderNavigationViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoPackagesCoderNavigationViewModel>
	<parentObjectGetter: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoPackagesCoderNavigationViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoPackagesCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderNavigationViewModel >> parentPharoPackagesCoderNavigationViewModel: aGt2PharoPackagesCoderNavigationViewModel [
	"Assign a parent object (${class:Gt2PharoPackagesCoderNavigationViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoPackagesCoderNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackagesCoderNavigationViewModel := aGt2PharoPackagesCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderNavigationViewModel >> pharoTagsCoderNavigationViewModel [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #Gt2PharoTagsCoderNavigationViewModel>
	<childObjectGetter: #tags>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ pharoTagsCoderNavigationViewModel ifNil: [ pharoTagsCoderNavigationViewModel := self createPharoTagsCoderNavigationViewModel ]
]

{ #category : #printing }
Gt2PharoPackageCoderNavigationViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoPackageCoder
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> selectPackage [
	"Just select a package without changing children"
	<propertySetter: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectTemplate'>
	
	self hasParentPharoPackagesCoderNavigationViewModel
		ifTrue: [ self parentPharoPackagesCoderNavigationViewModel selectPackageCoderNavigationViewModel: self ]
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> selectPackageWithoutOtherEntities [
	"Select a package and deselect other selected children"

	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectWithoutOtherEntitiesTemplate'>
	self deselectAllFromTopMostParent.
	self selectPackage
]

{ #category : #'api - selection' }
Gt2PharoPackageCoderNavigationViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	| aCurrentParent aParentFound |
	
	aParentFound := false.
	
	aCurrentParent := self.
	(aCurrentParent notNil and: [ aCurrentParent hasParentPharoPackagesCoderNavigationViewModel ])
		ifFalse: [ aCurrentParent := nil ]
		ifTrue: [ aCurrentParent := aCurrentParent parentPharoPackagesCoderNavigationViewModel ].
	
	aCurrentParent
		ifNotNil: [
			aParentFound := true.
			aCurrentParent topMostParentsWithSelectionDo: aBlock ].
	
	
	"there is no assigned parent, meaning I am the topmost"
	aParentFound
		ifFalse: [ aBlock value: self ].
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoderNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoderNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoderNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
