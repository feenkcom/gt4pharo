Class {
	#name : #Gt2PharoPackagesCoder,
	#superclass : #Object,
	#instVars : [
		'pharoPackages',
		'pharoPackageCoders',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Models'
}

{ #category : #'api - adding' }
Gt2PharoPackagesCoder >> addPharoPackageCoder: aPharoPackageCoder [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #package>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesPharoPackageCoders: aPharoPackageCoder)
		ifTrue: [ ^ self ].
	
	self primitiveAddPharoPackageCoder: aPharoPackageCoder.
	self pharoPackageCoders add: aPharoPackageCoder.
	self onPharoPackageCoderAdded: aPharoPackageCoder
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoder >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoPackagesCoder >> createPharoPackageCoders [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #Gt2PharoPackageCoder>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self pharoPackages yourself collect: [ :eachModel |
		self createPharoPackageCodersFor: eachModel ] as: OrderedCollection
]

{ #category : #'private - instance creation' }
Gt2PharoPackagesCoder >> createPharoPackageCodersFor: aChildModel [
	<return: #Gt2PharoPackageCoder>
	<childObjectCreator: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := Gt2PharoPackageCoder new.
	aNewChild parentPharoPackagesCoder: self.
	aNewChild pharoPackage: aChildModel.
	^ aNewChild
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoder >> findPharoPackageCoders: aPackage [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #Gt2PharoPackageCoder or: nil>
	<childObjectDetector: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findPharoPackageCoders: aPackage
		ifFound: [ :aPharoPackageCoders | aPharoPackageCoders ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoder >> findPharoPackageCoders: aPackage ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self pharoPackageCoders
		detect: [ :eachPharoPackageCoders |
			eachPharoPackageCoders pharoPackage = aPackage ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-extentions' }
Gt2PharoPackagesCoder >> gtPackageListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Package';
		items: [ self pharoPackageCoders ]
]

{ #category : #'api - pharo packages' }
Gt2PharoPackagesCoder >> hasPharoPackages [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #pharoPackages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackages notNil
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> includesPharoPackageCoders: aPharoPackageCoders [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self pharoPackageCoders anySatisfy: [ :eachPharoPackageCoders |
		eachPharoPackageCoders == aPharoPackageCoders ]
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoBehaviorCoder [
	"Return true if the receiver represents pharoBehaviorCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoBehaviorsCoder [
	"Return true if the receiver represents pharoBehaviorsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoMethodCoder [
	"Return true if the receiver represents pharoMethodCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoMethodsCoder [
	"Return true if the receiver represents pharoMethodsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoPackageCoder [
	"Return true if the receiver represents pharoPackageCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoPackagesCoder [
	"Return true if the receiver represents pharoPackagesCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoProtocolCoder [
	"Return true if the receiver represents pharoProtocolCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoProtocolsCoder [
	"Return true if the receiver represents pharoProtocolsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoTagCoder [
	"Return true if the receiver represents pharoTagCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoPackagesCoder >> isPharoTagsCoder [
	"Return true if the receiver represents pharoTagsCoder, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : #'private - notifying' }
Gt2PharoPackagesCoder >> notifyPharoPackageCoderAdded: aPharoPackageCoder [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (Gt2PharoPackageCoderAddedAnnouncement new
		pharoPackageCoder: aPharoPackageCoder) 
]

{ #category : #'private - notifying' }
Gt2PharoPackagesCoder >> notifyPharoPackageCoderRemoved: aPharoPackageCoder [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (Gt2PharoPackageCoderRemovedAnnouncement new
		pharoPackageCoder: aPharoPackageCoder) 
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoder >> onPharoPackageCoderAdded: aPharoPackageCoder [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aPharoPackageCoder parentPharoPackagesCoder: self.
	self notifyPharoPackageCoderAdded: aPharoPackageCoder.
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoder >> onPharoPackageCoderRemoved: aPharoPackageCoder [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyPharoPackageCoderRemoved: aPharoPackageCoder.
]

{ #category : #'api - pharo packages' }
Gt2PharoPackagesCoder >> onPharoPackagesChanged [
	"Is sent when a new pharoPackages is assigned to the receiver.
	Note: #onPharoPackagesChanged is sent before #subscribeToPharoPackages
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo packages' }
Gt2PharoPackagesCoder >> onPostPharoPackagesChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackages.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - accessing' }
Gt2PharoPackagesCoder >> pharoPackageCoders [
	"Return a collection of objects (${class:Gt2PharoPackageCoder}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #Gt2PharoPackageCoder>
	<childObjectGetter: #package>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  pharoPackageCoders ifNil: [ pharoPackageCoders := self createPharoPackageCoders ]
]

{ #category : #'api - pharo packages' }
Gt2PharoPackagesCoder >> pharoPackages [
	"Return a not-null pharoPackages assigned to the receiver"
	<modelGetter: #pharoPackages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackages notNil ]
		description: [ 'pharoPackages should be initialized' ].

	^ pharoPackages
]

{ #category : #'api - pharo packages' }
Gt2PharoPackagesCoder >> pharoPackages: aPharoPackages [
	"Set a not-null pharoPackages assigned to the receiver"
	<modelSetter: #pharoPackages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackages notNil ]
		description: [ 'pharoPackages must not be nil' ].

	pharoPackages == aPharoPackages
		ifTrue: [ ^ self ].

	pharoPackages ifNotNil: [ self unsubscribeFromPharoPackages ].
	pharoPackages := aPharoPackages.

	self onPharoPackagesChanged.
	self subscribeToPharoPackages.
	self onPostPharoPackagesChanged
]

{ #category : #'private - adding' }
Gt2PharoPackagesCoder >> primitiveAddPharoPackageCoder: aPharoPackageCoder [
	"Is sent right before adding aPharoPackageCoder as my child.
	Override this method to implement primitive addition behavior such as for example adding a new folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#primitiveAddTemplate'>
]

{ #category : #'private - removing' }
Gt2PharoPackagesCoder >> primitiveRemovePharoPackageCoder: aPharoPackageCoder [
	"Is sent right before removing aPharoPackageCoder from my children.
	Override this method to implement primitive removal behavior such as for example removing a folder, file or class"
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#primitiveRemoveTemplate'>
]

{ #category : #printing }
Gt2PharoPackagesCoder >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoPackages
]

{ #category : #'api - adding' }
Gt2PharoPackagesCoder >> removePharoPackageCoder: aPharoPackageCoder [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #package>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesPharoPackageCoders: aPharoPackageCoder)
		ifFalse: [ ^ self ].
	
	self primitiveRemovePharoPackageCoder: aPharoPackageCoder.
	self pharoPackageCoders
		remove: aPharoPackageCoder
		ifAbsent: [ ^ self ].
	self onPharoPackageCoderRemoved: aPharoPackageCoder
]

{ #category : #'api - pharo packages' }
Gt2PharoPackagesCoder >> subscribeToPharoPackages [
	"Is sent after a new pharoPackages is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackages if the receiver subscribes to them"
	<modelSubscriber: #pharoPackages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoder >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo packages' }
Gt2PharoPackagesCoder >> unsubscribeFromPharoPackages [
	"Is sent before a new pharoPackages is assigned to the receiver.
	Objects that subscribe to pharoPackages are required to implement this method."
	<modelUnsubscriber: #pharoPackages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoder >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackagesCoder >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
