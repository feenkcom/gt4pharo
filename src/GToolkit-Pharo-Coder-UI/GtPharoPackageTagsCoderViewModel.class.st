"
# GtPharoPackageTagsCoder View Model
## Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model ({{gtClass:GtPharoPackageTagCoderViewModel}}) for each domain entity. To do so it accesses the children of the {{gtMethod:GtPharoPackageTagsCoderViewModel>>#pharoPackageTagsCoderModel}} by sending it `coders` message. Users can access the child view models via {{gtMethod:GtPharoPackageTagsCoderViewModel>>#pharoPackageTagCoderViewModels}}. In addition to the parent -> child view model navigation, each child view model knows its parent view model via {{gtMethod:GtPharoPackageTagCoderViewModel>>#parentPharoPackageTagsCoderViewModel:}}
## Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - {{gtMethod:GtPharoPackageTagsCoderViewModel>>#parentPharoPackageCoderViewModel}} returns a parent view model ({{gtClass:GtPharoPackageCoderViewModel}}) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - {{gtMethod:GtPharoPackageTagsCoderViewModel>>#parentPharoPackageCoderViewModel:}} allows users to assign a non-null parent view model ({{gtClass:GtPharoPackageCoderViewModel}}).
 - {{gtMethod:GtPharoPackageTagsCoderViewModel>>#hasParentPharoPackageCoderViewModel}} can be used to test if a parent view model ({{gtClass:GtPharoPackageCoderViewModel}}) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using {{gtMethod:GtPharoPackageTagsCoderViewModel>>#hasParentPharoPackageCoderViewModel}} before trying to access {{gtMethod:GtPharoPackageTagsCoderViewModel>>#parentPharoPackageCoderViewModel}}

"
Class {
	#name : #GtPharoPackageTagsCoderViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagsCoderModel',
	#classTraits : 'TGtWithPharoPackageTagsCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageTagCoderViewModels',
		'parentPharoPackageCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - announcer' }
GtPharoPackageTagsCoderViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoPackageCoderViewModel
		ifTrue: [ self parentPharoPackageCoderViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
GtPharoPackageTagsCoderViewModel >> createPharoPackageTagCoderViewModels [
	"For each child from the domain modal create a view model and return a resulting collection"
	<return: #Collection of: #GtPharoPackageTagCoderViewModel>
	
	^ self pharoPackageTagsCoderModel coders collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := GtPharoPackageTagCoderViewModel new.
		eachViewModel parentPharoPackageTagsCoderViewModel: self.
		eachViewModel pharoPackageTagCoderModel: eachModel ] as: Array
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> hasParentPharoPackageCoderViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #package>

	^ parentPharoPackageCoderViewModel notNil
]

{ #category : #'api - testing' }
GtPharoPackageTagsCoderViewModel >> isPharoPackageCoderViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageTagsCoderViewModel >> isPharoPackageTagCoderViewModel [
	"Return true if this is a view model of PackageTag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageTagsCoderViewModel >> isPharoPackageTagsCoderViewModel [
	"Return true if this is a view model of PackageTags, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoPackageTagsCoderViewModel >> isPharoPackagesCoderViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> parentPharoPackageCoderViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoPackageCoderViewModel>
	<parentViewModelGetter: #package>

	self
		assert: [ parentPharoPackageCoderViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoPackageCoderViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> parentPharoPackageCoderViewModel: aGtPharoPackageCoderViewModel [
	"Assign a parent view model (${class:GtPharoPackageCoderViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	<parentViewModelSetter: #package>

	self
		assert: [ aGtPharoPackageCoderViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackageCoderViewModel := aGtPharoPackageCoderViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> pharoPackageTagCoderViewModels [
	"Return a collection of view models (${class:GtPharoPackageTagCoderViewModel}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #GtPharoPackageTagCoderViewModel>

	^  pharoPackageTagCoderViewModels ifNil: [ pharoPackageTagCoderViewModels := self createPharoPackageTagCoderViewModels ]
]

{ #category : #printing }
GtPharoPackageTagsCoderViewModel >> printOn: aStream [
	aStream
		print: self pharoPackageTagsCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackageTagsCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #packageTags
]

{ #category : #'api - announcer' }
GtPharoPackageTagsCoderViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoPackageTagsCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
