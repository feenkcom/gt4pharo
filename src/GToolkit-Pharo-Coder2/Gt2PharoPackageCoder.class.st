Class {
	#name : #Gt2PharoPackageCoder,
	#superclass : #Object,
	#instVars : [
		'pharoPackage',
		'pharoTagsCoder',
		'parentPharoPackagesCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - announcer' }
Gt2PharoPackageCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackagesCoder
		ifTrue: [ self parentPharoPackagesCoder announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoPackageCoder >> createPharoTagsCoder [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #Gt2PharoTagsCoder>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := Gt2PharoTagsCoder new.
	childObject parentPharoPackageCoder: self.
	childObject pharoTags: self pharoPackage tags.
	^ childObject
]

{ #category : #'gt-extentions' }
Gt2PharoPackageCoder >> gtTagsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'Tags';
		items: [ self pharoTagsCoder pharoTagCoders ]
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> hasParentPharoPackagesCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackagesCoder notNil
]

{ #category : #'api - pharo package' }
Gt2PharoPackageCoder >> hasPharoPackage [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #pharoPackage>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackage notNil
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackageCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - pharo package' }
Gt2PharoPackageCoder >> onPharoPackageChanged [
	"Is sent when a new pharoPackage is assigned to the receiver.
	Note: #onPharoPackageChanged is sent before #subscribeToPharoPackage
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo package' }
Gt2PharoPackageCoder >> onPostPharoPackageChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackage.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoder >> packageName [
	self pharoPackage packageNameDo: [ :aPackageName | ^ aPackageName ].
	^ 'unspecified'
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoder >> parentPharoPackagesCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoPackagesCoder>
	<parentObjectGetter: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoPackagesCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoPackagesCoder
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoder >> parentPharoPackagesCoder: aGt2PharoPackagesCoder [
	"Assign a parent object (${class:Gt2PharoPackagesCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoPackagesCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackagesCoder := aGt2PharoPackagesCoder
]

{ #category : #'api - pharo package' }
Gt2PharoPackageCoder >> pharoPackage [
	"Return a not-null pharoPackage assigned to the receiver"
	<modelGetter: #pharoPackage>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackage notNil ]
		description: [ 'pharoPackage should be initialized' ].

	^ pharoPackage
]

{ #category : #'api - pharo package' }
Gt2PharoPackageCoder >> pharoPackage: aPharoPackage [
	"Set a not-null pharoPackage assigned to the receiver"
	<modelSetter: #pharoPackage>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackage notNil ]
		description: [ 'pharoPackage must not be nil' ].

	pharoPackage == aPharoPackage
		ifTrue: [ ^ self ].

	pharoPackage ifNotNil: [ self unsubscribeFromPharoPackage ].
	pharoPackage := aPharoPackage.

	self onPharoPackageChanged.
	self subscribeToPharoPackage.
	self onPostPharoPackageChanged
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoder >> pharoTagsCoder [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #Gt2PharoTagsCoder>
	<childObjectGetter: #tags>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ pharoTagsCoder ifNil: [ pharoTagsCoder := self createPharoTagsCoder ]
]

{ #category : #printing }
Gt2PharoPackageCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoPackage
]

{ #category : #'api - pharo package' }
Gt2PharoPackageCoder >> subscribeToPharoPackage [
	"Is sent after a new pharoPackage is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackage if the receiver subscribes to them"
	<modelSubscriber: #pharoPackage>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo package' }
Gt2PharoPackageCoder >> unsubscribeFromPharoPackage [
	"Is sent before a new pharoPackage is assigned to the receiver.
	Objects that subscribe to pharoPackage are required to implement this method."
	<modelUnsubscriber: #pharoPackage>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
