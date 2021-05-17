Class {
	#name : #Gt2PharoTagsCoder,
	#superclass : #Object,
	#instVars : [
		'pharoTags',
		'pharoTagCoders',
		'parentPharoPackageCoder',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - adding' }
Gt2PharoTagsCoder >> addPharoTagCoder: aPharoTagCoder [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesPharoTagCoders: aPharoTagCoder)
		ifTrue: [ ^ self ].
	
	self primitiveAddPharoTagCoder: aPharoTagCoder.
	self pharoTagCoders add: aPharoTagCoder.
	self onPharoTagCoderAdded: aPharoTagCoder
]

{ #category : #'api - announcer' }
Gt2PharoTagsCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackageCoder
		ifTrue: [ self parentPharoPackageCoder announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoTagsCoder >> createPharoTagCoders [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #Gt2PharoTagCoder>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self pharoTags yourself collect: [ :eachModel |
		self createPharoTagCodersFor: eachModel ] as: OrderedCollection
]

{ #category : #'private - instance creation' }
Gt2PharoTagsCoder >> createPharoTagCodersFor: aChildModel [
	<return: #Gt2PharoTagCoder>
	<childObjectCreator: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := Gt2PharoTagCoder new.
	aNewChild parentPharoTagsCoder: self.
	aNewChild pharoTag: aChildModel.
	^ aNewChild
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoder >> findPharoTagCoders: aTag [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #Gt2PharoTagCoder or: nil>
	<childObjectDetector: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findPharoTagCoders: aTag
		ifFound: [ :aPharoTagCoders | aPharoTagCoders ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoder >> findPharoTagCoders: aTag ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self pharoTagCoders
		detect: [ :eachPharoTagCoders |
			eachPharoTagCoders pharoTag = aTag ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-extentions' }
Gt2PharoTagsCoder >> gtTagListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Tag';
		items: [ self pharoTagCoders ]
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> hasParentPharoPackageCoder [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackageCoder notNil
]

{ #category : #'api - pharo tags' }
Gt2PharoTagsCoder >> hasPharoTags [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #pharoTags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoTags notNil
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> includesPharoTagCoders: aPharoTagCoders [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self pharoTagCoders anySatisfy: [ :eachPharoTagCoders |
		eachPharoTagCoders == aPharoTagCoders ]
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'private - notifying' }
Gt2PharoTagsCoder >> notifyPharoTagCoderAdded: aPharoTagCoder [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoTagCoderAddedAnnouncement new
		pharoTagCoder: aPharoTagCoder) 
]

{ #category : #'private - notifying' }
Gt2PharoTagsCoder >> notifyPharoTagCoderRemoved: aPharoTagCoder [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoTagCoderRemovedAnnouncement new
		pharoTagCoder: aPharoTagCoder) 
]

{ #category : #'api - adding' }
Gt2PharoTagsCoder >> onPharoTagCoderAdded: aPharoTagCoder [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoTagCoder parentPharoTagsCoder: self.
	self notifyPharoTagCoderAdded: aPharoTagCoder.
]

{ #category : #'api - adding' }
Gt2PharoTagsCoder >> onPharoTagCoderRemoved: aPharoTagCoder [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoTagCoderRemoved: aPharoTagCoder.
]

{ #category : #'api - pharo tags' }
Gt2PharoTagsCoder >> onPharoTagsChanged [
	"Is sent when a new pharoTags is assigned to the receiver.
	Note: #onPharoTagsChanged is sent before #subscribeToPharoTags
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagsChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo tags' }
Gt2PharoTagsCoder >> onPostPharoTagsChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTags.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoder >> parentPharoPackageCoder [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoPackageCoder>
	<parentObjectGetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoPackageCoder notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoPackageCoder
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoder >> parentPharoPackageCoder: aGt2PharoPackageCoder [
	"Assign a parent object (${class:Gt2PharoPackageCoder}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoPackageCoder notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackageCoder := aGt2PharoPackageCoder
]

{ #category : #'api - accessing' }
Gt2PharoTagsCoder >> pharoTagCoders [
	"Return a collection of objects (${class:Gt2PharoTagCoder}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoTagCoder>
	<childObjectGetter: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  pharoTagCoders ifNil: [ pharoTagCoders := self createPharoTagCoders ]
]

{ #category : #'api - pharo tags' }
Gt2PharoTagsCoder >> pharoTags [
	"Return a not-null pharoTags assigned to the receiver"
	<modelGetter: #pharoTags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoTags notNil ]
		description: [ 'pharoTags should be initialized' ].

	^ pharoTags
]

{ #category : #'api - pharo tags' }
Gt2PharoTagsCoder >> pharoTags: aPharoTags [
	"Set a not-null pharoTags assigned to the receiver"
	<modelSetter: #pharoTags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoTags notNil ]
		description: [ 'pharoTags must not be nil' ].

	pharoTags == aPharoTags
		ifTrue: [ ^ self ].

	pharoTags ifNotNil: [ self unsubscribeFromPharoTags ].
	pharoTags := aPharoTags.

	self onPharoTagsChanged.
	self subscribeToPharoTags.
	self onPostPharoTagsChanged
]

{ #category : #'private - adding' }
Gt2PharoTagsCoder >> primitiveAddPharoTagCoder: aPharoTagCoder [
	"Is sent right before adding aPharoTagCoder as my child.
	Override this method to implement primitive addition behavior such as for example adding a new folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#primitiveAddTemplate'>
]

{ #category : #'private - removing' }
Gt2PharoTagsCoder >> primitiveRemovePharoTagCoder: aPharoTagCoder [
	"Is sent right before removing aPharoTagCoder from my children.
	Override this method to implement primitive removal behavior such as for example removing a folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#primitiveRemoveTemplate'>
]

{ #category : #printing }
Gt2PharoTagsCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoTags
]

{ #category : #'api - adding' }
Gt2PharoTagsCoder >> removePharoTagCoder: aPharoTagCoder [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #tag>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesPharoTagCoders: aPharoTagCoder)
		ifFalse: [ ^ self ].
	
	self primitiveRemovePharoTagCoder: aPharoTagCoder.
	self pharoTagCoders
		remove: aPharoTagCoder
		ifAbsent: [ ^ self ].
	self onPharoTagCoderRemoved: aPharoTagCoder
]

{ #category : #'api - pharo tags' }
Gt2PharoTagsCoder >> subscribeToPharoTags [
	"Is sent after a new pharoTags is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTags if the receiver subscribes to them"
	<modelSubscriber: #pharoTags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoTagsCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo tags' }
Gt2PharoTagsCoder >> unsubscribeFromPharoTags [
	"Is sent before a new pharoTags is assigned to the receiver.
	Objects that subscribe to pharoTags are required to implement this method."
	<modelUnsubscriber: #pharoTags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoTagsCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoTagsCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
