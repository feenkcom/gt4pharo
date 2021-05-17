Class {
	#name : #Gt2PharoTagCoder,
	#superclass : #Object,
	#instVars : [
		'pharoTag',
		'pharoBehaviorsCoder',
		'parentPharoTagsCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - announcer' }
Gt2PharoTagCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoTagsCoder
		ifTrue: [ self parentPharoTagsCoder announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoTagCoder >> createPharoBehaviorsCoder [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #Gt2PharoBehaviorsCoder>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := Gt2PharoBehaviorsCoder new.
	childObject parentPharoTagCoder: self.
	childObject pharoBehaviorCoders: self pharoTag behaviors.
	^ childObject
]

{ #category : #'gt-extentions' }
Gt2PharoTagCoder >> gtBehaviorsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'Behaviors';
		items: [ self pharoBehaviorsCoder pharoBehaviorCoders ]
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> hasParentPharoTagsCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #tags>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoTagsCoder notNil
]

{ #category : #'api - pharo tag' }
Gt2PharoTagCoder >> hasPharoTag [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #pharoTag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoTag notNil
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoTagCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - pharo tag' }
Gt2PharoTagCoder >> onPharoTagChanged [
	"Is sent when a new pharoTag is assigned to the receiver.
	Note: #onPharoTagChanged is sent before #subscribeToPharoTag
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo tag' }
Gt2PharoTagCoder >> onPostPharoTagChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTag.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoTagCoder >> parentPharoTagsCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoTagsCoder>
	<parentObjectGetter: #tags>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoTagsCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoTagsCoder
]

{ #category : #'api - accessing' }
Gt2PharoTagCoder >> parentPharoTagsCoder: aGt2PharoTagsCoder [
	"Assign a parent object (${class:Gt2PharoTagsCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #tags>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoTagsCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoTagsCoder := aGt2PharoTagsCoder
]

{ #category : #'api - accessing' }
Gt2PharoTagCoder >> pharoBehaviorsCoder [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #Gt2PharoBehaviorsCoder>
	<childObjectGetter: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ pharoBehaviorsCoder ifNil: [ pharoBehaviorsCoder := self createPharoBehaviorsCoder ]
]

{ #category : #'api - pharo tag' }
Gt2PharoTagCoder >> pharoTag [
	"Return a not-null pharoTag assigned to the receiver"
	<modelGetter: #pharoTag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoTag notNil ]
		description: [ 'pharoTag should be initialized' ].

	^ pharoTag
]

{ #category : #'api - pharo tag' }
Gt2PharoTagCoder >> pharoTag: aPharoTag [
	"Set a not-null pharoTag assigned to the receiver"
	<modelSetter: #pharoTag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoTag notNil ]
		description: [ 'pharoTag must not be nil' ].

	pharoTag == aPharoTag
		ifTrue: [ ^ self ].

	pharoTag ifNotNil: [ self unsubscribeFromPharoTag ].
	pharoTag := aPharoTag.

	self onPharoTagChanged.
	self subscribeToPharoTag.
	self onPostPharoTagChanged
]

{ #category : #printing }
Gt2PharoTagCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoTag
]

{ #category : #'api - pharo tag' }
Gt2PharoTagCoder >> subscribeToPharoTag [
	"Is sent after a new pharoTag is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTag if the receiver subscribes to them"
	<modelSubscriber: #pharoTag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoTagCoder >> tagName [
	^ self pharoTag name
]

{ #category : #'api - announcer' }
Gt2PharoTagCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo tag' }
Gt2PharoTagCoder >> unsubscribeFromPharoTag [
	"Is sent before a new pharoTag is assigned to the receiver.
	Objects that subscribe to pharoTag are required to implement this method."
	<modelUnsubscriber: #pharoTag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoTagCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoTagCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
