"
# GtPharoClassesCoder View Model
## Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model ({{gtClass:GtPharoBehaviorNavigationViewModel}}) for each domain entity. To do so it accesses the children of the {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#pharoClassesCoderModel}} by sending it `coders` message. Users can access the child view models via {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#pharoBehaviorNavigationViewModels}}. In addition to the parent -> child view model navigation, each child view model knows its parent view model via {{gtMethod:GtPharoBehaviorNavigationViewModel>>#parentPharoBehaviorsNavigationViewModel:}}
## Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#parentPharoPackageNavigationViewModel}} returns a parent view model ({{gtClass:GtPharoPackageNavigationViewModel}}) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#parentPharoPackageNavigationViewModel:}} allows users to assign a non-null parent view model ({{gtClass:GtPharoPackageNavigationViewModel}}).
 - {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#hasParentPharoPackageNavigationViewModel}} can be used to test if a parent view model ({{gtClass:GtPharoPackageNavigationViewModel}}) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#hasParentPharoPackageNavigationViewModel}} before trying to access {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#parentPharoPackageNavigationViewModel}}
## Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#parentPharoTagNavigationViewModel}} returns a parent view model ({{gtClass:GtPharoTagNavigationViewModel}}) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#parentPharoTagNavigationViewModel:}} allows users to assign a non-null parent view model ({{gtClass:GtPharoTagNavigationViewModel}}).
 - {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#hasParentPharoTagNavigationViewModel}} can be used to test if a parent view model ({{gtClass:GtPharoTagNavigationViewModel}}) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#hasParentPharoTagNavigationViewModel}} before trying to access {{gtMethod:GtPharoBehaviorsNavigationViewModel>>#parentPharoTagNavigationViewModel}}

"
Class {
	#name : #GtPharoBehaviorsNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoClassesCoderModel + TGtPharoWithSelectedBehaviorViewModel',
	#classTraits : 'TGtWithPharoClassesCoderModel classTrait + TGtPharoWithSelectedBehaviorViewModel classTrait',
	#instVars : [
		'announcer',
		'pharoBehaviorNavigationViewModels',
		'parentPharoPackageNavigationViewModel',
		'parentPharoTagNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoBehaviorsNavigationViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoPackageNavigationViewModel
		ifTrue: [ self parentPharoPackageNavigationViewModel announce: anAnnouncement ].
	self hasParentPharoTagNavigationViewModel
		ifTrue: [ self parentPharoTagNavigationViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
GtPharoBehaviorsNavigationViewModel >> createPharoBehaviorNavigationViewModels [
	"For each child from the domain modal create a view model and return a resulting collection"
	<return: #Collection of: #GtPharoBehaviorNavigationViewModel>
	
	^ self pharoClassesCoderModel coders collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := GtPharoBehaviorNavigationViewModel new.
		eachViewModel parentPharoBehaviorsNavigationViewModel: self.
		eachViewModel pharoBehaviorCoderModel: eachModel ] as: Array
]

{ #category : #'gt-extentions' }
GtPharoBehaviorsNavigationViewModel >> gtBehaviorsListViewFor: aView [
	<gtView>
	
	^ aView list
		priority: 5;
		title: 'Behaviors';
		items: [ self pharoBehaviorNavigationViewModels ]
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> hasParentPharoPackageNavigationViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #package>

	^ parentPharoPackageNavigationViewModel notNil
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> hasParentPharoTagNavigationViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #tag>

	^ parentPharoTagNavigationViewModel notNil
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	"Return true if this is a view model of Behavior, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	"Return true if this is a view model of Behaviors, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoPackageNavigationViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoPackagesNavigationViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoTagNavigationViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoTagsNavigationViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - selected behavior view model' }
GtPharoBehaviorsNavigationViewModel >> notifySelectedBehaviorViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedBehaviorViewModel>

	self announce: GtPharoNavigationSelectedBehaviorViewModelChanged new
]

{ #category : #'api - selected behavior view model' }
GtPharoBehaviorsNavigationViewModel >> onNewSelectedBehaviorViewModelSet: aNewSelectedBehaviorViewModel [
	"Is sent after a new value of the selectedBehaviorViewModel is assigned"
	<propertySetHook: #selectedBehaviorViewModel>

	self hasParentPharoPackageNavigationViewModel
		ifTrue: [ self parentPharoPackageNavigationViewModel selectPackageWithExtension ].
	self hasParentPharoTagNavigationViewModel
		ifTrue: [ self parentPharoTagNavigationViewModel selectTag ].
	aNewSelectedBehaviorViewModel notifyBehaviorSelected
]

{ #category : #'api - selected behavior view model' }
GtPharoBehaviorsNavigationViewModel >> onPreviousSelectedBehaviorViewModelUnset: aPreviousSelectedBehaviorViewModel [
	"Is sent after a previous value of the selectedBehaviorViewModel is de-assigned"
	<propertyUnsetHook: #selectedBehaviorViewModel>

	aPreviousSelectedBehaviorViewModel deselectOtherEntities.
	aPreviousSelectedBehaviorViewModel notifyBehaviorDeselected
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> parentPharoPackageNavigationViewModel [
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
GtPharoBehaviorsNavigationViewModel >> parentPharoPackageNavigationViewModel: aGtPharoPackageNavigationViewModel [
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
GtPharoBehaviorsNavigationViewModel >> parentPharoTagNavigationViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoTagNavigationViewModel>
	<parentViewModelGetter: #tag>

	self
		assert: [ parentPharoTagNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoTagNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> parentPharoTagNavigationViewModel: aGtPharoTagNavigationViewModel [
	"Assign a parent view model (${class:GtPharoTagNavigationViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	<parentViewModelSetter: #tag>

	self
		assert: [ aGtPharoTagNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoTagNavigationViewModel := aGtPharoTagNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> pharoBehaviorNavigationViewModels [
	"Return a collection of view models (${class:GtPharoBehaviorNavigationViewModel}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #GtPharoBehaviorNavigationViewModel>

	^  pharoBehaviorNavigationViewModels ifNil: [ pharoBehaviorNavigationViewModels := self createPharoBehaviorNavigationViewModels ]
]

{ #category : #printing }
GtPharoBehaviorsNavigationViewModel >> printOn: aStream [
	aStream
		print: self pharoClassesCoderModel
]

{ #category : #'api - announcer' }
GtPharoBehaviorsNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #behaviors
]

{ #category : #'api - announcer' }
GtPharoBehaviorsNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoBehaviorsNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
