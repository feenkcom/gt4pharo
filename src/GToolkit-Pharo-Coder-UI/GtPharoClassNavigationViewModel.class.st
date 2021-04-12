"
! GtPharoBehaviorCoder View Model
!! Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - ${method:GtPharoClassNavigationViewModel>>#parentPharoClassesNavigationViewModel}$ returns a parent view model (${class:GtPharoClassesNavigationViewModel}$) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - ${method:GtPharoClassNavigationViewModel>>#parentPharoClassesNavigationViewModel:}$ allows users to assign a non-null parent view model (${class:GtPharoClassesNavigationViewModel}$).
 - ${method:GtPharoClassNavigationViewModel>>#hasParentPharoClassesNavigationViewModel}$ can be used to test if a parent view model (${class:GtPharoClassesNavigationViewModel}$) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using ${method:GtPharoClassNavigationViewModel>>#hasParentPharoClassesNavigationViewModel}$ before trying to access ${method:GtPharoClassNavigationViewModel>>#parentPharoClassesNavigationViewModel}$
!! Additional ==selectedClassViewModel== api for a child view model
${class:GtPharoClassNavigationViewModel}$ is a child of the ${class:GtPharoClassesNavigationViewModel}$ which supports ==selectedClassViewModel== property. Since that property is a single choice out of many, it is useful for the child view model to implement an additional api to ease the wor process with the property.
A few of the most useful api methods are:
 - ${method:GtPharoClassNavigationViewModel>>#isSelectedClass}$ allows users to check if a particular child view model is the property value of the the parent view model (${method:GtPharoClassesNavigationViewModel>>#selectedClassViewModel}$).
 - ${method:GtPharoClassNavigationViewModel>>#isOnlySelectedClass}$ allows users to check if a particular child view model is the property value of the the parent view model (${method:GtPharoClassesNavigationViewModel>>#selectedClassViewModel}$) and that thre are no child view models of ${class:GtPharoClassNavigationViewModel}$ that have the sasme property ==selectedClassViewModel== set.
 - ${method:GtPharoClassNavigationViewModel>>#deselectOtherEntities}$ ensures that none of the ${class:GtPharoClassNavigationViewModel}$ child view models have ==selectedClassViewModel== property set. It is useful when users want to make sure that some view model is a leaf in the hierarchy of view models with which have assigned ==selectedClassViewModel== property.
 - ${method:GtPharoClassNavigationViewModel>>#notifyClassSelected}$ sends an announcement (${class:GtPharoClassNavigationViewModelSelected}$) indicating that the child view model is now the property value in the parent view model (${method:GtPharoClassesNavigationViewModel>>#selectedClassViewModel}$). At this point ${method:GtPharoClassNavigationViewModel>>#isSelectedClass}$ returns ==true==.
 - ${method:GtPharoClassNavigationViewModel>>#notifyClassDeselected}$ sends an announcement (${class:GtPharoClassNavigationViewModelDeselected}$) indicating that the child view model is no more the property value in the parent view model (${method:GtPharoClassesNavigationViewModel>>#selectedClassViewModel}$). At this point ${method:GtPharoClassNavigationViewModel>>#isSelectedClass}$ returns ==false==.
"
Class {
	#name : #GtPharoClassNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoBehaviorCoderModel',
	#classTraits : 'TGtWithPharoBehaviorCoderModel classTrait',
	#instVars : [
		'announcer',
		'parentPharoClassesNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoClassNavigationViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoClassesNavigationViewModel
		ifTrue: [ self parentPharoClassesNavigationViewModel announce: anAnnouncement ]
]

{ #category : #'api - selection' }
GtPharoClassNavigationViewModel >> deselectOtherEntities [
	"deselect any selected child"
	<propertyUnsetOthers: #selectedClassViewModel>
]

{ #category : #'api - selection' }
GtPharoClassNavigationViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedClassViewModel>

	^ false
]

{ #category : #'api - accessing' }
GtPharoClassNavigationViewModel >> hasParentPharoClassesNavigationViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester>

	^ parentPharoClassesNavigationViewModel notNil
]

{ #category : #'api - selection' }
GtPharoClassNavigationViewModel >> isOnlySelectedClass [
	"Return true if only this class is selected and not any of the children"
	<return: #Boolean>

	^ self isSelectedClass and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
GtPharoClassNavigationViewModel >> isPharoClassNavigationViewModel [
	"Return true if this is a view model of Class, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoClassNavigationViewModel >> isPharoClassesNavigationViewModel [
	"Return true if this is a view model of Classes, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoClassNavigationViewModel >> isPharoPackageNavigationViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoClassNavigationViewModel >> isPharoPackagesNavigationViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoClassNavigationViewModel >> isPharoTagNavigationViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoClassNavigationViewModel >> isPharoTagsNavigationViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - selection' }
GtPharoClassNavigationViewModel >> isSelectedClass [
	"Return true if this class is selected"
	<return: #Boolean>

	^ self parentPharoClassesNavigationViewModel hasSelectedClassViewModel
		and: [ self parentPharoClassesNavigationViewModel selectedClassViewModel == self ]
]

{ #category : #'api - selection' }
GtPharoClassNavigationViewModel >> notifyClassDeselected [
	<propertyUnsetNotifier: #selectedClassViewModel>

	self announce: (GtPharoClassNavigationViewModelDeselected new classViewModel: self)
]

{ #category : #'api - selection' }
GtPharoClassNavigationViewModel >> notifyClassSelected [
	<propertySetNotifier: #selectedClassViewModel>

	self announce: (GtPharoClassNavigationViewModelSelected new classViewModel: self)
]

{ #category : #'api - accessing' }
GtPharoClassNavigationViewModel >> parentPharoClassesNavigationViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoClassesNavigationViewModel>
	<parentViewModelGetter>

	self
		assert: [ parentPharoClassesNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoClassesNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoClassNavigationViewModel >> parentPharoClassesNavigationViewModel: aGtPharoClassesNavigationViewModel [
	"Assign a parent view model (${class:GtPharoClassesNavigationViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"

	self
		assert: [ aGtPharoClassesNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoClassesNavigationViewModel := aGtPharoClassesNavigationViewModel
]

{ #category : #printing }
GtPharoClassNavigationViewModel >> printOn: aStream [
	aStream
		print: self pharoBehaviorCoderModel
]

{ #category : #'api - selection' }
GtPharoClassNavigationViewModel >> selectClass [
	"Just select a class without changing children"
	<propertySetter: #selectedClassViewModel>

	self parentPharoClassesNavigationViewModel selectClassViewModel: self
]

{ #category : #'api - selection' }
GtPharoClassNavigationViewModel >> selectClassWithoutOtherEntities [
	"Select a class and deselect other selected children"

	self deselectOtherEntities.
	self selectClass
]

{ #category : #'api - announcer' }
GtPharoClassNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoClassNavigationViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #class
]

{ #category : #'api - announcer' }
GtPharoClassNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoClassNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
