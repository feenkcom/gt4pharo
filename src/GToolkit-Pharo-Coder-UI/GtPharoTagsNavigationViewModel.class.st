"
# GtPharoPackageTagCoders View Model
## Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model ({{gtClass:GtPharoTagNavigationViewModel}}) for each domain entity. To do so it accesses the children of the {{gtMethod:GtPharoTagsNavigationViewModel>>#pharoPackageTagsCoderModel}} by sending it `coders` message. Users can access the child view models via {{gtMethod:GtPharoTagsNavigationViewModel>>#pharoTagNavigationViewModels}}. In addition to the parent -> child view model navigation, each child view model knows its parent view model via {{gtMethod:GtPharoTagNavigationViewModel>>#parentPharoTagsNavigationViewModel:}}
## Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - {{gtMethod:GtPharoTagsNavigationViewModel>>#parentPharoPackageNavigationViewModel}} returns a parent view model ({{gtClass:GtPharoPackageNavigationViewModel}}) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - {{gtMethod:GtPharoTagsNavigationViewModel>>#parentPharoPackageNavigationViewModel:}} allows users to assign a non-null parent view model ({{gtClass:GtPharoPackageNavigationViewModel}}).
 - {{gtMethod:GtPharoTagsNavigationViewModel>>#hasParentPharoPackageNavigationViewModel}} can be used to test if a parent view model ({{gtClass:GtPharoPackageNavigationViewModel}}) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using {{gtMethod:GtPharoTagsNavigationViewModel>>#hasParentPharoPackageNavigationViewModel}} before trying to access {{gtMethod:GtPharoTagsNavigationViewModel>>#parentPharoPackageNavigationViewModel}}

"
Class {
	#name : #GtPharoTagsNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagsCoderModel + TGtPharoWithSelectedTagViewModel',
	#classTraits : 'TGtWithPharoPackageTagsCoderModel classTrait + TGtPharoWithSelectedTagViewModel classTrait',
	#instVars : [
		'announcer',
		'pharoTagNavigationViewModels',
		'parentPharoPackageNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoTagsNavigationViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoPackageNavigationViewModel
		ifTrue: [ self parentPharoPackageNavigationViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
GtPharoTagsNavigationViewModel >> createPharoTagNavigationViewModels [
	"For each child from the domain modal create a view model and return a resulting collection"
	<return: #Collection of: #GtPharoTagNavigationViewModel>
	
	^ self pharoPackageTagsCoderModel coders collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := GtPharoTagNavigationViewModel new.
		eachViewModel parentPharoTagsNavigationViewModel: self.
		eachViewModel pharoPackageTagCoderModel: eachModel ] as: Array
]

{ #category : #'gt-extentions' }
GtPharoTagsNavigationViewModel >> gtTagsListViewFor: aView [
	<gtView>
	
	^ aView list
		priority: 5;
		title: 'Tags';
		items: [ self pharoTagNavigationViewModels ]
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> hasParentPharoPackageNavigationViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #package>

	^ parentPharoPackageNavigationViewModel notNil
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	"Return true if this is a view model of Behavior, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	"Return true if this is a view model of Behaviors, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoPackageNavigationViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoPackagesNavigationViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoTagNavigationViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoTagsNavigationViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - selected tag view model' }
GtPharoTagsNavigationViewModel >> notifySelectedTagViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedTagViewModel>

	self announce: GtPharoNavigationSelectedTagViewModelChanged new
]

{ #category : #'api - selected tag view model' }
GtPharoTagsNavigationViewModel >> onNewSelectedTagViewModelSet: aNewSelectedTagViewModel [
	"Is sent after a new value of the selectedTagViewModel is assigned"
	<propertySetHook: #selectedTagViewModel>

	self hasParentPharoPackageNavigationViewModel
		ifTrue: [ self parentPharoPackageNavigationViewModel selectPackageWithExtension ].
	aNewSelectedTagViewModel notifyTagSelected
]

{ #category : #'api - selected tag view model' }
GtPharoTagsNavigationViewModel >> onPreviousSelectedTagViewModelUnset: aPreviousSelectedTagViewModel [
	"Is sent after a previous value of the selectedTagViewModel is de-assigned"
	<propertyUnsetHook: #selectedTagViewModel>

	aPreviousSelectedTagViewModel deselectOtherEntities.
	aPreviousSelectedTagViewModel notifyTagDeselected
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> parentPharoPackageNavigationViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoPackageNavigationViewModel>
	<parentViewModelGetter: #package>

	self
		assert: [ parentPharoPackageNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoPackageNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> parentPharoPackageNavigationViewModel: aGtPharoPackageNavigationViewModel [
	"Assign a parent view model (${class:GtPharoPackageNavigationViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	<parentViewModelSetter: #package>

	self
		assert: [ aGtPharoPackageNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackageNavigationViewModel := aGtPharoPackageNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> pharoTagNavigationViewModels [
	"Return a collection of view models (${class:GtPharoTagNavigationViewModel}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #GtPharoTagNavigationViewModel>

	^  pharoTagNavigationViewModels ifNil: [ pharoTagNavigationViewModels := self createPharoTagNavigationViewModels ]
]

{ #category : #printing }
GtPharoTagsNavigationViewModel >> printOn: aStream [
	aStream
		print: self pharoPackageTagsCoderModel
]

{ #category : #'api - announcer' }
GtPharoTagsNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #tags
]

{ #category : #'api - announcer' }
GtPharoTagsNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoTagsNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
