Class {
	#name : #Gt2PharoPackageCoderViewModel,
	#superclass : #Object,
	#traits : 'TGt2WithPharoPackageCoder',
	#classTraits : 'TGt2WithPharoPackageCoder classTrait',
	#instVars : [
		'pharoPackageViewsCoderViewModel',
		'pharoPackageActionsCoderViewModel',
		'parentPharoPackagesCoderViewModel',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - View Models'
}

{ #category : #'api - announcer' }
Gt2PharoPackageCoderViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentPharoPackagesCoderViewModel
		ifTrue: [ self parentPharoPackagesCoderViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
Gt2PharoPackageCoderViewModel >> createPharoPackageActionsCoderViewModel [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #Gt2PharoPackageActionsCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := Gt2PharoPackageActionsCoderViewModel new.
	childObject parentPharoPackageCoderViewModel: self.
	childObject pharoPackageActionCoderViewModels: self pharoPackageCoder yourself.
	^ childObject
]

{ #category : #'private - instance creation' }
Gt2PharoPackageCoderViewModel >> createPharoPackageViewsCoderViewModel [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #Gt2PharoPackageViewsCoderViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := Gt2PharoPackageViewsCoderViewModel new.
	childObject parentPharoPackageCoderViewModel: self.
	childObject phlowViews: self pharoPackageCoder gtPackageViews.
	^ childObject
]

{ #category : #'gt-extentions' }
Gt2PharoPackageCoderViewModel >> gtPackageActionsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'PackageActions';
		items: [ self pharoPackageActionsCoderViewModel pharoPackageActionCoderViewModels ]
]

{ #category : #'gt-extentions' }
Gt2PharoPackageCoderViewModel >> gtPackageViewsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'PackageViews';
		items: [ self pharoPackageViewsCoderViewModel pharoPackageViewCoderViewModels ]
]

{ #category : #'api - testing' }
Gt2PharoPackageCoderViewModel >> hasParentPharoPackagesCoderViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentPharoPackagesCoderViewModel notNil
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderViewModel >> objectName [
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>
	<generatedFrom: #'GtRobocoderMetamodelNameDerive>>#objectNameTemplate'>

	^ #package
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderViewModel >> parentPharoPackagesCoderViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #Gt2PharoPackagesCoderViewModel>
	<parentObjectGetter: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentPharoPackagesCoderViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentPharoPackagesCoderViewModel
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderViewModel >> parentPharoPackagesCoderViewModel: aGt2PharoPackagesCoderViewModel [
	"Assign a parent object (${class:Gt2PharoPackagesCoderViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #packages>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGt2PharoPackagesCoderViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackagesCoderViewModel := aGt2PharoPackagesCoderViewModel
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderViewModel >> pharoPackageActionsCoderViewModel [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #Gt2PharoPackageActionsCoderViewModel>
	<childObjectGetter: #packageActions>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ pharoPackageActionsCoderViewModel ifNil: [ pharoPackageActionsCoderViewModel := self createPharoPackageActionsCoderViewModel ]
]

{ #category : #'api - accessing' }
Gt2PharoPackageCoderViewModel >> pharoPackageViewsCoderViewModel [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #Gt2PharoPackageViewsCoderViewModel>
	<childObjectGetter: #packageViews>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ pharoPackageViewsCoderViewModel ifNil: [ pharoPackageViewsCoderViewModel := self createPharoPackageViewsCoderViewModel ]
]

{ #category : #printing }
Gt2PharoPackageCoderViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self pharoPackageCoder
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoderViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoPackageCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
