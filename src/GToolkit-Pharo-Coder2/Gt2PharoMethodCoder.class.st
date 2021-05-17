Class {
	#name : #Gt2PharoMethodCoder,
	#superclass : #Object,
	#instVars : [
		'pharoMethod',
		'parentPharoMethodsCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - announcer' }
Gt2PharoMethodCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoMethodsCoder
		ifTrue: [ self parentPharoMethodsCoder announce: anAnnouncement ].
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> hasParentPharoMethodsCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #methods>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoMethodsCoder notNil
]

{ #category : #'api - pharo method' }
Gt2PharoMethodCoder >> hasPharoMethod [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #pharoMethod>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoMethod notNil
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - pharo method' }
Gt2PharoMethodCoder >> onPharoMethodChanged [
	"Is sent when a new pharoMethod is assigned to the receiver.
	Note: #onPharoMethodChanged is sent before #subscribeToPharoMethod
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoMethodChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo method' }
Gt2PharoMethodCoder >> onPostPharoMethodChanged [
	"I am an optional hook method that is sent after #subscribeToPharoMethod.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoMethodCoder >> parentPharoMethodsCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoMethodsCoder>
	<parentObjectGetter: #methods>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoMethodsCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoMethodsCoder
]

{ #category : #'api - accessing' }
Gt2PharoMethodCoder >> parentPharoMethodsCoder: aGt2PharoMethodsCoder [
	"Assign a parent object (${class:Gt2PharoMethodsCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #methods>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoMethodsCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoMethodsCoder := aGt2PharoMethodsCoder
]

{ #category : #'api - pharo method' }
Gt2PharoMethodCoder >> pharoMethod [
	"Return a not-null pharoMethod assigned to the receiver"
	<modelGetter: #pharoMethod>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoMethod notNil ]
		description: [ 'pharoMethod should be initialized' ].

	^ pharoMethod
]

{ #category : #'api - pharo method' }
Gt2PharoMethodCoder >> pharoMethod: aPharoMethod [
	"Set a not-null pharoMethod assigned to the receiver"
	<modelSetter: #pharoMethod>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoMethod notNil ]
		description: [ 'pharoMethod must not be nil' ].

	pharoMethod == aPharoMethod
		ifTrue: [ ^ self ].

	pharoMethod ifNotNil: [ self unsubscribeFromPharoMethod ].
	pharoMethod := aPharoMethod.

	self onPharoMethodChanged.
	self subscribeToPharoMethod.
	self onPostPharoMethodChanged
]

{ #category : #printing }
Gt2PharoMethodCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoMethod
]

{ #category : #'api - pharo method' }
Gt2PharoMethodCoder >> subscribeToPharoMethod [
	"Is sent after a new pharoMethod is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoMethod if the receiver subscribes to them"
	<modelSubscriber: #pharoMethod>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoMethodCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo method' }
Gt2PharoMethodCoder >> unsubscribeFromPharoMethod [
	"Is sent before a new pharoMethod is assigned to the receiver.
	Objects that subscribe to pharoMethod are required to implement this method."
	<modelUnsubscriber: #pharoMethod>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoMethodCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoMethodCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
