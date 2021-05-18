Class {
	#name : #Gt2PharoBehaviorCoderNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithPharoBehaviorCoder',
	#classTraits : 'TGt2WithPharoBehaviorCoder classTrait',
	#instVars : [
		'parentPharoBehaviorsCoderNavigationViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - View Models'
}

{ #category : #'api - announcer' }
Gt2PharoBehaviorCoderNavigationViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoBehaviorsCoderNavigationViewModel
		ifTrue: [ self parentPharoBehaviorsCoderNavigationViewModel announce: anAnnouncement ].
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#hasOtherPropertyTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoderNavigationViewModel >> hasParentPharoBehaviorsCoderNavigationViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoBehaviorsCoderNavigationViewModel notNil
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> isOnlySelectedBehavior [
	"Return true if only this behavior is selected and not any of the children"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#onlyPropertyStatusTesterTemplate'>

	^ self isSelectedBehavior and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoderNavigationViewModel >> isPharoBehaviorCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoderNavigationViewModel >> isPharoBehaviorsCoderNavigationViewModel [
	"Return true if the receiver represents pharoBehaviorsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoderNavigationViewModel >> isPharoPackageCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackageCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoderNavigationViewModel >> isPharoPackagesCoderNavigationViewModel [
	"Return true if the receiver represents pharoPackagesCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoderNavigationViewModel >> isPharoTagCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoderNavigationViewModel >> isPharoTagsCoderNavigationViewModel [
	"Return true if the receiver represents pharoTagsCoderNavigationViewModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> isSelectedBehavior [
	"Return true if this behavior is selected"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#propertyStatusTesterTemplate'>

	^ self parentPharoBehaviorsCoderNavigationViewModel hasSelectedBehaviorCoderNavigationViewModel
		and: [ self parentPharoBehaviorsCoderNavigationViewModel selectedBehaviorCoderNavigationViewModel == self ]
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> notifyBehaviorDeselected [
	<propertyUnsetNotifier: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertyUnsetTemplate'>

	self announce: (Gt2PharoBehaviorCoderNavigationViewModelViewModelDeselected new pharoBehaviorCoderNavigationViewModel: self)
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> notifyBehaviorSelected [
	<propertySetNotifier: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertySetTemplate'>

	self announce: (Gt2PharoBehaviorCoderNavigationViewModelViewModelSelected new pharoBehaviorCoderNavigationViewModel: self)
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorCoderNavigationViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #behavior
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorCoderNavigationViewModel >> parentPharoBehaviorsCoderNavigationViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoBehaviorsCoderNavigationViewModel>
	<parentObjectGetter: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoBehaviorsCoderNavigationViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoBehaviorsCoderNavigationViewModel
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorCoderNavigationViewModel >> parentPharoBehaviorsCoderNavigationViewModel: aGt2PharoBehaviorsCoderNavigationViewModel [
	"Assign a parent object (${class:Gt2PharoBehaviorsCoderNavigationViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoBehaviorsCoderNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoBehaviorsCoderNavigationViewModel := aGt2PharoBehaviorsCoderNavigationViewModel
]

{ #category : #printing }
Gt2PharoBehaviorCoderNavigationViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoBehaviorCoder
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> selectBehavior [
	"Just select a behavior without changing children"
	<propertySetter: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectTemplate'>
	
	self hasParentPharoBehaviorsCoderNavigationViewModel
		ifTrue: [ self parentPharoBehaviorsCoderNavigationViewModel selectBehaviorCoderNavigationViewModel: self ]
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> selectBehaviorWithoutOtherEntities [
	"Select a behavior and deselect other selected children"

	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectWithoutOtherEntitiesTemplate'>
	self deselectAllFromTopMostParent.
	self selectBehavior
]

{ #category : #'api - selection' }
Gt2PharoBehaviorCoderNavigationViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	| aCurrentParent aParentFound |
	
	aParentFound := false.
	
	aCurrentParent := self.
	(aCurrentParent notNil and: [ aCurrentParent hasParentPharoBehaviorsCoderNavigationViewModel ])
		ifFalse: [ aCurrentParent := nil ]
		ifTrue: [ aCurrentParent := aCurrentParent parentPharoBehaviorsCoderNavigationViewModel ].
	
	aCurrentParent
		ifNotNil: [
			aParentFound := true.
			aCurrentParent topMostParentsWithSelectionDo: aBlock ].
	
	
	"there is no assigned parent, meaning I am the topmost"
	aParentFound
		ifFalse: [ aBlock value: self ].
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorCoderNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorCoderNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorCoderNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
