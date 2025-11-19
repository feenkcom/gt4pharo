"
# GtPharoPackagesCoder View Model
## Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model ({{gtClass:GtPharoPackageNavigationViewModel}}) for each domain entity. To do so it accesses the children of the {{gtMethod:GtPharoPackagesNavigationViewModel>>#pharoPackagesCoderModel}} by sending it `coders` message. Users can access the child view models via {{gtMethod:GtPharoPackagesNavigationViewModel>>#pharoPackageNavigationViewModels}}. In addition to the parent -> child view model navigation, each child view model knows its parent view model via {{gtMethod:GtPharoPackageNavigationViewModel>>#parentPharoPackagesNavigationViewModel:}}

"
Class {
	#name : #GtPharoPackagesNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackagesCoderModel + TGtPharoWithSelectedPackageViewModel',
	#classTraits : 'TGtWithPharoPackagesCoderModel classTrait + TGtPharoWithSelectedPackageViewModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageNavigationViewModels'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoPackagesNavigationViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ]
]

{ #category : #'private - instance creation' }
GtPharoPackagesNavigationViewModel >> createPharoPackageNavigationViewModels [
	"For each child from the domain modal create a view model and return a resulting collection"
	<return: #Collection of: #GtPharoPackageNavigationViewModel>
	
	^ self pharoPackagesCoderModel coders collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := GtPharoPackageNavigationViewModel new.
		eachViewModel parentPharoPackagesNavigationViewModel: self.
		eachViewModel pharoPackageCoderModel: eachModel ] as: Array
]

{ #category : #'gt-extentions' }
GtPharoPackagesNavigationViewModel >> gtPackagesListViewFor: aView [
	<gtView>
	
	^ aView list
		priority: 5;
		title: 'Packages';
		items: [ self pharoPackageNavigationViewModels ]
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	"Return true if this is a view model of Behavior, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	"Return true if this is a view model of Behaviors, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoPackageNavigationViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoPackagesNavigationViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoTagNavigationViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoTagsNavigationViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> notifySelectedPackageViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedPackageViewModel>

	self announce: GtPharoNavigationSelectedPackageViewModelChanged new
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> onNewSelectedPackageViewModelSet: aNewSelectedPackageViewModel [
	"Is sent after a new value of the selectedPackageViewModel is assigned"
	<propertySetHook: #selectedPackageViewModel>

	aNewSelectedPackageViewModel notifyPackageSelected
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> onPreviousSelectedPackageViewModelUnset: aPreviousSelectedPackageViewModel [
	"Is sent after a previous value of the selectedPackageViewModel is de-assigned"
	<propertyUnsetHook: #selectedPackageViewModel>

	aPreviousSelectedPackageViewModel deselectOtherEntities.
	aPreviousSelectedPackageViewModel notifyPackageDeselected
]

{ #category : #'api - accessing' }
GtPharoPackagesNavigationViewModel >> pharoPackageNavigationViewModels [
	"Return a collection of view models (${class:GtPharoPackageNavigationViewModel}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #GtPharoPackageNavigationViewModel>

	^  pharoPackageNavigationViewModels ifNil: [ pharoPackageNavigationViewModels := self createPharoPackageNavigationViewModels ]
]

{ #category : #printing }
GtPharoPackagesNavigationViewModel >> printOn: aStream [
	aStream
		print: self pharoPackagesCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackagesNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoPackagesNavigationViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #packages
]

{ #category : #'api - announcer' }
GtPharoPackagesNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoPackagesNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
