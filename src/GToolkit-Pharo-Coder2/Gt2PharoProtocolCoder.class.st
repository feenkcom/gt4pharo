Class {
	#name : #Gt2PharoProtocolCoder,
	#superclass : #Object,
	#instVars : [
		'pharoProtocol',
		'pharoMethodsCoder',
		'parentPharoProtocolsCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - announcer' }
Gt2PharoProtocolCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoProtocolsCoder
		ifTrue: [ self parentPharoProtocolsCoder announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoProtocolCoder >> createPharoMethodsCoder [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #Gt2PharoMethodsCoder>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := Gt2PharoMethodsCoder new.
	childObject parentPharoProtocolCoder: self.
	childObject pharoMethodCoders: self pharoProtocol meth.
	^ childObject
]

{ #category : #'gt-extentions' }
Gt2PharoProtocolCoder >> gtMethodsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'Methods';
		items: [ self pharoMethodsCoder pharoMethodCoders ]
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> hasParentPharoProtocolsCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #protocols>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoProtocolsCoder notNil
]

{ #category : #'api - pharo protocol' }
Gt2PharoProtocolCoder >> hasPharoProtocol [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #pharoProtocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoProtocol notNil
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - pharo protocol' }
Gt2PharoProtocolCoder >> onPharoProtocolChanged [
	"Is sent when a new pharoProtocol is assigned to the receiver.
	Note: #onPharoProtocolChanged is sent before #subscribeToPharoProtocol
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoProtocolChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo protocol' }
Gt2PharoProtocolCoder >> onPostPharoProtocolChanged [
	"I am an optional hook method that is sent after #subscribeToPharoProtocol.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoProtocolCoder >> parentPharoProtocolsCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoProtocolsCoder>
	<parentObjectGetter: #protocols>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoProtocolsCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoProtocolsCoder
]

{ #category : #'api - accessing' }
Gt2PharoProtocolCoder >> parentPharoProtocolsCoder: aGt2PharoProtocolsCoder [
	"Assign a parent object (${class:Gt2PharoProtocolsCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #protocols>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoProtocolsCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoProtocolsCoder := aGt2PharoProtocolsCoder
]

{ #category : #'api - accessing' }
Gt2PharoProtocolCoder >> pharoMethodsCoder [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #Gt2PharoMethodsCoder>
	<childObjectGetter: #methods>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ pharoMethodsCoder ifNil: [ pharoMethodsCoder := self createPharoMethodsCoder ]
]

{ #category : #'api - pharo protocol' }
Gt2PharoProtocolCoder >> pharoProtocol [
	"Return a not-null pharoProtocol assigned to the receiver"
	<modelGetter: #pharoProtocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoProtocol notNil ]
		description: [ 'pharoProtocol should be initialized' ].

	^ pharoProtocol
]

{ #category : #'api - pharo protocol' }
Gt2PharoProtocolCoder >> pharoProtocol: aPharoProtocol [
	"Set a not-null pharoProtocol assigned to the receiver"
	<modelSetter: #pharoProtocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoProtocol notNil ]
		description: [ 'pharoProtocol must not be nil' ].

	pharoProtocol == aPharoProtocol
		ifTrue: [ ^ self ].

	pharoProtocol ifNotNil: [ self unsubscribeFromPharoProtocol ].
	pharoProtocol := aPharoProtocol.

	self onPharoProtocolChanged.
	self subscribeToPharoProtocol.
	self onPostPharoProtocolChanged
]

{ #category : #printing }
Gt2PharoProtocolCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoProtocol
]

{ #category : #'api - pharo protocol' }
Gt2PharoProtocolCoder >> subscribeToPharoProtocol [
	"Is sent after a new pharoProtocol is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoProtocol if the receiver subscribes to them"
	<modelSubscriber: #pharoProtocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoProtocolCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo protocol' }
Gt2PharoProtocolCoder >> unsubscribeFromPharoProtocol [
	"Is sent before a new pharoProtocol is assigned to the receiver.
	Objects that subscribe to pharoProtocol are required to implement this method."
	<modelUnsubscriber: #pharoProtocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoProtocolCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoProtocolCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
