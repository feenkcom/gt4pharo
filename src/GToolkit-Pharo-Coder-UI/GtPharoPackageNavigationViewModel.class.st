"
! GtPharoPackageCoder View Model
!! Accessing a view model for ==packageTagsCoder== domain model
${class:GtPharoPackageNavigationViewModel}$ is a view model for a ==pharoPackageCoderModel== domain model which in turn contains ==packageTagsCoder== domain model. To accomodate that child domain model, a corresponding ${class:GtPharoTagsNavigationViewModel}$ is created and assigned as the child view model of ${class:GtPharoPackageNavigationViewModel}$.
That child view model is instantiated lazily by ${method:GtPharoPackageNavigationViewModel>>#createPharoTagsNavigationViewModel}$ and can be accessed with the help of ${method:GtPharoPackageNavigationViewModel>>#pharoTagsNavigationViewModel}$.
!! Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - ${method:GtPharoPackageNavigationViewModel>>#parentPharoPackagesNavigationViewModel}$ returns a parent view model (${class:GtPharoPackagesNavigationViewModel}$) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - ${method:GtPharoPackageNavigationViewModel>>#parentPharoPackagesNavigationViewModel:}$ allows users to assign a non-null parent view model (${class:GtPharoPackagesNavigationViewModel}$).
 - ${method:GtPharoPackageNavigationViewModel>>#hasParentPharoPackagesNavigationViewModel}$ can be used to test if a parent view model (${class:GtPharoPackagesNavigationViewModel}$) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using ${method:GtPharoPackageNavigationViewModel>>#hasParentPharoPackagesNavigationViewModel}$ before trying to access ${method:GtPharoPackageNavigationViewModel>>#parentPharoPackagesNavigationViewModel}$
!! Additional ==selectedPackageViewModel== api for a child view model
${class:GtPharoPackageNavigationViewModel}$ is a child of the ${class:GtPharoPackagesNavigationViewModel}$ which supports ==selectedPackageViewModel== property. Since that property is a single choice out of many, it is useful for the child view model to implement an additional api to ease the wor process with the property.
A few of the most useful api methods are:
 - ${method:GtPharoPackageNavigationViewModel>>#isSelectedPackage}$ allows users to check if a particular child view model is the property value of the the parent view model (${method:GtPharoPackagesNavigationViewModel>>#selectedPackageViewModel}$).
 - ${method:GtPharoPackageNavigationViewModel>>#isOnlySelectedPackage}$ allows users to check if a particular child view model is the property value of the the parent view model (${method:GtPharoPackagesNavigationViewModel>>#selectedPackageViewModel}$) and that thre are no child view models of ${class:GtPharoPackageNavigationViewModel}$ that have the sasme property ==selectedPackageViewModel== set.
 - ${method:GtPharoPackageNavigationViewModel>>#deselectOtherEntities}$ ensures that none of the ${class:GtPharoPackageNavigationViewModel}$ child view models have ==selectedPackageViewModel== property set. It is useful when users want to make sure that some view model is a leaf in the hierarchy of view models with which have assigned ==selectedPackageViewModel== property.
 - ${method:GtPharoPackageNavigationViewModel>>#notifyPackageSelected}$ sends an announcement (${class:GtPharoPackageNavigationViewModelSelected}$) indicating that the child view model is now the property value in the parent view model (${method:GtPharoPackagesNavigationViewModel>>#selectedPackageViewModel}$). At this point ${method:GtPharoPackageNavigationViewModel>>#isSelectedPackage}$ returns ==true==.
 - ${method:GtPharoPackageNavigationViewModel>>#notifyPackageDeselected}$ sends an announcement (${class:GtPharoPackageNavigationViewModelDeselected}$) indicating that the child view model is no more the property value in the parent view model (${method:GtPharoPackagesNavigationViewModel>>#selectedPackageViewModel}$). At this point ${method:GtPharoPackageNavigationViewModel>>#isSelectedPackage}$ returns ==false==.
"
Class {
	#name : #GtPharoPackageNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageCoderModel',
	#classTraits : 'TGtWithPharoPackageCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoTagsNavigationViewModel',
		'parentPharoPackagesNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoPackageNavigationViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoPackagesNavigationViewModel
		ifTrue: [ self parentPharoPackagesNavigationViewModel announce: anAnnouncement ]
]

{ #category : #'private - instance creation' }
GtPharoPackageNavigationViewModel >> createPharoTagsNavigationViewModel [
	"Create a composite view model for a collection of children and return the result"
	<return: #GtPharoTagsNavigationViewModel>
	| childrenViewModel |

	childrenViewModel := GtPharoTagsNavigationViewModel new.
	childrenViewModel parentPharoPackageNavigationViewModel: self.
	childrenViewModel pharoPackageTagsCoderModel: self pharoPackageCoderModel packageTagsCoder.
	^ childrenViewModel
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> deselectOtherEntities [
	"deselect any selected child"
	<propertyUnsetOthers: #selectedPackageViewModel>

	self pharoTagsNavigationViewModel deselectTagViewModel.
]

{ #category : #'gt-extentions' }
GtPharoPackageNavigationViewModel >> gtTagsListViewFor: aView [
	<gtView>
	
	^ aView list
		priority: 5;
		title: 'Tags';
		items: [ self pharoTagsNavigationViewModel pharoTagNavigationViewModels]
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedPackageViewModel>

	^ self pharoTagsNavigationViewModel hasSelectedTagViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> hasParentPharoPackagesNavigationViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester>

	^ parentPharoPackagesNavigationViewModel notNil
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> isOnlySelectedPackage [
	"Return true if only this package is selected and not any of the children"
	<return: #Boolean>

	^ self isSelectedPackage and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoClassNavigationViewModel [
	"Return true if this is a view model of Class, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoClassesNavigationViewModel [
	"Return true if this is a view model of Classes, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoPackageNavigationViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoPackagesNavigationViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoTagNavigationViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoTagsNavigationViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> isSelectedPackage [
	"Return true if this package is selected"
	<return: #Boolean>

	^ self parentPharoPackagesNavigationViewModel hasSelectedPackageViewModel
		and: [ self parentPharoPackagesNavigationViewModel selectedPackageViewModel == self ]
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> notifyPackageDeselected [
	<propertyUnsetNotifier: #selectedPackageViewModel>

	self announce: (GtPharoPackageNavigationViewModelDeselected new packageViewModel: self)
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> notifyPackageSelected [
	<propertySetNotifier: #selectedPackageViewModel>

	self announce: (GtPharoPackageNavigationViewModelSelected new packageViewModel: self)
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> parentPharoPackagesNavigationViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoPackagesNavigationViewModel>
	<parentViewModelGetter>

	self
		assert: [ parentPharoPackagesNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoPackagesNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> parentPharoPackagesNavigationViewModel: aGtPharoPackagesNavigationViewModel [
	"Assign a parent view model (${class:GtPharoPackagesNavigationViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"

	self
		assert: [ aGtPharoPackagesNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackagesNavigationViewModel := aGtPharoPackagesNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> pharoTagsNavigationViewModel [
	"Return a composite view model (${class:GtPharoTagsNavigationViewModel}$) created for a collection of children from the domain model.
	Note: The view model is lazily instantiated."
	<return: #GtPharoTagsNavigationViewModel>

	^  pharoTagsNavigationViewModel ifNil: [ pharoTagsNavigationViewModel := self createPharoTagsNavigationViewModel ]
]

{ #category : #printing }
GtPharoPackageNavigationViewModel >> printOn: aStream [
	aStream
		print: self pharoPackageCoderModel
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> selectPackage [
	"Just select a package without changing children"
	<propertySetter: #selectedPackageViewModel>

	self parentPharoPackagesNavigationViewModel selectPackageViewModel: self
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> selectPackageWithoutOtherEntities [
	"Select a package and deselect other selected children"

	self deselectOtherEntities.
	self selectPackage
]

{ #category : #'api - announcer' }
GtPharoPackageNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #package
]

{ #category : #'api - announcer' }
GtPharoPackageNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoPackageNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
