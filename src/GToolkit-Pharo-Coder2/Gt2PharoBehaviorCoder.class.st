Class {
	#name : #Gt2PharoBehaviorCoder,
	#superclass : #Object,
	#instVars : [
		'pharoBehavior',
		'pharoProtocolsCoder',
		'parentPharoBehaviorsCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - announcer' }
Gt2PharoBehaviorCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoBehaviorsCoder
		ifTrue: [ self parentPharoBehaviorsCoder announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoBehaviorCoder >> createPharoProtocolsCoder [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #Gt2PharoProtocolsCoder>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := Gt2PharoProtocolsCoder new.
	childObject parentPharoBehaviorCoder: self.
	childObject pharoProtocolCoders: self pharoBehavior protocols.
	^ childObject
]

{ #category : #'gt-extentions' }
Gt2PharoBehaviorCoder >> gtProtocolsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'Protocols';
		items: [ self pharoProtocolsCoder pharoProtocolCoders ]
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> hasParentPharoBehaviorsCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoBehaviorsCoder notNil
]

{ #category : #'api - pharo behavior' }
Gt2PharoBehaviorCoder >> hasPharoBehavior [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #pharoBehavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoBehavior notNil
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - pharo behavior' }
Gt2PharoBehaviorCoder >> onPharoBehaviorChanged [
	"Is sent when a new pharoBehavior is assigned to the receiver.
	Note: #onPharoBehaviorChanged is sent before #subscribeToPharoBehavior
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo behavior' }
Gt2PharoBehaviorCoder >> onPostPharoBehaviorChanged [
	"I am an optional hook method that is sent after #subscribeToPharoBehavior.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorCoder >> parentPharoBehaviorsCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoBehaviorsCoder>
	<parentObjectGetter: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoBehaviorsCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoBehaviorsCoder
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorCoder >> parentPharoBehaviorsCoder: aGt2PharoBehaviorsCoder [
	"Assign a parent object (${class:Gt2PharoBehaviorsCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoBehaviorsCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoBehaviorsCoder := aGt2PharoBehaviorsCoder
]

{ #category : #'api - pharo behavior' }
Gt2PharoBehaviorCoder >> pharoBehavior [
	"Return a not-null pharoBehavior assigned to the receiver"
	<modelGetter: #pharoBehavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoBehavior notNil ]
		description: [ 'pharoBehavior should be initialized' ].

	^ pharoBehavior
]

{ #category : #'api - pharo behavior' }
Gt2PharoBehaviorCoder >> pharoBehavior: aPharoBehavior [
	"Set a not-null pharoBehavior assigned to the receiver"
	<modelSetter: #pharoBehavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoBehavior notNil ]
		description: [ 'pharoBehavior must not be nil' ].

	pharoBehavior == aPharoBehavior
		ifTrue: [ ^ self ].

	pharoBehavior ifNotNil: [ self unsubscribeFromPharoBehavior ].
	pharoBehavior := aPharoBehavior.

	self onPharoBehaviorChanged.
	self subscribeToPharoBehavior.
	self onPostPharoBehaviorChanged
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorCoder >> pharoProtocolsCoder [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #Gt2PharoProtocolsCoder>
	<childObjectGetter: #protocols>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ pharoProtocolsCoder ifNil: [ pharoProtocolsCoder := self createPharoProtocolsCoder ]
]

{ #category : #printing }
Gt2PharoBehaviorCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoBehavior
]

{ #category : #'api - pharo behavior' }
Gt2PharoBehaviorCoder >> subscribeToPharoBehavior [
	"Is sent after a new pharoBehavior is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoBehavior if the receiver subscribes to them"
	<modelSubscriber: #pharoBehavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo behavior' }
Gt2PharoBehaviorCoder >> unsubscribeFromPharoBehavior [
	"Is sent before a new pharoBehavior is assigned to the receiver.
	Objects that subscribe to pharoBehavior are required to implement this method."
	<modelUnsubscriber: #pharoBehavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
