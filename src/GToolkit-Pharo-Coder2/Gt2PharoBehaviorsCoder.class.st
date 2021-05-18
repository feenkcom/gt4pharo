Class {
	#name : #Gt2PharoBehaviorsCoder,
	#superclass : #Object,
	#instVars : [
		'pharoBehaviorCoders',
		'parentPharoTagCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - adding' }
Gt2PharoBehaviorsCoder >> addPharoBehaviorCoder: aPharoBehaviorCoder [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesPharoBehaviorCoders: aPharoBehaviorCoder)
		ifTrue: [ ^ self ].
	
	self primitiveAddPharoBehaviorCoder: aPharoBehaviorCoder.
	self pharoBehaviorCoders add: aPharoBehaviorCoder.
	self onPharoBehaviorCoderAdded: aPharoBehaviorCoder
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorsCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoTagCoder
		ifTrue: [ self parentPharoTagCoder announce: anAnnouncement ].
]

{ #category : #'gt-extentions' }
Gt2PharoBehaviorsCoder >> gtBehaviorListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Behavior';
		items: [ self pharoBehaviorCoders ]
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> hasParentPharoTagCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoTagCoder notNil
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> includesPharoBehaviorCoders: aPharoBehaviorCoders [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#includesObjectTemplate'>

	^ self pharoBehaviorCoders anySatisfy: [ :eachPharoBehaviorCoders |
		eachPharoBehaviorCoders == aPharoBehaviorCoders ]
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoBehaviorsCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'private - notifying' }
Gt2PharoBehaviorsCoder >> notifyPharoBehaviorCoderAdded: aPharoBehaviorCoder [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoBehaviorCoderAddedAnnouncement new
		pharoBehaviorCoder: aPharoBehaviorCoder) 
]

{ #category : #'private - notifying' }
Gt2PharoBehaviorsCoder >> notifyPharoBehaviorCoderRemoved: aPharoBehaviorCoder [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoBehaviorCoderRemovedAnnouncement new
		pharoBehaviorCoder: aPharoBehaviorCoder) 
]

{ #category : #'api - adding' }
Gt2PharoBehaviorsCoder >> onPharoBehaviorCoderAdded: aPharoBehaviorCoder [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoBehaviorCoder parentPharoBehaviorsCoder: self.
	self notifyPharoBehaviorCoderAdded: aPharoBehaviorCoder.
]

{ #category : #'api - adding' }
Gt2PharoBehaviorsCoder >> onPharoBehaviorCoderRemoved: aPharoBehaviorCoder [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoBehaviorCoderRemoved: aPharoBehaviorCoder.
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoder >> parentPharoTagCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoTagCoder>
	<parentObjectGetter: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoTagCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoTagCoder
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoder >> parentPharoTagCoder: aGt2PharoTagCoder [
	"Assign a parent object (${class:Gt2PharoTagCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoTagCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoTagCoder := aGt2PharoTagCoder
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoder >> pharoBehaviorCoders [
	"Return a collection of objects (${class:Gt2PharoBehaviorCoder}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoBehaviorCoder>
	<childObjectGetter: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsGetterTemplate'>

	^  pharoBehaviorCoders ifNil: [ pharoBehaviorCoders := OrderedCollection new ]
]

{ #category : #'api - accessing' }
Gt2PharoBehaviorsCoder >> pharoBehaviorCoders: aCollectionOfGt2PharoBehaviorCoder [
	"Silently assign a collection of given objects as my children without triggering any event. This is part of the #initialization protocol."
	<modelSetter: #behaviors>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsSetterTemplate'>
	
	pharoBehaviorCoders := aCollectionOfGt2PharoBehaviorCoder asOrderedCollection.
	pharoBehaviorCoders do: [ :eachGt2PharoBehaviorCoder |
		eachGt2PharoBehaviorCoder parentPharoBehaviorsCoder: self ]
]

{ #category : #'private - adding' }
Gt2PharoBehaviorsCoder >> primitiveAddPharoBehaviorCoder: aPharoBehaviorCoder [
	"Is sent right before adding aPharoBehaviorCoder as my child.
	Override this method to implement primitive addition behavior such as for example adding a new folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#primitiveAddTemplate'>
]

{ #category : #'private - removing' }
Gt2PharoBehaviorsCoder >> primitiveRemovePharoBehaviorCoder: aPharoBehaviorCoder [
	"Is sent right before removing aPharoBehaviorCoder from my children.
	Override this method to implement primitive removal behavior such as for example removing a folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#primitiveRemoveTemplate'>
]

{ #category : #printing }
Gt2PharoBehaviorsCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	super printOn: aStream
]

{ #category : #'api - adding' }
Gt2PharoBehaviorsCoder >> removePharoBehaviorCoder: aPharoBehaviorCoder [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #behavior>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesPharoBehaviorCoders: aPharoBehaviorCoder)
		ifFalse: [ ^ self ].
	
	self primitiveRemovePharoBehaviorCoder: aPharoBehaviorCoder.
	self pharoBehaviorCoders
		remove: aPharoBehaviorCoder
		ifAbsent: [ ^ self ].
	self onPharoBehaviorCoderRemoved: aPharoBehaviorCoder
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorsCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorsCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoBehaviorsCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
