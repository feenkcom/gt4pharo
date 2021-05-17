Class {
	#name : #Gt2PharoProtocolsCoder,
	#superclass : #Object,
	#instVars : [
		'pharoProtocolCoders',
		'parentPharoBehaviorCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - adding' }
Gt2PharoProtocolsCoder >> addPharoProtocolCoder: aPharoProtocolCoder [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #protocol>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesPharoProtocolCoders: aPharoProtocolCoder)
		ifTrue: [ ^ self ].
	
	self primitiveAddPharoProtocolCoder: aPharoProtocolCoder.
	self pharoProtocolCoders add: aPharoProtocolCoder.
	self onPharoProtocolCoderAdded: aPharoProtocolCoder
]

{ #category : #'api - announcer' }
Gt2PharoProtocolsCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoBehaviorCoder
		ifTrue: [ self parentPharoBehaviorCoder announce: anAnnouncement ].
]

{ #category : #'gt-extentions' }
Gt2PharoProtocolsCoder >> gtProtocolListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Protocol';
		items: [ self pharoProtocolCoders ]
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> hasParentPharoBehaviorCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoBehaviorCoder notNil
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> includesPharoProtocolCoders: aPharoProtocolCoders [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #protocol>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#includesObjectTemplate'>

	^ self pharoProtocolCoders anySatisfy: [ :eachPharoProtocolCoders |
		eachPharoProtocolCoders == aPharoProtocolCoders ]
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoProtocolsCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'private - notifying' }
Gt2PharoProtocolsCoder >> notifyPharoProtocolCoderAdded: aPharoProtocolCoder [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoProtocolCoderAddedAnnouncement new
		pharoProtocolCoder: aPharoProtocolCoder) 
]

{ #category : #'private - notifying' }
Gt2PharoProtocolsCoder >> notifyPharoProtocolCoderRemoved: aPharoProtocolCoder [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoProtocolCoderRemovedAnnouncement new
		pharoProtocolCoder: aPharoProtocolCoder) 
]

{ #category : #'api - adding' }
Gt2PharoProtocolsCoder >> onPharoProtocolCoderAdded: aPharoProtocolCoder [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoProtocolCoder parentPharoProtocolsCoder: self.
	self notifyPharoProtocolCoderAdded: aPharoProtocolCoder.
]

{ #category : #'api - adding' }
Gt2PharoProtocolsCoder >> onPharoProtocolCoderRemoved: aPharoProtocolCoder [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoProtocolCoderRemoved: aPharoProtocolCoder.
]

{ #category : #'api - accessing' }
Gt2PharoProtocolsCoder >> parentPharoBehaviorCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoBehaviorCoder>
	<parentObjectGetter: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoBehaviorCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoBehaviorCoder
]

{ #category : #'api - accessing' }
Gt2PharoProtocolsCoder >> parentPharoBehaviorCoder: aGt2PharoBehaviorCoder [
	"Assign a parent object (${class:Gt2PharoBehaviorCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoBehaviorCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoBehaviorCoder := aGt2PharoBehaviorCoder
]

{ #category : #'api - accessing' }
Gt2PharoProtocolsCoder >> pharoProtocolCoders [
	"Return a collection of objects (${class:Gt2PharoProtocolCoder}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoProtocolCoder>
	<childObjectGetter: #protocol>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsGetterTemplate'>

	^  pharoProtocolCoders ifNil: [ pharoProtocolCoders := OrderedCollection new ]
]

{ #category : #'api - accessing' }
Gt2PharoProtocolsCoder >> pharoProtocolCoders: aCollectionOfGt2PharoProtocolCoder [
	"Silently assign a collection of given objects as my children without triggering any event. This is part of the #initialization protocol."
	<modelSetter: #protocols>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsSetterTemplate'>
	
	pharoProtocolCoders := aCollectionOfGt2PharoProtocolCoder asOrderedCollection.
	pharoProtocolCoders do: [ :eachGt2PharoProtocolCoder |
		eachGt2PharoProtocolCoder parentPharoProtocolsCoder: self ]
]

{ #category : #'private - adding' }
Gt2PharoProtocolsCoder >> primitiveAddPharoProtocolCoder: aPharoProtocolCoder [
	"Is sent right before adding aPharoProtocolCoder as my child.
	Override this method to implement primitive addition behavior such as for example adding a new folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#primitiveAddTemplate'>
]

{ #category : #'private - removing' }
Gt2PharoProtocolsCoder >> primitiveRemovePharoProtocolCoder: aPharoProtocolCoder [
	"Is sent right before removing aPharoProtocolCoder from my children.
	Override this method to implement primitive removal behavior such as for example removing a folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#primitiveRemoveTemplate'>
]

{ #category : #printing }
Gt2PharoProtocolsCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	super printOn: aStream
]

{ #category : #'api - adding' }
Gt2PharoProtocolsCoder >> removePharoProtocolCoder: aPharoProtocolCoder [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #protocol>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesPharoProtocolCoders: aPharoProtocolCoder)
		ifFalse: [ ^ self ].
	
	self primitiveRemovePharoProtocolCoder: aPharoProtocolCoder.
	self pharoProtocolCoders
		remove: aPharoProtocolCoder
		ifAbsent: [ ^ self ].
	self onPharoProtocolCoderRemoved: aPharoProtocolCoder
]

{ #category : #'api - announcer' }
Gt2PharoProtocolsCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoProtocolsCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoProtocolsCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
