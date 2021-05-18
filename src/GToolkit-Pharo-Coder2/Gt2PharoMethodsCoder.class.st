Class {
	#name : #Gt2PharoMethodsCoder,
	#superclass : #Object,
	#instVars : [
		'pharoMethodCoders',
		'parentPharoProtocolCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - adding' }
Gt2PharoMethodsCoder >> addPharoMethodCoder: aPharoMethodCoder [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #method>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesPharoMethodCoders: aPharoMethodCoder)
		ifTrue: [ ^ self ].
	
	self primitiveAddPharoMethodCoder: aPharoMethodCoder.
	self pharoMethodCoders add: aPharoMethodCoder.
	self onPharoMethodCoderAdded: aPharoMethodCoder
]

{ #category : #'api - announcer' }
Gt2PharoMethodsCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoProtocolCoder
		ifTrue: [ self parentPharoProtocolCoder announce: anAnnouncement ].
]

{ #category : #'gt-extentions' }
Gt2PharoMethodsCoder >> gtMethodListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Method';
		items: [ self pharoMethodCoders ]
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> hasParentPharoProtocolCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #protocol>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoProtocolCoder notNil
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> includesPharoMethodCoders: aPharoMethodCoders [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #method>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#includesObjectTemplate'>

	^ self pharoMethodCoders anySatisfy: [ :eachPharoMethodCoders |
		eachPharoMethodCoders == aPharoMethodCoders ]
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoMethodsCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'private - notifying' }
Gt2PharoMethodsCoder >> notifyPharoMethodCoderAdded: aPharoMethodCoder [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoMethodCoderAddedAnnouncement new
		pharoMethodCoder: aPharoMethodCoder) 
]

{ #category : #'private - notifying' }
Gt2PharoMethodsCoder >> notifyPharoMethodCoderRemoved: aPharoMethodCoder [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoMethodCoderRemovedAnnouncement new
		pharoMethodCoder: aPharoMethodCoder) 
]

{ #category : #'api - adding' }
Gt2PharoMethodsCoder >> onPharoMethodCoderAdded: aPharoMethodCoder [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoMethodCoder parentPharoMethodsCoder: self.
	self notifyPharoMethodCoderAdded: aPharoMethodCoder.
]

{ #category : #'api - adding' }
Gt2PharoMethodsCoder >> onPharoMethodCoderRemoved: aPharoMethodCoder [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoMethodCoderRemoved: aPharoMethodCoder.
]

{ #category : #'api - accessing' }
Gt2PharoMethodsCoder >> parentPharoProtocolCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoProtocolCoder>
	<parentObjectGetter: #protocol>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoProtocolCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoProtocolCoder
]

{ #category : #'api - accessing' }
Gt2PharoMethodsCoder >> parentPharoProtocolCoder: aGt2PharoProtocolCoder [
	"Assign a parent object (${class:Gt2PharoProtocolCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #protocol>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoProtocolCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoProtocolCoder := aGt2PharoProtocolCoder
]

{ #category : #'api - accessing' }
Gt2PharoMethodsCoder >> pharoMethodCoders [
	"Return a collection of objects (${class:Gt2PharoMethodCoder}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoMethodCoder>
	<childObjectGetter: #method>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsGetterTemplate'>

	^  pharoMethodCoders ifNil: [ pharoMethodCoders := OrderedCollection new ]
]

{ #category : #'api - accessing' }
Gt2PharoMethodsCoder >> pharoMethodCoders: aCollectionOfGt2PharoMethodCoder [
	"Silently assign a collection of given objects as my children without triggering any event. This is part of the #initialization protocol."
	<modelSetter: #methods>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsSetterTemplate'>
	
	pharoMethodCoders := aCollectionOfGt2PharoMethodCoder asOrderedCollection.
	pharoMethodCoders do: [ :eachGt2PharoMethodCoder |
		eachGt2PharoMethodCoder parentPharoMethodsCoder: self ]
]

{ #category : #'private - adding' }
Gt2PharoMethodsCoder >> primitiveAddPharoMethodCoder: aPharoMethodCoder [
	"Is sent right before adding aPharoMethodCoder as my child.
	Override this method to implement primitive addition behavior such as for example adding a new folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#primitiveAddTemplate'>
]

{ #category : #'private - removing' }
Gt2PharoMethodsCoder >> primitiveRemovePharoMethodCoder: aPharoMethodCoder [
	"Is sent right before removing aPharoMethodCoder from my children.
	Override this method to implement primitive removal behavior such as for example removing a folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#primitiveRemoveTemplate'>
]

{ #category : #printing }
Gt2PharoMethodsCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	super printOn: aStream
]

{ #category : #'api - adding' }
Gt2PharoMethodsCoder >> removePharoMethodCoder: aPharoMethodCoder [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #method>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesPharoMethodCoders: aPharoMethodCoder)
		ifFalse: [ ^ self ].
	
	self primitiveRemovePharoMethodCoder: aPharoMethodCoder.
	self pharoMethodCoders
		remove: aPharoMethodCoder
		ifAbsent: [ ^ self ].
	self onPharoMethodCoderRemoved: aPharoMethodCoder
]

{ #category : #'api - announcer' }
Gt2PharoMethodsCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoMethodsCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoMethodsCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
