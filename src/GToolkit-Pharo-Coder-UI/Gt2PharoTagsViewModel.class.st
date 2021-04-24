"
! GtPharoPackageTagsCoder View Model
!! Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model (${class:Gt2PharoTagViewModel}$) for each domain entity. To do so it accesses the children of the ${method:Gt2PharoTagsViewModel>>#pharoPackageTagsCoderModel}$ by sending it ==yourself== message. Users can access the child view models via ${method:Gt2PharoTagsViewModel>>#pharoTagViewModels}$. In addition to the parent -> child view model navigation, each child view model knows its parent view model via ${method:Gt2PharoTagViewModel>>#parentPharoTagsViewModel:}$
"
Class {
	#name : #Gt2PharoTagsViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagsCoderModel',
	#classTraits : 'TGtWithPharoPackageTagsCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoTagViewModels'
	],
	#category : #'GToolkit-Pharo-Coder-UI-!  - View Models'
}

{ #category : #'api - announcer' }
Gt2PharoTagsViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ]
]

{ #category : #'private - instance creation' }
Gt2PharoTagsViewModel >> createPharoTagViewModels [
	"For each child from the domain modal create a view model and return a resulting collection"
	<return: #Collection of: #Gt2PharoTagViewModel>
	
	^ self pharoPackageTagsCoderModel yourself collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := Gt2PharoTagViewModel new.
		eachViewModel parentPharoTagsViewModel: self.
		eachViewModel pharoPackageTagCoderModel: eachModel ] as: Array
]

{ #category : #'api - testing' }
Gt2PharoTagsViewModel >> isPharoTagViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
Gt2PharoTagsViewModel >> isPharoTagsViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - accessing' }
Gt2PharoTagsViewModel >> pharoTagViewModels [
	"Return a collection of view models (${class:Gt2PharoTagViewModel}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #Gt2PharoTagViewModel>

	^  pharoTagViewModels ifNil: [ pharoTagViewModels := self createPharoTagViewModels ]
]

{ #category : #printing }
Gt2PharoTagsViewModel >> printOn: aStream [
	aStream
		print: self pharoPackageTagsCoderModel
]

{ #category : #'api - announcer' }
Gt2PharoTagsViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
Gt2PharoTagsViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #tags
]

{ #category : #'api - announcer' }
Gt2PharoTagsViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
Gt2PharoTagsViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
