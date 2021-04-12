"
! GtPharoClassesCoder View Model
!! Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model (${class:GtPharoClassNavigationViewModel}$) for each domain entity. To do so it accesses the children of the ${method:GtPharoClassesNavigationViewModel>>#pharoClassesCoderModel}$ by sending it ==coders== message. Users can access the child view models via ${method:GtPharoClassesNavigationViewModel>>#pharoClassNavigationViewModels}$. In addition to the parent -> child view model navigation, each child view model knows its parent view model via ${method:GtPharoClassNavigationViewModel>>#parentPharoClassesNavigationViewModel:}$
!! Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - ${method:GtPharoClassesNavigationViewModel>>#parentPharoTagNavigationViewModel}$ returns a parent view model (${class:GtPharoTagNavigationViewModel}$) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - ${method:GtPharoClassesNavigationViewModel>>#parentPharoTagNavigationViewModel:}$ allows users to assign a non-null parent view model (${class:GtPharoTagNavigationViewModel}$).
 - ${method:GtPharoClassesNavigationViewModel>>#hasParentPharoTagNavigationViewModel}$ can be used to test if a parent view model (${class:GtPharoTagNavigationViewModel}$) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using ${method:GtPharoClassesNavigationViewModel>>#hasParentPharoTagNavigationViewModel}$ before trying to access ${method:GtPharoClassesNavigationViewModel>>#parentPharoTagNavigationViewModel}$
"
Class {
	#name : #GtPharoClassesNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoClassesCoderModel + TGtPharoWithSelectedClassViewModel',
	#classTraits : 'TGtWithPharoClassesCoderModel classTrait + TGtPharoWithSelectedClassViewModel classTrait',
	#instVars : [
		'announcer',
		'pharoClassNavigationViewModels',
		'parentPharoTagNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoClassesNavigationViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoTagNavigationViewModel
		ifTrue: [ self parentPharoTagNavigationViewModel announce: anAnnouncement ]
]

{ #category : #'private - instance creation' }
GtPharoClassesNavigationViewModel >> createPharoClassNavigationViewModels [
	"For each child from the domain modal create a view model and return a resulting collection"
	<return: #Collection of: #GtPharoClassNavigationViewModel>
	
	^ self pharoClassesCoderModel coders collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := GtPharoClassNavigationViewModel new.
		eachViewModel parentPharoClassesNavigationViewModel: self.
		eachViewModel pharoBehaviorCoderModel: eachModel ] as: Array
]

{ #category : #'gt-extentions' }
GtPharoClassesNavigationViewModel >> gtClassesListViewFor: aView [
	<gtView>
	
	^ aView list
		priority: 5;
		title: 'Classes';
		items: [ self pharoClassNavigationViewModels ]
]

{ #category : #'api - accessing' }
GtPharoClassesNavigationViewModel >> hasParentPharoTagNavigationViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester>

	^ parentPharoTagNavigationViewModel notNil
]

{ #category : #'api - testing' }
GtPharoClassesNavigationViewModel >> isPharoClassNavigationViewModel [
	"Return true if this is a view model of Class, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoClassesNavigationViewModel >> isPharoClassesNavigationViewModel [
	"Return true if this is a view model of Classes, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoClassesNavigationViewModel >> isPharoPackageNavigationViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoClassesNavigationViewModel >> isPharoPackagesNavigationViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoClassesNavigationViewModel >> isPharoTagNavigationViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoClassesNavigationViewModel >> isPharoTagsNavigationViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - selected class view model' }
GtPharoClassesNavigationViewModel >> notifySelectedClassViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedClassViewModel>

	self announce: GtPharoNavigationSelectedClassViewModelChanged new
]

{ #category : #'api - selected class view model' }
GtPharoClassesNavigationViewModel >> onNewSelectedClassViewModelSet: aNewSelectedClassViewModel [
	"Is sent after a new value of the selectedClassViewModel is assigned"
	<propertySetHook: #selectedClassViewModel>

	self parentPharoTagNavigationViewModel selectTag.
	aNewSelectedClassViewModel notifyClassSelected
]

{ #category : #'api - selected class view model' }
GtPharoClassesNavigationViewModel >> onPreviousSelectedClassViewModelUnset: aPreviousSelectedClassViewModel [
	"Is sent after a previous value of the selectedClassViewModel is de-assigned"
	<propertyUnsetHook: #selectedClassViewModel>

	aPreviousSelectedClassViewModel deselectOtherEntities.
	aPreviousSelectedClassViewModel notifyClassDeselected
]

{ #category : #'api - accessing' }
GtPharoClassesNavigationViewModel >> parentPharoTagNavigationViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoTagNavigationViewModel>
	<parentViewModelGetter>

	self
		assert: [ parentPharoTagNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoTagNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoClassesNavigationViewModel >> parentPharoTagNavigationViewModel: aGtPharoTagNavigationViewModel [
	"Assign a parent view model (${class:GtPharoTagNavigationViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"

	self
		assert: [ aGtPharoTagNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoTagNavigationViewModel := aGtPharoTagNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoClassesNavigationViewModel >> pharoClassNavigationViewModels [
	"Return a collection of view models (${class:GtPharoClassNavigationViewModel}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #GtPharoClassNavigationViewModel>

	^  pharoClassNavigationViewModels ifNil: [ pharoClassNavigationViewModels := self createPharoClassNavigationViewModels ]
]

{ #category : #printing }
GtPharoClassesNavigationViewModel >> printOn: aStream [
	aStream
		print: self pharoClassesCoderModel
]

{ #category : #'api - announcer' }
GtPharoClassesNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoClassesNavigationViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #classes
]

{ #category : #'api - announcer' }
GtPharoClassesNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoClassesNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
