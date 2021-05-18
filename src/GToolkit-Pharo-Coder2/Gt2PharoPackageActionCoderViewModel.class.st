Class {
	#name : #Gt2PharoPackageActionCoderViewModel,
	#superclass : #Object,
	#instVars : [
		'expanded',
		'parentPharoPackageActionsCoderViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - View Models'
}

{ #category : #'api - announcer' }
Gt2PharoPackageActionCoderViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackageActionsCoderViewModel
		ifTrue: [ self parentPharoPackageActionsCoderViewModel announce: anAnnouncement ].
]

{ #category : #'api - expanded' }
Gt2PharoPackageActionCoderViewModel >> expanded [
	<return: #Object>
	<propertyGetter: #expanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ expanded
]

{ #category : #'api - expanded' }
Gt2PharoPackageActionCoderViewModel >> expanded: aNewExpanded [
	<propertySetter: #expanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasExpanded
		and: [ self expanded = aNewExpanded ])
			ifTrue: [ ^ self ].
	
	self hasExpanded
		ifTrue: [
			| aPreviousExpanded |
			aPreviousExpanded := expanded.
			expanded := nil.
			self onPreviousExpandedUnset: aPreviousExpanded ].
	expanded := aNewExpanded.
	self onNewExpandedSet: aNewExpanded.
	self notifyExpandedChanged
]

{ #category : #'api - expanded' }
Gt2PharoPackageActionCoderViewModel >> hasExpanded [
	<return: #Boolean>
	<propertyTester: #expanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ expanded notNil
]

{ #category : #'api - testing' }
Gt2PharoPackageActionCoderViewModel >> hasParentPharoPackageActionsCoderViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #packageActions>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackageActionsCoderViewModel notNil
]

{ #category : #'api - expanded' }
Gt2PharoPackageActionCoderViewModel >> notifyExpandedChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #expanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>

	self announce: Gt2PharoPackageActionCoderViewModelExpandedChanged new
]

{ #category : #'api - accessing' }
Gt2PharoPackageActionCoderViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #packageAction
]

{ #category : #'api - expanded' }
Gt2PharoPackageActionCoderViewModel >> onNewExpandedSet: aNewExpanded [
	"Is sent after a new value of the expanded is assigned"
	<propertySetHook: #expanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - expanded' }
Gt2PharoPackageActionCoderViewModel >> onPreviousExpandedUnset: aPreviousExpanded [
	"Is sent after a previous value of the expanded is de-assigned"
	<propertyUnsetHook: #expanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoPackageActionCoderViewModel >> parentPharoPackageActionsCoderViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoPackageActionsCoderViewModel>
	<parentObjectGetter: #packageActions>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoPackageActionsCoderViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoPackageActionsCoderViewModel
]

{ #category : #'api - accessing' }
Gt2PharoPackageActionCoderViewModel >> parentPharoPackageActionsCoderViewModel: aGt2PharoPackageActionsCoderViewModel [
	"Assign a parent object (${class:Gt2PharoPackageActionsCoderViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #packageActions>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoPackageActionsCoderViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackageActionsCoderViewModel := aGt2PharoPackageActionsCoderViewModel
]

{ #category : #printing }
Gt2PharoPackageActionCoderViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	super printOn: aStream
]

{ #category : #'api - expanded' }
Gt2PharoPackageActionCoderViewModel >> unsetExpanded [
	<propertyUnsetter: #expanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousExpanded |

	self hasExpanded
		ifFalse: [ ^ self ].

	aPreviousExpanded := expanded.
	expanded := nil.
	self onPreviousExpandedUnset: aPreviousExpanded.
	self notifyExpandedChanged
]

{ #category : #'api - announcer' }
Gt2PharoPackageActionCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoPackageActionCoderViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackageActionCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
