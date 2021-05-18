Class {
	#name : #Gt2PharoPackageViewCoderViewModel,
	#superclass : #Object,
	#instVars : [
		'phlowView',
		'parentPharoPackageViewsCoderViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - View Models'
}

{ #category : #'api - announcer' }
Gt2PharoPackageViewCoderViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackageViewsCoderViewModel
		ifTrue: [ self parentPharoPackageViewsCoderViewModel announce: anAnnouncement ].
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#hasOtherPropertyTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageViewCoderViewModel >> hasParentPharoPackageViewsCoderViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #packageViews>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackageViewsCoderViewModel notNil
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> hasPhlowView [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #phlowView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ phlowView notNil
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> isOnlySelectedPackageView [
	"Return true if only this packageView is selected and not any of the children"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#onlyPropertyStatusTesterTemplate'>

	^ self isSelectedPackageView and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> isSelectedPackageView [
	"Return true if this packageView is selected"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#propertyStatusTesterTemplate'>

	^ self parentPharoPackageViewsCoderViewModel hasSelectedPackageViewCoderViewModel
		and: [ self parentPharoPackageViewsCoderViewModel selectedPackageViewCoderViewModel == self ]
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> notifyPackageViewDeselected [
	<propertyUnsetNotifier: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertyUnsetTemplate'>

	self announce: (Gt2PharoPackageViewCoderViewModelViewModelDeselected new pharoPackageViewCoderViewModel: self)
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> notifyPackageViewSelected [
	<propertySetNotifier: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertySetTemplate'>

	self announce: (Gt2PharoPackageViewCoderViewModelViewModelSelected new pharoPackageViewCoderViewModel: self)
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> notifyPhlowViewChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #phlowView>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>

	self announce: Gt2PharoPackageViewCoderViewModelPhlowViewChanged new
]

{ #category : #'api - accessing' }
Gt2PharoPackageViewCoderViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #packageView
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> onNewPhlowViewSet: aNewPhlowView [
	"Is sent after a new value of the phlowView is assigned"
	<propertySetHook: #phlowView>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> onPhlowViewChanged [
	"Is sent when a new phlowView is assigned to the receiver.
	Note: #onPhlowViewChanged is sent before #subscribeToPhlowView
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPhlowViewChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> onPostPhlowViewChanged [
	"I am an optional hook method that is sent after #subscribeToPhlowView.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> onPreviousPhlowViewUnset: aPreviousPhlowView [
	"Is sent after a previous value of the phlowView is de-assigned"
	<propertyUnsetHook: #phlowView>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoPackageViewCoderViewModel >> parentPharoPackageViewsCoderViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoPackageViewsCoderViewModel>
	<parentObjectGetter: #packageViews>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoPackageViewsCoderViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoPackageViewsCoderViewModel
]

{ #category : #'api - accessing' }
Gt2PharoPackageViewCoderViewModel >> parentPharoPackageViewsCoderViewModel: aGt2PharoPackageViewsCoderViewModel [
	"Assign a parent object (${class:Gt2PharoPackageViewsCoderViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #packageViews>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoPackageViewsCoderViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackageViewsCoderViewModel := aGt2PharoPackageViewsCoderViewModel
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> phlowView [
	"Return a not-null phlowView assigned to the receiver"
	<modelGetter: #phlowView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ phlowView notNil ]
		description: [ 'phlowView should be initialized' ].

	^ phlowView
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> phlowView: aPhlowView [
	"Set a not-null phlowView assigned to the receiver"
	<modelSetter: #phlowView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPhlowView notNil ]
		description: [ 'phlowView must not be nil' ].

	phlowView == aPhlowView
		ifTrue: [ ^ self ].

	phlowView ifNotNil: [ self unsubscribeFromPhlowView ].
	phlowView := aPhlowView.

	self onPhlowViewChanged.
	self subscribeToPhlowView.
	self onPostPhlowViewChanged
]

{ #category : #printing }
Gt2PharoPackageViewCoderViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self phlowView
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> selectPackageView [
	"Just select a packageView without changing children"
	<propertySetter: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectTemplate'>
	
	self hasParentPharoPackageViewsCoderViewModel
		ifTrue: [ self parentPharoPackageViewsCoderViewModel selectPackageViewCoderViewModel: self ]
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> selectPackageViewWithoutOtherEntities [
	"Select a packageView and deselect other selected children"

	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectWithoutOtherEntitiesTemplate'>
	self deselectAllFromTopMostParent.
	self selectPackageView
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> subscribeToPhlowView [
	"Is sent after a new phlowView is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPhlowView if the receiver subscribes to them"
	<modelSubscriber: #phlowView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - selection' }
Gt2PharoPackageViewCoderViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	| aCurrentParent aParentFound |
	
	aParentFound := false.
	
	aCurrentParent := self.
	(aCurrentParent notNil and: [ aCurrentParent hasParentPharoPackageViewsCoderViewModel ])
		ifFalse: [ aCurrentParent := nil ]
		ifTrue: [ aCurrentParent := aCurrentParent parentPharoPackageViewsCoderViewModel ].
	
	aCurrentParent
		ifNotNil: [
			aParentFound := true.
			aCurrentParent topMostParentsWithSelectionDo: aBlock ].
	
	
	"there is no assigned parent, meaning I am the topmost"
	aParentFound
		ifFalse: [ aBlock value: self ].
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> unsetPhlowView [
	<propertyUnsetter: #phlowView>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousPhlowView |

	self hasPhlowView
		ifFalse: [ ^ self ].

	aPreviousPhlowView := phlowView.
	phlowView := nil.
	self onPreviousPhlowViewUnset: aPreviousPhlowView.
	self notifyPhlowViewChanged
]

{ #category : #'api - announcer' }
Gt2PharoPackageViewCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - phlow view' }
Gt2PharoPackageViewCoderViewModel >> unsubscribeFromPhlowView [
	"Is sent before a new phlowView is assigned to the receiver.
	Objects that subscribe to phlowView are required to implement this method."
	<modelUnsubscriber: #phlowView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoPackageViewCoderViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackageViewCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
