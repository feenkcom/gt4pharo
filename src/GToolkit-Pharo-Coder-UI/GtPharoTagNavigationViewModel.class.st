"
! GtPharoPackageTagCoder View Model
!! Accessing a view model for ==classesCoder== domain model
${class:GtPharoTagNavigationViewModel}$ is a view model for a ==pharoPackageTagCoderModel== domain model which in turn contains ==classesCoder== domain model. To accomodate that child domain model, a corresponding ${class:GtPharoClassesNavigationViewModel}$ is created and assigned as the child view model of ${class:GtPharoTagNavigationViewModel}$.
That child view model is instantiated lazily by ${method:GtPharoTagNavigationViewModel>>#createPharoClassesNavigationViewModel}$ and can be accessed with the help of ${method:GtPharoTagNavigationViewModel>>#pharoClassesNavigationViewModel}$.
!! Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - ${method:GtPharoTagNavigationViewModel>>#parentPharoTagsNavigationViewModel}$ returns a parent view model (${class:GtPharoTagsNavigationViewModel}$) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - ${method:GtPharoTagNavigationViewModel>>#parentPharoTagsNavigationViewModel:}$ allows users to assign a non-null parent view model (${class:GtPharoTagsNavigationViewModel}$).
 - ${method:GtPharoTagNavigationViewModel>>#hasParentPharoTagsNavigationViewModel}$ can be used to test if a parent view model (${class:GtPharoTagsNavigationViewModel}$) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using ${method:GtPharoTagNavigationViewModel>>#hasParentPharoTagsNavigationViewModel}$ before trying to access ${method:GtPharoTagNavigationViewModel>>#parentPharoTagsNavigationViewModel}$
!! Additional ==selectedTagViewModel== api for a child view model
${class:GtPharoTagNavigationViewModel}$ is a child of the ${class:GtPharoTagsNavigationViewModel}$ which supports ==selectedTagViewModel== property. Since that property is a single choice out of many, it is useful for the child view model to implement an additional api to ease the wor process with the property.
A few of the most useful api methods are:
 - ${method:GtPharoTagNavigationViewModel>>#isSelectedTag}$ allows users to check if a particular child view model is the property value of the the parent view model (${method:GtPharoTagsNavigationViewModel>>#selectedTagViewModel}$).
 - ${method:GtPharoTagNavigationViewModel>>#isOnlySelectedTag}$ allows users to check if a particular child view model is the property value of the the parent view model (${method:GtPharoTagsNavigationViewModel>>#selectedTagViewModel}$) and that thre are no child view models of ${class:GtPharoTagNavigationViewModel}$ that have the sasme property ==selectedTagViewModel== set.
 - ${method:GtPharoTagNavigationViewModel>>#deselectOtherEntities}$ ensures that none of the ${class:GtPharoTagNavigationViewModel}$ child view models have ==selectedTagViewModel== property set. It is useful when users want to make sure that some view model is a leaf in the hierarchy of view models with which have assigned ==selectedTagViewModel== property.
 - ${method:GtPharoTagNavigationViewModel>>#notifyTagSelected}$ sends an announcement (${class:GtPharoTagNavigationViewModelSelected}$) indicating that the child view model is now the property value in the parent view model (${method:GtPharoTagsNavigationViewModel>>#selectedTagViewModel}$). At this point ${method:GtPharoTagNavigationViewModel>>#isSelectedTag}$ returns ==true==.
 - ${method:GtPharoTagNavigationViewModel>>#notifyTagDeselected}$ sends an announcement (${class:GtPharoTagNavigationViewModelDeselected}$) indicating that the child view model is no more the property value in the parent view model (${method:GtPharoTagsNavigationViewModel>>#selectedTagViewModel}$). At this point ${method:GtPharoTagNavigationViewModel>>#isSelectedTag}$ returns ==false==.
"
Class {
	#name : #GtPharoTagNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagCoderModel',
	#classTraits : 'TGtWithPharoPackageTagCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoClassesNavigationViewModel',
		'parentPharoTagsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoTagNavigationViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoTagsNavigationViewModel
		ifTrue: [ self parentPharoTagsNavigationViewModel announce: anAnnouncement ]
]

{ #category : #'private - instance creation' }
GtPharoTagNavigationViewModel >> createPharoClassesNavigationViewModel [
	"Create a composite view model for a collection of children and return the result"
	<return: #GtPharoClassesNavigationViewModel>
	| childrenViewModel |

	childrenViewModel := GtPharoClassesNavigationViewModel new.
	childrenViewModel parentPharoTagNavigationViewModel: self.
	childrenViewModel pharoClassesCoderModel: self pharoPackageTagCoderModel classesCoder.
	^ childrenViewModel
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> deselectOtherEntities [
	"deselect any selected child"
	<propertyUnsetOthers: #selectedTagViewModel>

	self pharoClassesNavigationViewModel deselectClassViewModel.
]

{ #category : #'gt-extentions' }
GtPharoTagNavigationViewModel >> gtClassesListViewFor: aView [
	<gtView>
	
	^ aView list
		priority: 5;
		title: 'Classes';
		items: [ self pharoClassesNavigationViewModel pharoClassNavigationViewModels]
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedTagViewModel>

	^ self pharoClassesNavigationViewModel hasSelectedClassViewModel
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> hasParentPharoTagsNavigationViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester>

	^ parentPharoTagsNavigationViewModel notNil
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> isOnlySelectedTag [
	"Return true if only this tag is selected and not any of the children"
	<return: #Boolean>

	^ self isSelectedTag and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoClassNavigationViewModel [
	"Return true if this is a view model of Class, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoClassesNavigationViewModel [
	"Return true if this is a view model of Classes, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoPackageNavigationViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoPackagesNavigationViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoTagNavigationViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoTagsNavigationViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> isSelectedTag [
	"Return true if this tag is selected"
	<return: #Boolean>

	^ self parentPharoTagsNavigationViewModel hasSelectedTagViewModel
		and: [ self parentPharoTagsNavigationViewModel selectedTagViewModel == self ]
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> notifyTagDeselected [
	<propertyUnsetNotifier: #selectedTagViewModel>

	self announce: (GtPharoTagNavigationViewModelDeselected new tagViewModel: self)
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> notifyTagSelected [
	<propertySetNotifier: #selectedTagViewModel>

	self announce: (GtPharoTagNavigationViewModelSelected new tagViewModel: self)
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> parentPharoTagsNavigationViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoTagsNavigationViewModel>
	<parentViewModelGetter>

	self
		assert: [ parentPharoTagsNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoTagsNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> parentPharoTagsNavigationViewModel: aGtPharoTagsNavigationViewModel [
	"Assign a parent view model (${class:GtPharoTagsNavigationViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"

	self
		assert: [ aGtPharoTagsNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoTagsNavigationViewModel := aGtPharoTagsNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> pharoClassesNavigationViewModel [
	"Return a composite view model (${class:GtPharoClassesNavigationViewModel}$) created for a collection of children from the domain model.
	Note: The view model is lazily instantiated."
	<return: #GtPharoClassesNavigationViewModel>

	^  pharoClassesNavigationViewModel ifNil: [ pharoClassesNavigationViewModel := self createPharoClassesNavigationViewModel ]
]

{ #category : #printing }
GtPharoTagNavigationViewModel >> printOn: aStream [
	aStream
		print: self pharoPackageTagCoderModel
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> selectTag [
	"Just select a tag without changing children"
	<propertySetter: #selectedTagViewModel>

	self parentPharoTagsNavigationViewModel selectTagViewModel: self
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> selectTagWithoutOtherEntities [
	"Select a tag and deselect other selected children"

	self deselectOtherEntities.
	self selectTag
]

{ #category : #'api - announcer' }
GtPharoTagNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #tag
]

{ #category : #'api - announcer' }
GtPharoTagNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoTagNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
