"
# GtPharoPackagesCoder View Model
## Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model ({{gtClass:GtPharoPackageCoderViewModel}}) for each domain entity. To do so it accesses the children of the {{gtMethod:GtPharoPackagesCoderViewModel>>#pharoPackagesCoderModel}} by sending it `coders` message. Users can access the child view models via {{gtMethod:GtPharoPackagesCoderViewModel>>#pharoPackageCoderViewModels}}. In addition to the parent -> child view model navigation, each child view model knows its parent view model via {{gtMethod:GtPharoPackageCoderViewModel>>#parentPharoPackagesCoderViewModel:}}

"
Class {
	#name : #GtPharoPackagesCoderViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackagesCoderModel',
	#classTraits : 'TGtWithPharoPackagesCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageCoderViewModels'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - announcer' }
GtPharoPackagesCoderViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ]
]

{ #category : #converting }
GtPharoPackagesCoderViewModel >> asElement [
	^ GtPackagesCoderElement new codersUIModel: self
]

{ #category : #deprecated }
GtPharoPackagesCoderViewModel >> coder [
	^ self pharoPackagesCoderModel
]

{ #category : #'private - instance creation' }
GtPharoPackagesCoderViewModel >> createPharoPackageCoderViewModels [
	"For each child from the domain modal create a view model and return a resulting collection"
	<return: #Collection of: #GtPharoPackageCoderViewModel>
	
	^ self pharoPackagesCoderModel coders collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := GtPharoPackageCoderViewModel new.
		eachViewModel parentPharoPackagesCoderViewModel: self.
		eachViewModel pharoPackageTagCoderModel: eachModel ] as: Array
]

{ #category : #'api - testing' }
GtPharoPackagesCoderViewModel >> isPharoPackageCoderViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesCoderViewModel >> isPharoPackageTagCoderViewModel [
	"Return true if this is a view model of PackageTag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesCoderViewModel >> isPharoPackageTagsCoderViewModel [
	"Return true if this is a view model of PackageTags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesCoderViewModel >> isPharoPackagesCoderViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - accessing' }
GtPharoPackagesCoderViewModel >> pharoPackageCoderViewModels [
	"Return a collection of view models (${class:GtPharoPackageCoderViewModel}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #GtPharoPackageCoderViewModel>

	^  pharoPackageCoderViewModels ifNil: [ pharoPackageCoderViewModels := self createPharoPackageCoderViewModels ]
]

{ #category : #printing }
GtPharoPackagesCoderViewModel >> printOn: aStream [
	aStream
		print: self pharoPackagesCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackagesCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoPackagesCoderViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #packages
]

{ #category : #'api - announcer' }
GtPharoPackagesCoderViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoPackagesCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
